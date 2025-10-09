# ============================================================================
# BMG SMARTREACH - SCRIPT DE INSTALAÇÃO COMPLETA (POWERSHELL)
# ============================================================================
# 
# Este script automatiza TODA a configuração necessária para rodar o projeto:
# 1. Verifica/Instala Python 3.11+
# 2. Cria ambiente virtual
# 3. Instala dependências
# 4. Configura Jupyter Notebook
# 5. Abre o notebook automaticamente
#
# USO: 
#   Clique com botão direito no arquivo > "Executar com PowerShell"
#   OU execute no PowerShell: .\setup.ps1
#
# ============================================================================

# Configurações
$ErrorActionPreference = "Stop"
$PYTHON_VERSION_MIN = "3.11"
$PROJECT_NAME = "BMG SmartReach"
$VENV_NAME = "venv"

# Cores para output
function Write-ColorOutput($ForegroundColor) {
    $fc = $host.UI.RawUI.ForegroundColor
    $host.UI.RawUI.ForegroundColor = $ForegroundColor
    if ($args) {
        Write-Output $args
    }
    $host.UI.RawUI.ForegroundColor = $fc
}

function Write-Success { Write-ColorOutput Green $args }
function Write-Info { Write-ColorOutput Cyan $args }
function Write-Warning { Write-ColorOutput Yellow $args }
function Write-Error { Write-ColorOutput Red $args }

# Banner
Clear-Host
Write-Info "================================================================================"
Write-Info "                     BMG SMARTREACH - INSTALAÇÃO AUTOMÁTICA                     "
Write-Info "================================================================================"
Write-Info ""

# ============================================================================
# ETAPA 1: VERIFICAR/INSTALAR PYTHON
# ============================================================================

Write-Info "[ETAPA 1/6] Verificando Python..."
Write-Info ""

try {
    $pythonVersion = python --version 2>&1
    if ($pythonVersion -match "Python (\d+\.\d+)") {
        $installedVersion = [version]$matches[1]
        $minVersion = [version]$PYTHON_VERSION_MIN
        
        if ($installedVersion -ge $minVersion) {
            Write-Success "✓ Python $installedVersion encontrado!"
            $pythonCmd = "python"
        } else {
            Write-Warning "⚠ Python $installedVersion está desatualizado (mínimo: $PYTHON_VERSION_MIN)"
            throw "PythonOutdated"
        }
    }
} catch {
    Write-Warning "⚠ Python não encontrado ou versão incompatível"
    Write-Info ""
    Write-Info "Iniciando instalação do Python 3.12..."
    Write-Info ""
    
    # Download do instalador Python
    $pythonInstallerUrl = "https://www.python.org/ftp/python/3.12.0/python-3.12.0-amd64.exe"
    $pythonInstallerPath = "$env:TEMP\python-installer.exe"
    
    Write-Info "→ Baixando Python 3.12 (pode levar alguns minutos)..."
    try {
        # Usar .NET WebClient para download com progresso
        $webClient = New-Object System.Net.WebClient
        $webClient.DownloadFile($pythonInstallerUrl, $pythonInstallerPath)
        Write-Success "✓ Download concluído!"
    } catch {
        Write-Error "✗ Erro ao baixar Python. Baixe manualmente em: https://www.python.org/downloads/"
        Write-Info "Pressione qualquer tecla para sair..."
        $null = $Host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown")
        exit 1
    }
    
    Write-Info ""
    Write-Info "→ Instalando Python (isso pode levar 2-3 minutos)..."
    Write-Info "   IMPORTANTE: Uma janela do instalador irá abrir."
    Write-Info "   Certifique-se de marcar 'Add Python to PATH'!"
    Write-Info ""
    
    # Instalar Python silenciosamente
    $installArgs = "/quiet InstallAllUsers=1 PrependPath=1 Include_test=0 Include_doc=0"
    Start-Process -FilePath $pythonInstallerPath -ArgumentList $installArgs -Wait
    
    # Limpar instalador
    Remove-Item $pythonInstallerPath -Force
    
    # Recarregar PATH
    $env:Path = [System.Environment]::GetEnvironmentVariable("Path","Machine") + ";" + [System.Environment]::GetEnvironmentVariable("Path","User")
    
    # Verificar instalação
    Start-Sleep -Seconds 3
    try {
        $pythonVersion = python --version 2>&1
        Write-Success "✓ Python instalado com sucesso: $pythonVersion"
        $pythonCmd = "python"
    } catch {
        Write-Error "✗ Erro na instalação do Python"
        Write-Warning "Por favor, instale manualmente: https://www.python.org/downloads/"
        Write-Warning "Certifique-se de marcar 'Add Python to PATH' durante a instalação"
        Write-Info ""
        Write-Info "Pressione qualquer tecla para sair..."
        $null = $Host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown")
        exit 1
    }
}

Write-Info ""
Write-Info "→ Verificando pip (gerenciador de pacotes)..."
try {
    $pipVersion = & $pythonCmd -m pip --version
    Write-Success "✓ pip encontrado: $pipVersion"
} catch {
    Write-Info "→ Instalando pip..."
    & $pythonCmd -m ensurepip --upgrade
    Write-Success "✓ pip instalado!"
}

Write-Info ""
Write-Success "════════════════════════════════════════════════════════════════════════════"
Write-Success "ETAPA 1 CONCLUÍDA: Python configurado com sucesso!"
Write-Success "════════════════════════════════════════════════════════════════════════════"
Start-Sleep -Seconds 2

# ============================================================================
# ETAPA 2: CRIAR AMBIENTE VIRTUAL
# ============================================================================

Write-Info ""
Write-Info "[ETAPA 2/6] Criando ambiente virtual..."
Write-Info ""

if (Test-Path $VENV_NAME) {
    Write-Warning "⚠ Ambiente virtual já existe"
    $response = Read-Host "Deseja recriar? (S/N)"
    if ($response -eq "S" -or $response -eq "s") {
        Write-Info "→ Removendo ambiente antigo..."
        Remove-Item -Recurse -Force $VENV_NAME
        Write-Success "✓ Ambiente antigo removido"
    } else {
        Write-Info "→ Usando ambiente existente"
    }
}

if (-not (Test-Path $VENV_NAME)) {
    Write-Info "→ Criando ambiente virtual '$VENV_NAME'..."
    & $pythonCmd -m venv $VENV_NAME
    
    if (Test-Path "$VENV_NAME\Scripts\activate.ps1") {
        Write-Success "✓ Ambiente virtual criado com sucesso!"
    } else {
        Write-Error "✗ Erro ao criar ambiente virtual"
        exit 1
    }
}

Write-Info ""
Write-Info "→ Ativando ambiente virtual..."
& "$VENV_NAME\Scripts\Activate.ps1"

# Verificar ativação
if ($env:VIRTUAL_ENV) {
    Write-Success "✓ Ambiente virtual ativado: $env:VIRTUAL_ENV"
} else {
    Write-Warning "⚠ Ambiente virtual pode não estar ativo, mas continuando..."
}

# Atualizar pip no ambiente virtual
Write-Info ""
Write-Info "→ Atualizando pip no ambiente virtual..."
& "$VENV_NAME\Scripts\python.exe" -m pip install --upgrade pip --quiet
Write-Success "✓ pip atualizado!"

Write-Info ""
Write-Success "════════════════════════════════════════════════════════════════════════════"
Write-Success "ETAPA 2 CONCLUÍDA: Ambiente virtual configurado!"
Write-Success "════════════════════════════════════════════════════════════════════════════"
Start-Sleep -Seconds 2

# ============================================================================
# ETAPA 3: VERIFICAR/CRIAR REQUIREMENTS.TXT
# ============================================================================

Write-Info ""
Write-Info "[ETAPA 3/6] Verificando arquivo de dependências..."
Write-Info ""

if (-not (Test-Path "requirements.txt")) {
    Write-Warning "⚠ requirements.txt não encontrado"
    Write-Info "→ Criando arquivo de dependências..."
    
    $requirements = @"
# BMG SmartReach - Dependências Python
# Versões estáveis testadas em Python 3.11+

# Core scientific computing
numpy==1.26.4
pandas==2.2.0
scipy==1.12.0

# Machine Learning
scikit-learn==1.4.0
lightgbm==4.3.0

# Visualization
matplotlib==3.8.2
seaborn==0.13.2

# Explicabilidade (opcional mas recomendado)
shap==0.44.1

# Jupyter
jupyter==1.0.0
notebook==7.0.7
ipykernel==6.29.0

# Utilities
tqdm==4.66.1
"@
    
    $requirements | Out-File -FilePath "requirements.txt" -Encoding UTF8
    Write-Success "✓ requirements.txt criado!"
} else {
    Write-Success "✓ requirements.txt encontrado!"
}

Write-Info ""
Write-Success "════════════════════════════════════════════════════════════════════════════"
Write-Success "ETAPA 3 CONCLUÍDA: Dependências verificadas!"
Write-Success "════════════════════════════════════════════════════════════════════════════"
Start-Sleep -Seconds 2

# ============================================================================
# ETAPA 4: INSTALAR DEPENDÊNCIAS
# ============================================================================

Write-Info ""
Write-Info "[ETAPA 4/6] Instalando dependências (pode levar 3-5 minutos)..."
Write-Info ""
Write-Info "→ Instalando pacotes do requirements.txt..."
Write-Info "   (você verá várias mensagens de instalação)"
Write-Info ""

try {
    & "$VENV_NAME\Scripts\python.exe" -m pip install -r requirements.txt
    Write-Success ""
    Write-Success "✓ Todas as dependências instaladas com sucesso!"
} catch {
    Write-Error "✗ Erro ao instalar dependências"
    Write-Warning "Tente executar manualmente:"
    Write-Warning "  1. .\venv\Scripts\Activate.ps1"
    Write-Warning "  2. pip install -r requirements.txt"
    exit 1
}

# Verificar instalações críticas
Write-Info ""
Write-Info "→ Verificando instalações críticas..."

$criticalPackages = @("numpy", "pandas", "scikit-learn", "lightgbm", "jupyter")
$allInstalled = $true

foreach ($package in $criticalPackages) {
    try {
        & "$VENV_NAME\Scripts\python.exe" -c "import $($package.Replace('-', '_'))" 2>&1 | Out-Null
        Write-Success "  ✓ $package"
    } catch {
        Write-Error "  ✗ $package FALHOU"
        $allInstalled = $false
    }
}

if (-not $allInstalled) {
    Write-Error ""
    Write-Error "Alguns pacotes críticos falharam na instalação."
    Write-Warning "Tente instalar manualmente os pacotes que falharam."
    exit 1
}

Write-Info ""
Write-Success "════════════════════════════════════════════════════════════════════════════"
Write-Success "ETAPA 4 CONCLUÍDA: Todas as bibliotecas instaladas!"
Write-Success "════════════════════════════════════════════════════════════════════════════"
Start-Sleep -Seconds 2

# ============================================================================
# ETAPA 5: CONFIGURAR JUPYTER
# ============================================================================

Write-Info ""
Write-Info "[ETAPA 5/6] Configurando Jupyter Notebook..."
Write-Info ""

Write-Info "→ Registrando kernel do ambiente virtual..."
& "$VENV_NAME\Scripts\python.exe" -m ipykernel install --user --name=bmg-smartreach --display-name="Python (BMG SmartReach)"
Write-Success "✓ Kernel registrado: Python (BMG SmartReach)"

Write-Info ""
Write-Info "→ Verificando instalação do Jupyter..."
try {
    $jupyterVersion = & "$VENV_NAME\Scripts\jupyter.exe" --version
    Write-Success "✓ Jupyter Notebook instalado e funcionando!"
} catch {
    Write-Error "✗ Erro ao verificar Jupyter"
    exit 1
}

Write-Info ""
Write-Success "════════════════════════════════════════════════════════════════════════════"
Write-Success "ETAPA 5 CONCLUÍDA: Jupyter configurado!"
Write-Success "════════════════════════════════════════════════════════════════════════════"
Start-Sleep -Seconds 2

# ============================================================================
# ETAPA 6: VERIFICAR NOTEBOOK E INICIAR
# ============================================================================

Write-Info ""
Write-Info "[ETAPA 6/6] Preparando para iniciar o projeto..."
Write-Info ""

# Procurar arquivo .ipynb
$notebookFiles = Get-ChildItem -Filter "*.ipynb" | Select-Object -First 1

if ($notebookFiles) {
    $notebookName = $notebookFiles.Name
    Write-Success "✓ Notebook encontrado: $notebookName"
} else {
    Write-Warning "⚠ Nenhum notebook (.ipynb) encontrado no diretório atual"
    Write-Info "→ Você precisará criar ou copiar o notebook manualmente"
    $notebookName = $null
}

Write-Info ""
Write-Success "════════════════════════════════════════════════════════════════════════════"
Write-Success "ETAPA 6 CONCLUÍDA: Tudo pronto!"
Write-Success "════════════════════════════════════════════════════════════════════════════"

# ============================================================================
# RESUMO E INICIALIZAÇÃO
# ============================================================================

Write-Info ""
Write-Info ""
Write-Success "╔════════════════════════════════════════════════════════════════════════════╗"
Write-Success "║                    🎉 INSTALAÇÃO CONCLUÍDA COM SUCESSO! 🎉                  ║"
Write-Success "╚════════════════════════════════════════════════════════════════════════════╝"
Write-Info ""
Write-Info "📊 RESUMO DA INSTALAÇÃO:"
Write-Info "   ✓ Python instalado/verificado"
Write-Info "   ✓ Ambiente virtual criado: $VENV_NAME"
Write-Info "   ✓ $($criticalPackages.Count) bibliotecas instaladas"
Write-Info "   ✓ Jupyter Notebook configurado"
Write-Info "   ✓ Kernel registrado: Python (BMG SmartReach)"
Write-Info ""
Write-Info "📁 DIRETÓRIO DO PROJETO:"
Write-Info "   $PWD"
Write-Info ""

if ($notebookName) {
    Write-Info "📓 NOTEBOOK DETECTADO:"
    Write-Info "   $notebookName"
    Write-Info ""
}

Write-Info "🚀 COMO USAR:"
Write-Info ""
Write-Info "   OPÇÃO 1 - Iniciar automaticamente agora:"
Write-Info "   → Pressione ENTER para abrir o Jupyter Notebook"
Write-Info ""
Write-Info "   OPÇÃO 2 - Iniciar manualmente depois:"
Write-Info "   1. Abra PowerShell nesta pasta"
Write-Info "   2. Execute: .\venv\Scripts\Activate.ps1"
Write-Info "   3. Execute: jupyter notebook"
Write-Info ""
Write-Info "   OPÇÃO 3 - Usar script rápido (após instalação):"
Write-Info "   → Execute: .\run.ps1"
Write-Info ""
Write-Info "💡 DICAS:"
Write-Info "   • No Jupyter, selecione kernel: Python (BMG SmartReach)"
Write-Info "   • Execute todas as células: Cell > Run All"
Write-Info "   • Tempo de execução: ~5 minutos"
Write-Info ""
Write-Info "📚 DOCUMENTAÇÃO:"
Write-Info "   • Veja o README.md para instruções detalhadas"
Write-Info "   • Cada célula do notebook tem comentários explicativos"
Write-Info ""
Write-Info "════════════════════════════════════════════════════════════════════════════"
Write-Info ""

$response = Read-Host "Deseja abrir o Jupyter Notebook agora? (S/N)"

if ($response -eq "S" -or $response -eq "s") {
    Write-Info ""
    Write-Info "→ Iniciando Jupyter Notebook..."
    Write-Info "   (uma nova aba do navegador será aberta)"
    Write-Info ""
    Write-Info "→ Para parar o servidor, pressione CTRL+C nesta janela"
    Write-Info ""
    Start-Sleep -Seconds 2
    
    # Iniciar Jupyter
    & "$VENV_NAME\Scripts\jupyter.exe" notebook
} else {
    Write-Info ""
    Write-Success "✓ Configuração completa!"
    Write-Info ""
    Write-Info "Para iniciar mais tarde, execute:"
    Write-Info "   .\venv\Scripts\Activate.ps1"
    Write-Info "   jupyter notebook"
    Write-Info ""
    Write-Info "Ou simplesmente:"
    Write-Info "   .\run.ps1"
    Write-Info ""
    Write-Info "Pressione qualquer tecla para sair..."
    $null = $Host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown")
}

# Fim do script