# ============================================================================
# BMG SMARTREACH - SCRIPT DE EXECUÇÃO RÁPIDA
# ============================================================================
# 
# Use este script para iniciar o Jupyter Notebook rapidamente após a 
# instalação inicial (setup.ps1) já ter sido executada.
#
# USO: 
#   Clique com botão direito > "Executar com PowerShell"
#   OU execute: .\run.ps1
#
# ============================================================================

$ErrorActionPreference = "Stop"
$VENV_NAME = "venv"

# Cores
function Write-ColorOutput($ForegroundColor) {
    $fc = $host.UI.RawUI.ForegroundColor
    $host.UI.RawUI.ForegroundColor = $ForegroundColor
    if ($args) { Write-Output $args }
    $host.UI.RawUI.ForegroundColor = $fc
}

function Write-Success { Write-ColorOutput Green $args }
function Write-Info { Write-ColorOutput Cyan $args }
function Write-Error { Write-ColorOutput Red $args }

Clear-Host
Write-Info "════════════════════════════════════════════════════════════════════════════"
Write-Info "                    BMG SMARTREACH - INICIANDO PROJETO                      "
Write-Info "════════════════════════════════════════════════════════════════════════════"
Write-Info ""

# Verificar se ambiente virtual existe
if (-not (Test-Path "$VENV_NAME\Scripts\Activate.ps1")) {
    Write-Error "✗ Ambiente virtual não encontrado!"
    Write-Info ""
    Write-Info "Execute primeiro o script de instalação:"
    Write-Info "   .\setup.ps1"
    Write-Info ""
    Write-Info "Pressione qualquer tecla para sair..."
    $null = $Host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown")
    exit 1
}

Write-Success "✓ Ambiente virtual encontrado"
Write-Info ""

# Ativar ambiente
Write-Info "→ Ativando ambiente virtual..."
& "$VENV_NAME\Scripts\Activate.ps1"

if ($env:VIRTUAL_ENV) {
    Write-Success "✓ Ambiente ativado: $env:VIRTUAL_ENV"
} else {
    Write-Success "✓ Ambiente configurado"
}

Write-Info ""
Write-Info "→ Verificando Jupyter..."

# Verificar Jupyter
if (Test-Path "$VENV_NAME\Scripts\jupyter.exe") {
    Write-Success "✓ Jupyter encontrado"
} else {
    Write-Error "✗ Jupyter não instalado!"
    Write-Info ""
    Write-Info "Execute o setup completo:"
    Write-Info "   .\setup.ps1"
    Write-Info ""
    exit 1
}

# Listar notebooks disponíveis
Write-Info ""
Write-Info "📓 Notebooks disponíveis:"
$notebooks = Get-ChildItem -Filter "*.ipynb"
if ($notebooks) {
    foreach ($nb in $notebooks) {
        Write-Info "   • $($nb.Name)"
    }
} else {
    Write-Info "   (nenhum notebook encontrado)"
}

Write-Info ""
Write-Info "════════════════════════════════════════════════════════════════════════════"
Write-Success "                        🚀 INICIANDO JUPYTER NOTEBOOK                        "
Write-Info "════════════════════════════════════════════════════════════════════════════"
Write-Info ""
Write-Info "💡 DICAS:"
Write-Info "   • O navegador abrirá automaticamente"
Write-Info "   • Selecione o kernel: Python (BMG SmartReach)"
Write-Info "   • Para parar o servidor: CTRL+C nesta janela"
Write-Info ""
Write-Info "→ Iniciando em 3 segundos..."
Start-Sleep -Seconds 3

# Iniciar Jupyter
& "$VENV_NAME\Scripts\jupyter.exe" notebook

Write-Info ""
Write-Success "✓ Jupyter Notebook encerrado"
Write-Info ""
Write-Info "Pressione qualquer tecla para sair..."
$null = $Host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown")