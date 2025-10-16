# Resumo Analítico do Notebook — Bmg.SmartReach.Mvp

_Arquivo analisado_: `Bmg.SmartReach.Mvp.ipynb`

## Visão Geral

- **Dados sintéticos**: 20.000 clientes gerados.
- **Feature engineering**: 60 colunas finais (+45 novas).

- **Clusterização**: K=3 com PCA (5 comps, ~85% var).

- **Modelos supervisionados**: Produto (3 classes) e Canal (4 classes).

- **Mensagens**: 20.000 personalizadas com tom + regionalização (SP/MG).

- **KPIs simulados**: Uplift de vendas e receita, ROI estimado.

## Bloco 2 — Geração de Dados

Principais mensagens:

```

✅ Dados gerados: 20,000 clientes
📊 Primeiras linhas:

```

## Bloco 3 — Feature Engineering

- Status: engenharia concluída; **shape final** `(20000, 60)`; **novas features**: 45.

Amostra de features destacadas (texto do notebook):

```

🔧 Iniciando engenharia de features...
   Shape inicial: (20000, 16)
   ✅ Features comportamentais criadas
   ✅ Features de produtos criadas
   ✅ Features demográficas criadas
   ✅ Features de interação criadas
   ✅ Features estatísticas criadas
   Shape final: (20000, 60)
   Novas features criadas: 45
📊 Amostra de features importantes:
   cliente_id  uso_digital_total  preferencia_digital  score_relacionamento  \
   valor_cliente_norm  e_premium  

```

## Bloco 4 — Clusterização (K-Means + Avaliação)

### Seleção de features para clustering

```

📋 Features para clustering:
   ✅ RobustScaler aplicado (resistente a outliers)
🔬 Aplicando PCA (mantendo 85% da variância)...
🔍 BUSCA INTELIGENTE DO MELHOR K
   Testando k=3... Sil=0.226, DB=1.468, CH=6668
   Testando k=4... Sil=0.218, DB=1.420, CH=6207
   Testando k=5... Sil=0.214, DB=1.395, CH=5802
   Testando k=6... Sil=0.205, DB=1.371, CH=5366
   Testando k=7... Sil=0.208, DB=1.354, CH=5037
   Testando k=8... Sil=0.186, DB=1.400, CH=4782
✅ MELHOR K IDENTIFICADO: 3
📊 MÉTRICAS FINAIS DE QUALIDADE
📊 Distribuição de clientes por cluster:
   ✅ pca_cluster: OK (n_components=5)

```

### Perfil e Nomenclatura dos Clusters

```

📊 Perfil médio por cluster:
🔍 Analisando Cluster 0:
   ✅ Perfil identificado: Consignado Focus
🔍 Analisando Cluster 1:
   ⚠️  Nome descritivo criado: Alta Renda WhatsApp
🔍 Analisando Cluster 2:
   ✅ Perfil identificado: Baixa Renda Emergentes
🏷️  NOMENCLATURA FINAL DOS CLUSTERS
   Cluster 0: Consignado Focus               (10,841 clientes -  54.2%)
   Cluster 1: Alta Renda WhatsApp            (2,195 clientes -  11.0%)
   Cluster 2: Baixa Renda Emergentes         (6,964 clientes -  34.8%)
   Cluster 0: Consignado Focus
   Cluster 1: Alta Renda WhatsApp
   Cluster 2: Baixa Renda Emergentes

```

> **Leitura rápida**

- **Cluster 0 – “Consignado Focus” (54,2%)**: idosos (e_idoso ↑), renda baixa a média, alta penetração de consignado.

- **Cluster 1 – “Alta Renda WhatsApp” (11,0%)**: renda ↑, uso forte de WhatsApp e app; maior probabilidade de investimento.

- **Cluster 2 – “Baixa Renda Emergentes” (34,8%)**: renda ↓, digital emergente, oportunidade de cartão/entrada em produtos.

- **Qualidade**: Silhouette ~0,226 (fraco); DB ~1,47 (bom); CH ~6.668 (excelente). Preferir uso **indicativo** de segmentos.

## Bloco 5 — Modelo de Produto (consignado/cartão/investimento)

```

📋 Features para modelo de produto: 19
📊 Train: 16,000 | Test: 4,000
🎯 Classes: ['cartao' 'consignado' 'investimento']
📈 Distribuição treino:
✅ Accuracy: 0.405
✅ F1-Score (macro): 0.389
✅ F1-Score (weighted): 0.407
✅ Top-2 Accuracy: 0.716 (importante para alternativas!)
              precision    recall  f1-score   support
    accuracy                           0.41      4000
🔄 Validação cruzada (5-fold)...
   F1-Score CV: 0.417 (+/- 0.003)

```

- **Desempenho**: Accuracy 40,5%; F1(macro) 0,389; **Top-2** 71,6% (útil para **segunda opção** de produto).

- **Principais sinais**: tempo_de_casa, valor_cliente_norm, idade, score_relacionamento, renda, uso_digital_total.

## Bloco 6 — Modelo de Canal (app/e-mail/sms/whatsapp)

```

📋 Features para modelo de canal: 21
   1. uso_whatsapp, uso_app, uso_email, uso_sms (uso direto)
   3. taxa_uso_* (proporções)
📈 Distribuição treino:
   taxa_uso_app                 19975 ███████████████████████████████████████████████
   taxa_uso_email               17741 ██████████████████████████████████████████
   taxa_uso_sms                 16939 ████████████████████████████████████████
   idade_x_uso_whatsapp         16576 ███████████████████████████████████████
   diversificacao_canais        16199 ██████████████████████████████████████
   taxa_uso_whatsapp            13841 ████████████████████████████████
   uso_whatsapp                  4838 ███████████
   ✅ uso_whatsapp              Rank: # 1 | Importância: 4838
   F1-Score CV: 0.328 (+/- 0.005)
🔍 ANÁLISE DE ERROS POR CANAL
   app       : Accuracy 0.494 ( 826 amostras)
   email     : Accuracy 0.251 ( 810 amostras)
   sms       : Accuracy 0.423 ( 836 amostras)
   whatsapp  : Accuracy 0.243 (1528 amostras)

```

- **Desempenho**: F1-CV 0,328; variação de acurácia por canal (melhor em **App** e **SMS**; menor em **Email** e **WhatsApp**).

- **Principais sinais**: intensidades/proporções de uso por canal, canal_dominante, diversidade e cruzamentos com idade/renda.

## Blocos 7 a 9 — Tom de Linguagem, Recomendações e Mensagens

### Visão geral de mensagens
```

📝 GERANDO MENSAGENS PERSONALIZADAS
⏳ Processando mensagens com tom inteligente + regionalização...
✅ Mensagens personalizadas geradas!
   • Com regionalização SP/MG: ✅
   • São Paulo: 10,116 mensagens
   • Minas Gerais: 9,884 mensagens

```

### Exemplos (trechos)
```

EXEMPLO 1
👤 Perfil: Consignado Focus
🎨 Tom: Empática e Simples (score: 1.00)
🛍️  Produto: CONSIGNADO (confiança: 77.1%)
📱 Canal: SMS (confiança: 49.4%)
💬 MENSAGEM PERSONALIZADA:
   1️⃣ Tom calculado por características individuais (não apenas cluster)
   3️⃣ Produto e canal mais adequados
   4️⃣ Idade e perfil financeiro do cliente
👤 Perfil: Alta Renda WhatsApp
🎨 Tom: Direta e Moderna (score: 1.00)
🛍️  Produto: CARTAO (confiança: 79.3%)
📱 Canal: APP (confiança: 61.5%)
💬 MENSAGEM PERSONALIZADA:
   1️⃣ Tom calculado por características individuais (não apenas cluster)
   3️⃣ Produto e canal mais adequados
   4️⃣ Idade e perfil financeiro do cliente
👤 Perfil: Alta Renda WhatsApp
🎨 Tom: Consultiva (score: 0.69)
🛍️  Produto: INVESTIMENTO (confiança: 80.3%)
📱 Canal: WHATSAPP (confiança: 37.9%)
💬 MENSAGEM PERSONALIZADA:
   1️⃣ Tom calculado por características individuais (não apenas cluster)
   3️⃣ Produto e canal mais adequados
   4️⃣ Idade e perfil financeiro do cliente
👤 Perfil: Alta Renda WhatsApp
🎨 Tom: Profissional (score: 0.77)
🛍️  Produto: INVESTIMENTO (confiança: 73.4%)
📱 Canal: APP (confiança: 69.7%)
💬 MENSAGEM PERSONALIZADA:
   Bom dia/tarde Cliente 004164, a gente achou investimentos bão demais pro seu perfil, sô. Rentabilidade boa e segurança garantida. Vamo lá, te mostro pelo app? Valeu demais!
   1️⃣ Tom calculado por características individuais (não apenas cluster)
   3️⃣ Produto e canal mais adequados
   4️⃣ Idade e perfil financeiro do cliente
👤 Perfil: Alta Renda WhatsApp
🎨 Tom: Educacional (score: 1.00)
🛍️  Produto: INVESTIMENTO (confiança: 84.3%)
📱 Canal: EMAIL (confiança: 61.4%)
💬 MENSAGEM PERSONALIZADA:
   1️⃣ Tom calculado por características individuais (não apenas cluster)
   3️⃣ Produto e canal mais adequados
   4️⃣ Idade e perfil financeiro do cliente

```

- **Observações**: tom varia de **Empática e Simples** a **Consultiva**, com regionalismos SP/MG e cross-sell quando pertinente.

## Bloco 10 — KPIs de Negócio (Simulados)

```

Leads Qualificados: 4,062
VENDAS:
   Sem IA (baseline): 81 vendas
   Com IA: 243 vendas
   Uplift: +162 vendas (200.0%)
RECEITA (margem):
ROI Estimado: 98%

```

- **Interpretação**: base em **4.062 leads qualificados**, vendas com IA **3x** o baseline, receita incremental **R$ 147k** e **ROI ~98%**.

- **Uso recomendado**: KPIs **hipotéticos** para priorização e cenários; calibrar com dados reais (taxas por produto/canal e ticket).

## Bloco 11 — Exportação e Resumo

```

✅ Arquivo exportado: bmg_smartreach_recomendacoes.csv
RESUMO EXECUTIVO - BMG SMARTREACH MVP (VERSÃO OTIMIZADA)
📊 MODELOS TREINADOS:
💰 IMPACTO DE NEGÓCIO (SIMULADO):
📈 MÉTRICAS DE QUALIDADE:

```

## Bloco 12/13 — Função de Recomendação e Testes

### Teste 1 (Aposentado INSS – tradicional)
```

🧩 Identificando cluster...
   ✅ Cluster: Consignado Focus (ID: 0)
🎨 Calculando tom de linguagem personalizado...
   ✅ Tom: Educacional (score: 1.00)
🛍️  Prevendo produto ideal...
   ✅ Produto: CONSIGNADO (confiança: 66.1%)
📱 Prevendo canal ideal...
   ✅ Canal: SMS (confiança: 42.3%)
💬 Gerando mensagem personalizada...
   ✅ Mensagem gerada com regionalização SP
   Cluster: Consignado Focus (ID: 0)
🎨 TOM DE LINGUAGEM (Calculado por IA)
🎁 PRODUTO RECOMENDADO
📱 CANAL RECOMENDADO
   Razão: Cliente idoso | Renda baixa | Alto uso WhatsApp | Não possui o produto
💬 MENSAGEM PERSONALIZADA
   📩 Prezado(a) Maria Silva! Preparamos um crédito consignado seguro e transparente especialmente para você. Desconto automático na folha, sem surpresas. Cola aqui, explico tudo pelo sms. Valeu!

```

### Teste 2 (Servidor público – investidor)
```

🧩 Identificando cluster...
   ✅ Cluster: Alta Renda WhatsApp (ID: 1)
🎨 Calculando tom de linguagem personalizado...
   ✅ Tom: Profissional (score: 0.77)
🛍️  Prevendo produto ideal...
   ✅ Produto: INVESTIMENTO (confiança: 52.6%)
📱 Prevendo canal ideal...
   ✅ Canal: WHATSAPP (confiança: 44.7%)
💬 Gerando mensagem personalizada...
   ✅ Mensagem gerada com regionalização MG
   Cluster: Alta Renda WhatsApp (ID: 1)
🎨 TOM DE LINGUAGEM (Calculado por IA)
🎁 PRODUTO RECOMENDADO
📱 CANAL RECOMENDADO
💬 MENSAGEM PERSONALIZADA

```

### Teste 3 (CLT jovem – digital)
```

    ✓ Não possui nenhum produto (grande oportunidade!)
🧩 Identificando cluster...
   ✅ Cluster: Baixa Renda Emergentes (ID: 2)
🎨 Calculando tom de linguagem personalizado...
   ✅ Tom: Direta e Moderna (score: 1.00)
   📝 Objetiva, usa emojis moderadamente, tom jovem
🛍️  Prevendo produto ideal...
   ✅ Produto: INVESTIMENTO (confiança: 60.0%)
📱 Prevendo canal ideal...
   ✅ Canal: APP (confiança: 38.4%)
💬 Gerando mensagem personalizada...
   ✅ Mensagem gerada com regionalização SP
   Cluster: Baixa Renda Emergentes (ID: 2)
🎨 TOM DE LINGUAGEM (Calculado por IA)
   Descrição: Objetiva, usa emojis moderadamente, tom jovem
🎁 PRODUTO RECOMENDADO
📱 CANAL RECOMENDADO
💬 MENSAGEM PERSONALIZADA

```

### Teste 4 (Perfil premium – alto valor)
```

    ✓ Múltiplos produtos (2)
🧩 Identificando cluster...
   ✅ Cluster: Alta Renda WhatsApp (ID: 1)
🎨 Calculando tom de linguagem personalizado...
   ✅ Tom: Educacional (score: 0.87)
🛍️  Prevendo produto ideal...
   ✅ Produto: INVESTIMENTO (confiança: 46.0%)
📱 Prevendo canal ideal...
   ✅ Canal: WHATSAPP (confiança: 35.4%)
💬 Gerando mensagem personalizada...
   ✅ Mensagem gerada com regionalização MG
   Cluster: Alta Renda WhatsApp (ID: 1)
🎨 TOM DE LINGUAGEM (Calculado por IA)
🎁 PRODUTO RECOMENDADO
📱 CANAL RECOMENDADO
💬 MENSAGEM PERSONALIZADA

```

## Recomendações Práticas

- **Clusters**: usar como **segmentação base**; considerar GMM/HDBSCAN e variáveis de valor para refino.

- **Produto**: explorar **Top-2** na regra de decisão e calibrar limiares de confiança.

- **Canal**: treinar por **subpopulações** (ex.: 60+ vs. <40) e balancear classes; avaliar **modelos hierárquicos**.

- **Mensagens**: A/B de tom e gatilhos; reescrever para CTAs curtos; reforçar **consentimento LGPD**.

- **KPIs**: substituir suposições por **taxas reais**; incluir **CPL/CAC**, **LTV** e **margem** por produto.
