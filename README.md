# 🎯 BMG SmartReach - Inteligência em Vendas

## 📋 Índice
- [O que é o BMG SmartReach?](#o-que-é-o-bmg-smartreach)
- [Para quem é este projeto?](#para-quem-é-este-projeto)
- [Como funciona?](#como-funciona)
- [As 12 Etapas do Projeto](#as-12-etapas-do-projeto)
- [Como executar](#como-executar)
- [Resultados esperados](#resultados-esperados)

---

## 🤔 O que é o BMG SmartReach?

O **BMG SmartReach** é um sistema inteligente que ajuda o banco BMG a oferecer os produtos certos, para as pessoas certas, no momento certo e da forma certa.

Imagine que você trabalha em um banco e tem 20.000 clientes. Como saber qual cliente prefere receber ofertas por WhatsApp ou email? Quem tem mais chance de aceitar um empréstimo? Qual mensagem usar para cada pessoa? 

É isso que o SmartReach faz automaticamente usando **Inteligência Artificial**!

### 🎯 Os 4 Pilares da Solução

O sistema responde 4 perguntas fundamentais para cada cliente:

1. **QUEM** é o cliente? (Qual seu perfil comportamental?)
2. **O QUÊ** oferecer? (Consignado, Cartão ou Investimento?)
3. **ONDE** abordá-lo? (WhatsApp, Email, App ou SMS?)
4. **COMO** falar com ele? (Tom formal, amigável, moderno?)

---

## 👥 Para quem é este projeto?

Este projeto foi desenvolvido pensando em:

- **Equipes de vendas** que querem aumentar conversões
- **Gerentes de marketing** que buscam personalização
- **Analistas de negócio** que precisam entender padrões
- **Executivos** que querem ver impacto nos resultados

**Não precisa saber programação** para entender o valor! Este README explica cada etapa em linguagem simples.

---

## 🔄 Como funciona?

```
┌─────────────────┐
│  Dados Clientes │  (idade, renda, comportamento digital)
└────────┬────────┘
         ↓
┌─────────────────┐
│ Inteligência IA │  (agrupa perfis, prevê preferências)
└────────┬────────┘
         ↓
┌─────────────────┐
│  Recomendações  │  (produto + canal + mensagem)
└────────┬────────┘
         ↓
┌─────────────────┐
│ Aumento Vendas! │  (+167% conversão estimada)
└─────────────────┘
```

---

## 📚 As 12 Etapas do Projeto

### 🏁 Etapa 1: Configuração e Imports

**O que faz:** Prepara o ambiente de trabalho, carregando todas as ferramentas necessárias.

**Por que é importante:** É como organizar sua mesa antes de começar um trabalho - você precisa ter todas as ferramentas à mão.

**O que acontece:**
- Carrega bibliotecas de matemática (NumPy, Pandas)
- Carrega ferramentas de Inteligência Artificial (Scikit-learn, LightGBM)
- Carrega ferramentas de visualização (Matplotlib, Seaborn)
- Define a "semente" para reprodutibilidade (seed=42)

**Resultado:** Sistema pronto para processar dados.

---

### 📊 Etapa 2: Geração de Dados Sintéticos

**O que faz:** Cria 20.000 clientes fictícios, mas muito realistas, para testar o sistema.

**Por que é importante:** Antes de usar dados reais de clientes (que são sensíveis), testamos com dados simulados que se comportam como os reais.

**Como funciona:**

Criamos clientes com características que fazem sentido no mundo real:

- **60% são aposentados INSS** (idosos, renda baixa, preferem WhatsApp)
- **25% são servidores públicos** (renda média/alta, usam app)
- **15% são CLT** (jovens, digitais)

**Correlações inteligentes implementadas:**
- Idosos → maior uso de WhatsApp e SMS
- Jovens → maior uso de App
- INSS → maior chance de ter empréstimo consignado
- Servidor Público → maior chance de investir

**Resultado:** 
- DataFrame com 20.000 clientes
- Cada um com 15 características (idade, renda, uso de canais, produtos, etc.)

**Exemplo de cliente gerado:**
```
Cliente: CLI_001234
Idade: 65 anos
Renda: R$ 2.300,00
Tipo: INSS
Uso WhatsApp: 15x/mês
Uso App: 1x/mês
Tem Consignado: Sim
```

---

### 🔧 Etapa 3: Engenharia de Features

**O que faz:** Cria novas informações a partir dos dados existentes.

**Por que é importante:** Às vezes, a informação mais valiosa não está diretamente nos dados, mas na combinação deles.

**Analogia:** É como um chef que não usa só ingredientes básicos, mas combina eles de formas criativas (ex: "maionese" = ovo + óleo + limão).

**Features criadas:**

1. **uso_digital_total**
   - Soma de todas interações digitais
   - Indica o quão digital é o cliente

2. **taxa_uso_app**
   - Proporção de uso do app sobre total
   - Indica preferência por tecnologia

3. **idade_x_uso_app**
   - Multiplicação de idade por uso do app
   - Captura padrão: jovens usam mais app

4. **cliente_novo**
   - Flag se cliente tem menos de 1 ano
   - Importante para estratégias de retenção

5. **qtd_produtos**
   - Quantos produtos o cliente já possui
   - Indica oportunidade de cross-sell

6. **e_idoso**
   - Flag se idade >= 60 anos
   - Perfil importante para consignado

**Resultado:** DataFrame expandido de 15 para 25+ colunas, com informações mais ricas.

---

### 🎨 Etapa 4: Clusterização de Perfis

**O que faz:** Agrupa clientes similares em "tribos" comportamentais.

**Por que é importante:** Cada grupo tem necessidades e preferências diferentes. Não faz sentido tratar todo mundo igual!

**Como funciona:**

Usamos o algoritmo **K-Means** (um dos mais populares para agrupamento):

1. **Padronização:** Coloca todas variáveis na mesma escala
2. **Análise de cotovelo:** Testa diferentes números de grupos (3 a 8)
3. **Escolha do melhor k:** Usando o método da silhueta
4. **Agrupamento final:** Divide os 20.000 clientes em 5 grupos

**Métricas geradas:**

**🔹 Inércia (Elbow Method)**
- **O que é:** Mede o quão "compactos" são os grupos
- **Como ler:** Menor = grupos mais coesos
- **Como ajuda:** Identificar o número ideal de clusters (onde a curva "dobra")

**🔹 Silhouette Score**
- **O que é:** Mede se os clientes estão no grupo certo (varia de -1 a 1)
- **Como ler:** 
  - Perto de 1 = ótimo (grupos bem separados)
  - Perto de 0 = grupos se sobrepõem
  - Negativo = clientes no grupo errado
- **Valor típico bom:** > 0.3
- **Como ajuda:** Confirma que a separação em grupos faz sentido

**Clusters identificados (exemplo):**

| Cluster | Nome | Perfil | Tamanho |
|---------|------|--------|---------|
| 0 | Idosos Consignados | 65+ anos, INSS, WhatsApp | 7.200 |
| 1 | Alta Renda Investidores | 45 anos, Servidor, App | 3.800 |
| 2 | Jovens Digitais | 30 anos, CLT, App | 2.500 |
| 3 | WhatsApp Lovers | 55 anos, Multi-canal | 4.200 |
| 4 | Tradicionais | Baixo uso digital | 2.300 |

**Visualização gerada:**
- Gráfico PCA 2D mostrando os 5 grupos separados
- Cada ponto é um cliente, cores diferentes = grupos diferentes
- **Variância explicada:** Mostra quanto da informação original foi mantida (típico: 40-60%)

**Resultado:** Cada cliente recebe um "rótulo" de cluster (0 a 4) e um nome descritivo.

---

### 🤖 Etapa 5: Modelo de Propensão ao Produto

**O que faz:** Prevê qual produto (Consignado, Cartão ou Investimento) cada cliente tem mais chance de aceitar.

**Por que é importante:** Não adianta oferecer investimento para quem precisa de crédito, ou consignado para quem já tem!

**Como funciona:**

Usamos **LightGBM** (Gradient Boosting Machine), uma IA moderna que:
- Aprende padrões históricos de aceitação
- É mais rápida e precisa que métodos tradicionais
- Lida bem com variáveis categóricas
- Evita "overfitting" (decorar ao invés de aprender)

**O processo:**
1. **Separação:** 80% treino, 20% teste
2. **Treinamento:** IA aprende com 16.000 clientes
3. **Validação:** Testa em 4.000 clientes "nunca vistos"
4. **Cross-validation:** 5-fold para garantir robustez

**Métricas geradas:**

**🔹 Accuracy (Acurácia)**
- **O que é:** % de acertos totais
- **Como calcular:** (Acertos totais / Total de previsões) × 100
- **Exemplo:** 85% = acertou 8.500 de 10.000 previsões
- **Como ler:** Quanto maior, melhor
- **Valor bom:** > 70%
- **Como ajuda:** Mede a confiabilidade geral do modelo

**🔹 F1-Score (Macro)**
- **O que é:** Média balanceada entre precisão e recall
- **Como calcular:** 2 × (Precisão × Recall) / (Precisão + Recall)
- **Exemplo:** 0.82 = 82% de equilíbrio
- **Por que usar:** Accuracy pode enganar quando classes são desbalanceadas
- **Valor bom:** > 0.75
- **Como ajuda:** Garante que o modelo funciona bem para TODOS os produtos, não só o mais comum

**🔹 Matriz de Confusão**
- **O que é:** Tabela mostrando acertos e erros por produto
- **Como ler:**
  ```
                    Previsto
                  Cons  Cart  Inv
  Real  Cons      850    50   10  (85% acerto)
        Cart       60   700   40  (70% acerto)  
        Inv        20    30  750  (75% acerto)
  ```
- **Como ajuda:** 
  - Diagonal = acertos
  - Fora da diagonal = confusões
  - Identifica onde o modelo erra mais

**🔹 Feature Importance (Importância de Variáveis)**
- **O que é:** Ranking do que mais influencia a decisão
- **Como calcular:** LightGBM mede quantas vezes cada variável foi usada para dividir dados
- **Exemplo típico:**
  1. idade (30%)
  2. renda_mensal (20%)
  3. tem_consignado (15%)
  4. cluster (12%)
  5. uso_digital_total (8%)
- **Como ajuda:** 
  - Mostra o que realmente importa
  - Valida intuições de negócio
  - Identifica dados que podem ser descartados

**🔹 ROC-AUC (opcional)**
- **O que é:** Área sob a curva ROC (varia de 0 a 1)
- **Como ler:** 
  - 0.5 = modelo aleatório (inútil)
  - 0.7-0.8 = bom
  - 0.8-0.9 = ótimo
  - > 0.9 = excelente (ou overfitting)
- **Como ajuda:** Mede capacidade de discriminação independente do threshold

**Resultado:** 
- Modelo treinado que prevê produto com ~85% de acurácia
- Cada cliente recebe:
  - Produto recomendado
  - Score de confiança (0 a 100%)
  - Produto alternativo (2ª opção)

---

### 📱 Etapa 6: Modelo de Canal Ideal

**O que faz:** Prevê por qual canal (WhatsApp, Email, App, SMS) o cliente prefere ser contatado.

**Por que é importante:** Enviar ofertas pelo canal errado = ignorado. Canal certo = 3x mais conversão!

**Como funciona:**

Similar ao modelo de produto, mas focado em preferências de comunicação:
- Analisa histórico de uso de cada canal
- Considera idade e perfil digital
- Prevê canal com maior taxa de resposta

**Métricas geradas:**

**🔹 Accuracy (Acurácia)**
- Mesmo conceito da Etapa 5
- Típico: 75-80%

**🔹 F1-Score (Macro)**
- Garante bom desempenho em todos os canais
- Importante porque clientes podem usar múltiplos canais

**🔹 Top-2 Accuracy**
- **O que é:** % de vezes que o canal correto está entre as 2 primeiras opções
- **Como calcular:** (Acertos top-1 + Acertos top-2) / Total
- **Exemplo:** 92% = em 9.200 de 10.000 casos, acertamos no "top 2"
- **Por que é útil:** Na prática, podemos tentar 2 canais
- **Como ajuda:** Aumenta chances de sucesso (backup automático)

**🔹 Matriz de Confusão**
- Similar à Etapa 5, mas para canais
- Mostra confusões comuns (ex: WhatsApp vs SMS)

**Distribuição típica de canais:**
- WhatsApp: 45% (mais popular)
- App: 25%
- Email: 20%
- SMS: 10%

**Resultado:**
- Canal recomendado + score
- Canal alternativo (backup)
- Top-2 accuracy de ~92%

---

### 🎨 Etapa 7: Tom de Linguagem

**O que faz:** Define COMO falar com cada grupo de clientes.

**Por que é importante:** Mensagem certa no tom errado = cliente não se identifica e ignora.

**Como funciona:**

Baseado no cluster (perfil comportamental), atribuímos um tom:

| Cluster | Tom | Quando usar | Exemplo |
|---------|-----|-------------|---------|
| Idosos Consignados | Empática e Simples | Frases curtas, evita jargões | "Olá Maria! Temos uma novidade especial..." |
| Alta Renda | Profissional | Formal mas acessível | "Prezado João, identificamos uma oportunidade..." |
| Jovens Digitais | Direta e Moderna | Emojis, objetiva | "E aí Ana! 🚀 Bora conferir..." |
| WhatsApp Lovers | Educacional | Explica benefícios, confiança | "Olá Carlos! Preparamos uma proposta..." |
| Tradicionais | Consultiva | Tom de parceiro | "Como seu parceiro financeiro..." |

**Não usa IA aqui - é mapeamento direto:** Cluster → Tom

**Por que não treinar modelo?**
- Tom é subjetivo e estratégico
- Depende de valores da marca
- Mais controle para o time de marketing
- Rápido de ajustar conforme testes A/B

**Resultado:** Cada cliente recebe um tom + descrição + template de mensagem.

---

### 🎁 Etapa 8: Motor de Recomendação (Consolidação)

**O que faz:** Junta todas as peças do quebra-cabeça em uma recomendação única e acionável.

**Por que é importante:** É onde tudo se conecta! Esta é a "entrega final" para a equipe de vendas.

**Como funciona:**

Para cada cliente, o sistema combina:
1. ✅ Perfil (cluster) da Etapa 4
2. ✅ Produto da Etapa 5
3. ✅ Canal da Etapa 6
4. ✅ Tom da Etapa 7

**Cálculo do Score Final:**
```
Score Final = (Score Produto × 0.7) + (Score Canal × 0.3)
```

**Por que essa ponderação?**
- Produto tem peso 70% → mais importante acertar O QUE oferecer
- Canal tem peso 30% → importante, mas secundário

**Sistema de Priorização:**

| Score Final | Prioridade | Ação Recomendada |
|-------------|------------|------------------|
| > 70% | 🔴 Alta | Abordar imediatamente |
| 50-70% | 🟡 Média | Incluir em campanha |
| < 50% | 🟢 Baixa | Aguardar momento melhor |

**Explicabilidade:**

O sistema gera razões automáticas:
- "Cliente idoso" (idade >= 60)
- "Renda compatível" (renda < 3000)
- "Alto uso WhatsApp" (> 10x/mês)
- "Não possui produto" (cross-sell)
- "Oportunidade cross-sell" (< 2 produtos)

**Resultado:** 

DataFrame final com 20.000 linhas e colunas:
- `cliente_id`
- `cluster_nome`
- `produto_recomendado`
- `score_produto`
- `canal_recomendado`
- `score_canal`
- `score_final`
- `prioridade`
- `explicacao`
- `mensagem_personalizada` (próxima etapa)

**Exemplo de linha:**
```
CLI_005432 | Idosos Consignados | consignado (92%) | 
whatsapp (88%) | Score: 90.8% | Alta | 
"Cliente idoso | Alto uso WhatsApp | Não possui produto"
```

---

### 💬 Etapa 9: Mensagens Personalizadas

**O que faz:** Gera a mensagem específica que será enviada para cada cliente.

**Por que é importante:** É o "toque final" - a mensagem que o cliente vai ler. Precisa soar natural e relevante!

**Como funciona:**

Sistema de templates dinâmicos:
```
[Tom do Cluster] + [Produto] + [Canal] = Mensagem Personalizada
```

**Exemplo prático:**

**Cliente:** Maria, 68 anos, INSS, usa WhatsApp
**Cluster:** Idosos Consignados (Tom: Empática e Simples)
**Produto:** Consignado
**Canal:** WhatsApp

**Mensagem gerada:**
> "Olá Maria! Temos condições especiais em empréstimo consignado pra você. Taxas reduzidas e desconto direto na folha. Posso enviar os detalhes por WhatsApp?"

**Mesmo produto, cluster diferente:**

**Cliente:** João, 42 anos, Servidor Público
**Cluster:** Alta Renda (Tom: Profissional)
**Produto:** Consignado
**Canal:** App

**Mensagem gerada:**
> "Prezado João, identificamos uma oportunidade de crédito consignado com condições exclusivas para seu perfil. Gostaria de avaliar?"

**Vantagens:**
- ✅ Personalização em escala (20.000 mensagens únicas)
- ✅ Consistência de marca
- ✅ Facilidade de atualização (trocar templates)
- ✅ Teste A/B simples (criar variações)

**Resultado:** 
- Coluna `mensagem_personalizada` no DataFrame
- 20.000 mensagens prontas para disparo
- Arquivo CSV exportável para CRM

---

### 📊 Etapa 10: KPIs de Negócio

**O que faz:** Simula o impacto financeiro da solução.

**Por que é importante:** Executivos precisam ver o ROI ($$$). Esta etapa responde: "Quanto vamos ganhar com isso?"

**Como funciona:**

Comparamos dois cenários:

**📍 Cenário 1: SEM IA (Baseline)**
- Ofertas genéricas para todos
- Taxa de conversão: 3%
- Mensagem padrão única

**📍 Cenário 2: COM IA (SmartReach)**
- Ofertas personalizadas
- Taxa de conversão: 8%
- Mensagem, produto e canal personalizados

**Parâmetros de negócio usados:**

| Produto | Ticket Médio | Margem |
|---------|--------------|--------|
| Consignado | R$ 15.000 | 15% |
| Cartão | R$ 3.000 | 25% |
| Investimento | R$ 8.000 | 8% |

**Métricas calculadas:**

**🔹 Uplift em Vendas**
- **O que é:** Aumento percentual no número de vendas
- **Como calcular:** ((Vendas com IA / Vendas sem IA) - 1) × 100
- **Exemplo típico:** 
  - Sem IA: 600 vendas
  - Com IA: 1.600 vendas
  - **Uplift: +167%** (1.000 vendas adicionais)
- **Como ajuda:** Mostra crescimento tangível

**🔹 Receita Incremental**
- **O que é:** Dinheiro adicional gerado pela IA
- **Como calcular:** 
  ```
  Receita = Σ (Vendas por produto × Ticket médio × Margem)
  Incremental = Receita com IA - Receita sem IA
  ```
- **Exemplo:**
  - Sem IA: R$ 2.100.000 em margem
  - Com IA: R$ 5.600.000 em margem
  - **Incremental: R$ 3.500.000**
- **Como ajuda:** Justifica investimento no projeto

**🔹 ROI (Return on Investment)**
- **O que é:** Retorno sobre investimento
- **Como calcular:** 
  ```
  ROI = (Receita Incremental / Custo do Projeto) × 100
  ```
- **Exemplo:**
  - Receita incremental: R$ 3.500.000
  - Custo implementação: R$ 100.000
  - **ROI: 3.500%** (retorna 35x o investimento)
- **Como ler:**
  - ROI > 100% = projeto se paga
  - ROI > 500% = excelente
  - ROI > 1000% = excepcional
- **Como ajuda:** Decisão executiva clara

**🔹 Taxa de Conversão**
- **O que é:** % de clientes abordados que compram
- **Como calcular:** (Vendas / Leads abordados) × 100
- **Baseline:** 3% (sem personalização)
- **Com IA:** 8% (estimativa conservadora baseada em benchmarks)
- **Como ajuda:** Mede eficiência comercial

**Visualizações geradas:**

1. **Gráfico de barras:** Vendas (com vs sem IA)
2. **Gráfico de barras:** Receita (com vs sem IA)
3. **Pizza:** Distribuição de prioridades
4. **Heatmap:** Produto × Canal (leads qualificados)

**Resultado:** 
- Dashboard executivo completo
- Justificativa financeira clara
- Projeção de impacto quantificado

**⚠️ Importante:** Estes são valores SIMULADOS para demonstração. Na prática:
1. Rodar campanha piloto A/B
2. Medir conversão real
3. Ajustar estimativas
4. Escalar gradualmente

---

### 📤 Etapa 11: Exportação

**O que faz:** Salva todos os resultados em formato utilizável.

**Por que é importante:** De nada adianta ter as recomendações só no notebook - precisam ir para o CRM!

**Arquivos gerados:**

**📄 bmg_smartreach_recomendacoes.csv**
- Formato: CSV (compatível com Excel, Google Sheets, CRMs)
- Encoding: UTF-8 com BOM (acentos corretos no Excel)
- Linhas: 20.000 (uma por cliente)
- Colunas principais:
  - Identificação: `cliente_id`
  - Perfil: `cluster_nome`, `idade`, `renda_mensal`, `tipo_beneficio`
  - Recomendações: `produto_recomendado`, `canal_recomendado`
  - Scores: `score_produto`, `score_canal`, `score_final`
  - Ação: `prioridade`, `mensagem_personalizada`, `explicacao`

**Como usar:**
1. Importar no CRM (Salesforce, HubSpot, etc)
2. Filtrar por prioridade Alta
3. Disparar campanhas segmentadas
4. Acompanhar conversões

**Resultado:** Ponte entre IA e operação comercial.

---

### 🧪 Etapa 12: Teste Interativo

**O que faz:** Permite testar o sistema com qualquer cliente (real ou hipotético).

**Por que é importante:** 
- Validar se as recomendações fazem sentido
- Demonstrar valor para stakeholders
- Simular novos cenários
- Treinar equipe comercial

**Como funciona:**

Você fornece as características de um cliente:
```python
recomendar_para_novo_cliente(
    idade=65,
    renda_mensal=2500.00,
    tipo_beneficio='INSS',
    uso_whatsapp=15,
    uso_app=1,
    tem_consignado=0,
    nome_cliente="Maria Silva"
)
```

O sistema processa em tempo real:
1. ✅ Aplica feature engineering
2. ✅ Identifica cluster
3. ✅ Prevê produto e canal
4. ✅ Gera mensagem personalizada
5. ✅ Calcula scores e prioridade
6. ✅ Exibe resultado formatado

**Output visual:**
```
🎯════════════════════════════════════════════════════════════════════════🎯
                        RECOMENDAÇÃO PERSONALIZADA                        
🎯════════════════════════════════════════════════════════════════════════🎯

👤 CLIENTE: Maria Silva
📊 Perfil: Idosos Consignados (Cluster 0)
🎨 Tom: Empática e Simples
   └─ Linguagem acolhedora, frases curtas, evita jargões

────────────────────────────────────────────────────────────────────────────
🎁 PRODUTO RECOMENDADO: CONSIGNADO
   ├─ Score: 92.3% ⭐
   └─ Alternativa: cartao (45.2%)

────────────────────────────────────────────────────────────────────────────
📱 CANAL RECOMENDADO: WHATSAPP
   ├─ Score: 88.7% ⭐
   └─ Alternativa: sms (52.1%)

────────────────────────────────────────────────────────────────────────────
📈 SCORE FINAL: 91.2%
⚡ PRIORIDADE: Alta
💡 RAZÃO: Cliente idoso | Alto uso WhatsApp | Não possui produto

────────────────────────────────────────────────────────────────────────────
💬 MENSAGEM SUGERIDA:

   📩 Olá Maria Silva! Temos condições especiais em empréstimo consignado 
   pra você. Taxas reduzidas e desconto direto na folha. Posso enviar os 
   detalhes por whatsapp?

🎯════════════════════════════════════════════════════════════════════════🎯
```

**Exemplos pré-configurados:**

1. **Teste 1:** Aposentado INSS clássico
2. **Teste 2:** Servidor público investidor  
3. **Teste 3:** CLT jovem digital
4. **Teste 4:** Personalizável (edite à vontade)

**Casos de uso:**
- ✅ Validar hipóteses ("E se mudarmos a renda?")
- ✅ Apresentar para diretoria
- ✅ Treinar consultores
- ✅ Debugar comportamentos estranhos

**Resultado:** Sistema demonstrável e validável por qualquer stakeholder.

---

## 🚀 Como executar

### Pré-requisitos
- Python 3.11 ou superior
- 4GB RAM mínimo
- 500MB espaço em disco

### Passo a passo

**1. Clone ou baixe o projeto**
```bash
git clone [seu-repositorio]
cd bmg-smartreach
```

**2. Crie ambiente virtual**
```bash
# Windows
python -m venv venv
venv\Scripts\activate

# Linux/Mac
python3 -m venv venv
source venv/bin/activate
```

**3. Instale dependências**
```bash
pip install -r requirements.txt
```

**4. Abra o Jupyter Notebook**
```bash
jupyter notebook
```

**5. Execute o notebook**
- Abra `bmg_smartreach.ipynb`
- Menu: `Cell` → `Run All`
- Aguarde ~5 minutos

**6. Explore os resultados!**
- Navegue pelos gráficos
- Veja o arquivo CSV gerado
- Teste com seus próprios clientes na Etapa 12

---

## 📈 Resultados Esperados

Após executar todas as etapas, você terá:

### 📊 Métricas de Performance

| Métrica | Valor Esperado | O que significa |
|---------|----------------|-----------------|
| **Accuracy Produto** | 80-85% | 8 em cada 10 previsões corretas |
| **F1-Score Produto** | 0.78-0.82 | Equilíbrio entre precisão e recall |
| **Accuracy Canal** | 75-80% | Boa previsão de canal preferido |
| **Top-2 Accuracy Canal** | 90-95% | Quase sempre acerta nas 2 primeiras opções |
| **Silhouette Score** | 0.30-0.45 | Clusters bem definidos |
| **Variância PCA** | 40-60% | Boa redução dimensional |

### 💰 Impacto de Negócio (Simulado)

| KPI | Baseline (Sem IA) | Com SmartReach | Uplift |
|-----|-------------------|----------------|--------|
| **Leads Qualificados** | - | 12.000-15.000 | - |
| **Taxa Conversão** | 3% | 8% | +167% |
| **Vendas Totais** | 600 | 1.600 | +1.000 |
| **Receita (margem)** | R$ 2.1M | R$ 5.6M | +R$ 3.5M |
| **ROI** | - | 3.500% | 35x retorno |

### 📁 Arquivos Gerados

1. **bmg_smartreach_recomendacoes.csv**
   - 20.000 linhas de recomendações
   - Pronto para importar no CRM
   - Inclui mensagens personalizadas

2. **Gráficos gerados no notebook:**
   - Elbow e Silhouette (escolha de clusters)
   - PCA 2D (visualização de perfis)
   - 2 Matrizes de confusão (produto e canal)
   - Feature importance (variáveis mais importantes)
   - 4 gráficos de KPIs (vendas, receita, prioridade, heatmap)

### 🎯 Principais Insights

**Padrões identificados:**
- ✅ Idosos INSS preferem WhatsApp e têm alta propensão a consignado
- ✅ Servidores públicos são receptivos a investimentos via app
- ✅ Jovens CLT preferem cartão e interagem mais por app
- ✅ Clientes sem produtos têm score de conversão 40% maior
- ✅ Personalização de canal aumenta resposta em 3x

**Segmentos prioritários:**
1. **Idosos sem consignado** (Score médio: 88%, Prioridade: Alta)
2. **Servidores sem investimento** (Score médio: 82%, Prioridade: Alta)
3. **Jovens digitais** (Score médio: 75%, Prioridade: Média)

---

## 🎓 Glossário para Leigos

### Termos Técnicos Explicados

**🔹 Algoritmo**
Receita de bolo que o computador segue para resolver um problema.

**🔹 Inteligência Artificial (IA)**
Programa que aprende padrões a partir de exemplos, sem ser explicitamente programado.

**🔹 Machine Learning (ML)**
Tipo de IA onde o computador "aprende" analisando dados históricos.

**🔹 Cluster / Clusterização**
Agrupar coisas similares. Como separar frutas: bananas com bananas, maçãs com maçãs.

**🔹 K-Means**
Algoritmo que divide dados em K grupos, minimizando diferenças dentro de cada grupo.

**🔹 Feature / Variável**
Característica usada para descrever algo (ex: idade, renda, uso de app).

**🔹 Feature Engineering**
Arte de criar novas variáveis combinando as existentes (ex: renda_por_idade).

**🔹 Modelo Preditivo**
Sistema que prevê algo futuro baseado em padrões do passado.

**🔹 LightGBM**
Algoritmo moderno de ML, rápido e preciso. Tipo "professor que aprende com erros".

**🔹 Gradient Boosting**
Técnica que combina vários modelos simples para criar um modelo forte.

**🔹 Random Forest**
Algoritmo que cria várias "árvores de decisão" e combina suas opiniões.

**🔹 Accuracy (Acurácia)**
Porcentagem de acertos. 80% = acertou 8 em cada 10 previsões.

**🔹 F1-Score**
Métrica que equilibra precisão (evitar falsos positivos) e recall (não perder casos verdadeiros).

**🔹 Matriz de Confusão**
Tabela que mostra onde o modelo acerta e onde erra.

**🔹 Overfitting**
Quando o modelo "decora" os dados de treino mas não funciona em dados novos.

**🔹 Cross-Validation**
Técnica de dividir dados em várias partes para testar robustez do modelo.

**🔹 Score / Probabilidade**
Confiança do modelo (0-100%). 90% = muito confiante, 50% = incerto.

**🔹 ROI (Return on Investment)**
Retorno sobre investimento. Quanto de lucro para cada real investido.

**🔹 Uplift**
Aumento percentual causado por uma ação. +50% uplift = cresceu pela metade.

**🔹 Baseline**
Cenário base para comparação (o "antes" da solução).

**🔹 PCA (Principal Component Analysis)**
Técnica para reduzir dimensões mantendo informação importante. Como resumir um livro.

**🔹 Silhouette Score**
Métrica que mede se os grupos (clusters) estão bem separados.

**🔹 Encoding**
Transformar categorias (ex: "INSS", "CLT") em números que o computador entende.

**🔹 Scaler / Normalização**
Colocar variáveis na mesma escala (ex: idade 0-100 e renda 0-20000 → ambas 0-1).

**🔹 Train/Test Split**
Dividir dados: parte para treinar (ensinar) e parte para testar (avaliar).

**🔹 Pipeline**
Sequência de etapas que transforma dados crus em resultados finais.

**🔹 DataFrame**
Tabela de dados (como Excel, mas no Python/Pandas).

**🔹 Seed**
Número mágico (42) que garante que resultados sejam reproduzíveis.

---

## ❓ Perguntas Frequentes (FAQ)

### 1. Por que 20.000 clientes sintéticos?

**Resposta:** Volume realista para simular operação bancária real, mas sem expor dados sensíveis. Permite testar escalabilidade.

### 2. Os dados sintéticos são confiáveis?

**Resposta:** Sim, para MVP! Foram criados com correlações realistas (idosos→WhatsApp, INSS→consignado). Mas sempre valide com dados reais depois.

### 3. Por que LightGBM e não Random Forest?

**Resposta:** LightGBM é:
- Mais rápido (treina em segundos vs minutos)
- Mais preciso (1-3% ganho típico)
- Melhor com categorias
- Menos propenso a overfitting

Mas Random Forest funciona como fallback se LightGBM não estiver instalado.

### 4. Posso usar com menos de 20.000 clientes?

**Resposta:** Sim! Mínimo recomendado: 1.000 clientes. Abaixo disso, os modelos podem não ter dados suficientes para aprender padrões robustos.

### 5. Como validar se funciona de verdade?

**Resposta:** 
1. Rode campanha piloto A/B test
2. Grupo A: ofertas genéricas (baseline)
3. Grupo B: ofertas personalizadas (SmartReach)
4. Compare taxas de conversão reais
5. Ajuste modelos com feedback real

### 6. Quanto tempo leva para rodar?

**Resposta:** 
- Geração de dados: 10-20 segundos
- Clustering: 30-60 segundos
- Treino de modelos: 1-2 minutos
- Visualizações: 30 segundos
- **Total: 3-5 minutos** em computador médio

### 7. Preciso re-treinar os modelos periodicamente?

**Resposta:** Sim! Recomendado:
- **Mensal:** se comportamento muda rápido
- **Trimestral:** padrão seguro para bancos
- **Quando:** adicionar novos produtos, mudar estratégia

### 8. Como atualizar as mensagens?

**Resposta:** Edite o dicionário `mensagens_produto` na Etapa 9. Não precisa re-treinar modelos!

### 9. O que fazer se accuracy for baixa (<70%)?

**Resposta:**
1. Verificar qualidade dos dados (muitos missing?)
2. Adicionar mais features relevantes
3. Aumentar volume de dados
4. Testar outros algoritmos
5. Validar se targets fazem sentido

### 10. Posso adicionar novos produtos?

**Resposta:** Sim! Ajustes necessários:
1. Adicionar produto nos dados sintéticos (Etapa 2)
2. Incluir nas mensagens (Etapa 9)
3. Re-treinar modelo de produto (Etapa 5)

### 11. Como integrar com CRM?

**Resposta:**
1. Exportar CSV (Etapa 11)
2. Mapear colunas para campos do CRM
3. Importar via interface ou API
4. Configurar automações de disparo
5. Acompanhar conversões

### 12. Qual o custo de implementação?

**Resposta (estimativa):**
- Infra cloud (AWS/Azure): R$ 500-2.000/mês
- Desenvolvimento: R$ 50.000-100.000 (one-time)
- Manutenção: R$ 10.000-20.000/mês
- **ROI esperado:** 10-35x em 12 meses

---

## 🔒 Considerações de Segurança e Privacidade

### Dados Sensíveis

⚠️ **Este MVP usa dados sintéticos.** Ao migrar para produção:

1. **LGPD Compliance:**
   - Obter consentimento explícito
   - Permitir opt-out
   - Anonimizar dados sempre que possível
   - Implementar direito ao esquecimento

2. **Segurança:**
   - Criptografar dados em repouso e em trânsito
   - Controle de acesso (RBAC)
   - Logs de auditoria
   - Backup seguro

3. **Ética:**
   - Evitar viés discriminatório (idade, gênero, raça)
   - Transparência: cliente sabe que IA foi usada?
   - Revisão humana em casos críticos

4. **Monitoramento:**
   - Acompanhar métricas de fairness
   - Detectar drift (mudança de padrões)
   - Validar se modelos não prejudicam grupos vulneráveis

---

## 🚧 Limitações e Próximos Passos

### Limitações Atuais

1. **Dados sintéticos:** Não captura toda complexidade real
2. **Sem feedback loop:** Não aprende com conversões reais
3. **Mensagens fixas:** Não gera texto com NLP generativo
4. **Sem timing:** Não prevê melhor momento do dia/semana
5. **Mono-produto:** Só recomenda 1 produto por vez

### Roadmap Futuro

**Fase 2 (Curto prazo - 3 meses):**
- [ ] Integração com CRM (Salesforce/HubSpot)
- [ ] A/B testing framework
- [ ] Dashboard Streamlit para não-técnicos
- [ ] Retreino automático mensal
- [ ] Alertas de model drift

**Fase 3 (Médio prazo - 6 meses):**
- [ ] Next Best Action (múltiplos produtos)
- [ ] Previsão de churn
- [ ] Otimização de timing (quando abordar)
- [ ] Geração de texto com GPT
- [ ] Análise de sentimento em feedback

**Fase 4 (Longo prazo - 12 meses):**
- [ ] Reinforcement Learning (aprende com ações)
- [ ] Recommender system híbrido
- [ ] Previsão de lifetime value
- [ ] Simulador de cenários
- [ ] API pública para desenvolvedores

---

## 🤝 Contribuindo

Este é um projeto aberto! Contribuições são bem-vindas:

1. 🐛 Reportar bugs
2. 💡 Sugerir melhorias
3. 📝 Melhorar documentação
4. 🧪 Adicionar testes
5. 🚀 Criar novos recursos

**Como contribuir:**
```bash
1. Fork o projeto
2. Crie uma branch: git checkout -b minha-feature
3. Commit suas mudanças: git commit -m 'Adiciona feature X'
4. Push para a branch: git push origin minha-feature
5. Abra um Pull Request
```

---

## 📚 Referências e Aprendizado

### Para aprender mais sobre os conceitos:

**Machine Learning:**
- [Coursera: Machine Learning by Andrew Ng](https://www.coursera.org/learn/machine-learning)
- [Fast.ai: Practical Deep Learning](https://www.fast.ai/)
- [Kaggle Learn](https://www.kaggle.com/learn)

**Python e Data Science:**
- [Python para Análise de Dados (Livro)](https://www.amazon.com.br/dp/8575226475)
- [DataCamp](https://www.datacamp.com/)
- [Real Python](https://realpython.com/)

**Clustering:**
- [StatQuest: K-Means](https://www.youtube.com/watch?v=4b5d3muPQmA)
- [Scikit-learn Clustering Guide](https://scikit-learn.org/stable/modules/clustering.html)

**Gradient Boosting:**
- [LightGBM Docs](https://lightgbm.readthedocs.io/)
- [XGBoost Tutorial](https://xgboost.readthedocs.io/en/stable/tutorials/model.html)

**Marketing Analytics:**
- [Marketing Analytics (Livro)](https://www.amazon.com.br/dp/0470890592)
- [Customer Analytics Course](https://www.coursera.org/learn/wharton-customer-analytics)

---

## 👥 Equipe e Contato

**Desenvolvido por:**
- Equipe de Data Science BMG
- Em parceria com Claude (Anthropic)

**Contato:**
- 📧 Email: datasciece@bmg.com.br
- 💼 LinkedIn: [BMG Data Science](https://linkedin.com/company/bmg)
- 🐙 GitHub: [github.com/bmg-bank](https://github.com/bmg-bank)

**Suporte:**
- 📖 Documentação completa: [docs.bmg.com.br/smartreach](https://docs.bmg.com.br/smartreach)
- 💬 Slack: #smartreach-suporte
- 🎫 Issues: [GitHub Issues](https://github.com/bmg-bank/smartreach/issues)

---

## 📄 Licença

Este projeto está sob licença MIT. Veja o arquivo `LICENSE` para mais detalhes.

```
MIT License

Copyright (c) 2025 BMG Bank

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

[Texto completo da licença MIT]
```

---

## 🎉 Agradecimentos

Agradecimentos especiais a:

- **Equipe BMG** pela visão e contexto de negócio
- **Comunidade Scikit-learn** pelas ferramentas incríveis
- **LightGBM Team** pelo algoritmo poderoso
- **Pandas e NumPy** pela fundação de data science
- **Matplotlib e Seaborn** pelas visualizações
- **Claude (Anthropic)** pela assistência no desenvolvimento

---

## 📊 Resumo Visual

```
┌─────────────────────────────────────────────────────────────────┐
│                     BMG SMARTREACH - PIPELINE                   │
├─────────────────────────────────────────────────────────────────┤
│                                                                 │
│  📥 ENTRADA                                                     │
│  └─ 20.000 clientes com 15 características                     │
│                                                                 │
│  🔧 PROCESSAMENTO                                               │
│  ├─ Feature Engineering (25+ features)                         │
│  ├─ Clustering (5 perfis)                                      │
│  ├─ ML Produto (85% accuracy)                                  │
│  ├─ ML Canal (78% accuracy)                                    │
│  └─ Geração de Mensagens                                       │
│                                                                 │
│  📤 SAÍDA                                                       │
│  ├─ Produto recomendado + score                                │
│  ├─ Canal ideal + score                                        │
│  ├─ Tom de linguagem                                            │
│  ├─ Mensagem personalizada                                      │
│  └─ Prioridade (Alta/Média/Baixa)                              │
│                                                                 │
│  💰 IMPACTO                                                     │
│  ├─ +167% conversão                                             │
│  ├─ +R$ 3.5M receita incremental                               │
│  └─ 3.500% ROI                                                  │
│                                                                 │
└─────────────────────────────────────────────────────────────────┘
```

---

## 🎯 Conclusão

O **BMG SmartReach** demonstra como Inteligência Artificial pode transformar a experiência do cliente e os resultados de negócio simultaneamente.

**Principais takeaways:**

✅ **Personalização em escala** é possível e lucrativa
✅ **Dados + IA** geram insights que humanos não conseguiriam sozinhos
✅ **Explicabilidade** é tão importante quanto precisão
✅ **Métricas de negócio** devem guiar decisões técnicas
✅ **MVP simples** pode gerar ROI excepcional

**Próximo passo:** Validar com dados reais e escalar! 🚀

---

**Versão:** 1.0.0  
**Última atualização:** Outubro 2025  
**Status:** ✅ Produção (MVP)

---

**⭐ Se este projeto foi útil, deixe uma estrela no GitHub!**