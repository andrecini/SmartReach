# 🎯 BMG SmartReach - Inteligência em Vendas
## 📋 Índice
- [🎯 BMG SmartReach - Inteligência em Vendas](#-bmg-smartreach---inteligência-em-vendas)
  - [📋 Índice](#-índice)
  - [🤔 O que é o BMG SmartReach?](#-o-que-é-o-bmg-smartreach)
    - [🎯 Os 4 Pilares da Solução](#-os-4-pilares-da-solução)
  - [👥 Para quem é este projeto?](#-para-quem-é-este-projeto)
  - [🔄 Como funciona?](#-como-funciona)
  - [📚 As 12 Etapas do Projeto](#-as-12-etapas-do-projeto)
  - [▶️ Como executar](#️-como-executar)
    - [1) Preparar ambiente (Windows/VS Code/PowerShell)](#1-preparar-ambiente-windowsvs-codepowershell)
    - [2) Escolher **uma** forma de usar o Gemini](#2-escolher-uma-forma-de-usar-o-gemini)
  - [📈 Resultados esperados](#-resultados-esperados)
  - [🎯 Conclusão](#-conclusão)
  - [📄 Licença](#-licença)
  - [📊 Resumo Visual (pipeline)](#-resumo-visual-pipeline)
  - [🔭 Roadmap (resumido)](#-roadmap-resumido)
  - [🤝 Contribuindo](#-contribuindo)

---

## 🤔 O que é o BMG SmartReach?
O **BMG SmartReach** é um sistema que ajuda o banco BMG a oferecer os **produtos certos** para as **pessoas certas**, no **momento certo** e do **jeito certo**, combinando **IA Clássica (ML)** com **IA Generativa (Gemini)**.

### 🎯 Os 4 Pilares da Solução
1. **QUEM** é o cliente? (perfil/cluster)  
2. **O QUÊ** oferecer? (Consignado, Cartão, Investimento)  
3. **ONDE** abordar? (WhatsApp, Email, App, SMS)  
4. **COMO** falar? (tom formal, amigável, moderno)

---

## 👥 Para quem é este projeto?
- **Vendas**: aumentar conversões  
- **Marketing**: personalização de conteúdo/canal  
- **Negócios**: identificar padrões e oportunidades  
- **Executivos**: visualizar impacto em resultados  
Explicamos em **linguagem simples**, sem exigir programação.

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
│ Aumento Vendas! │
└─────────────────┘
```

---

## 📚 As 12 Etapas do Projeto
**Etapa 1 — Configuração e Imports**  
Ambiente preparado (NumPy, Pandas, Scikit-learn, LightGBM, Matplotlib, Seaborn), seed fixa e estilos de gráfico.

**Etapa 2 — Geração de Dados Sintéticos**  
Base de clientes realista (sem PII) com correlações coerentes (idade, renda, uso de canais, produtos).

**Etapa 3 — Feature Engineering**  
Derivação de +25 variáveis (engajamento digital, afinidades, flags). *(Atualizada para alimentar modelos e clusters).*

**Etapa 4 — Clusterização (K-Means + PCA)**  
Perfis comportamentais com avaliação (silhouette, Davies-Bouldin, Calinski-Harabasz).

**Etapa 5 — Modelo de Produto**  
LightGBM com fallback para RandomForest; métricas: accuracy, F1, ROC-AUC.

**Etapa 6 — Modelo de Canal**  
Abordagem análoga ao modelo de produto com priorização de WhatsApp/App/Email/SMS.

**Etapa 7 — Tom de Linguagem**  
Mapeamento de tom por cluster/estado.

**Etapa 8 — Consolidação de Recomendações**  
`produto_top1`, `canal_top1`, tom, *scores* e prioridade.

**Etapa 9 — KPIs (Simulados)**  
Indicadores de impacto e ROI (para navegação executiva). *(Rótulos de impacto mantidos apenas como ilustração; validar via A/B antes de decisões).*

**Etapa 10 — Visualizações & Explicabilidade**  
Matrizes de confusão, PCA, importâncias (SHAP quando disponível).

**Etapa 11 — Exportações**  
CSV final para CRM com recomendações e *scores*.

**Etapa 12 — Testes e Cliente Customizado (Gemini)**  
Testes do algorítmo com e sem o GEMINI

---

## ▶️ Como executar

### 1) Preparar ambiente (Windows/VS Code/PowerShell)
```powershell
# Atualizadores
python -m pip install --upgrade pip wheel setuptools

# Núcleo de ciência de dados
python -m pip install --upgrade numpy pandas scipy scikit-learn matplotlib seaborn

# Modelagem adicional
python -m pip install --upgrade lightgbm shap

# Gemini (google-genai) e compatibilidades
python -m pip install --upgrade google-genai pydantic typing_extensions==4.15.0

# (Opcional) Evitar conflito com TensorFlow em ambientes mistos
python -m pip install --upgrade "protobuf<5,>=3.20.3"
```

### 2) Escolher **uma** forma de usar o Gemini

**Opção A — Google AI Studio (simples)**  
1. Gere sua **API key no AI Studio**.  
2. Defina variável de ambiente e **reinicie** o terminal:
   ```powershell
   setx GEMINI_API_KEY "SUA_API_KEY_DO_AI_STUDIO"
   ```
3. No notebook, use:
   ```python
   from google import genai
   client = genai.Client(api_key=os.getenv("GEMINI_API_KEY"))
   GEMINI_MODEL = "gemini-2.0-flash-exp"
   ```

**Opção B — Vertex “publishers” (REST)**  
1. Crie a **API key do Cloud** em *Vertex AI > Configurações > Chaves de API*.  
2. Chame o endpoint REST **publishers**:
   ```python
   import os, requests
   API_KEY = os.getenv("API_KEY")
   MODEL = "gemini-2.5-flash-lite"
   url = f"https://aiplatform.googleapis.com/v1/publishers/google/models/{MODEL}:generateContent"
   payload = {"contents":[{"role":"user","parts":[{"text":"Seu prompt"}]}]}
   r = requests.post(url, params={"key": API_KEY}, headers={"Content-Type":"application/json"}, json=payload)
   texto = r.json()["candidates"][0]["content"]["parts"][0]["text"]
   ```

> **Importante:** não misture os modos. A chave do AI Studio **não** funciona no Vertex SDK, e a chave do Cloud **não** funciona no `google-genai`.

---

## 📈 Resultados esperados
- **Recomendações por cliente**: produto + canal + tom + mensagem personalizada  
- **Exportação** para CRM com *scores* e prioridade  
- **Visualizações** para explicar decisões dos modelos  
- **Impacto de negócio** estimado (simulado) para guiar priorização

---

## 🎯 Conclusão
O **BMG SmartReach** mostra como **personalização em escala** é possível ao combinar **Dados + IA** com foco em **métricas de negócio** e **explicabilidade**. Próximo passo: validar com dados reais e **escalar**.

---

## 📄 Licença
MIT — veja `LICENSE`.

---

## 📊 Resumo Visual (pipeline)
```
┌─────────────────────────────────────────────────────────────────┐
│                     BMG SMARTREACH - PIPELINE                   │
├─────────────────────────────────────────────────────────────────┤
│  ENTRADA: 20.000 clientes / 15 variáveis                        │
│  PROCESSO: Features (+25), Clusters (K-Means), ML Produto/Canal │
│  SAÍDA: Recomendações + Mensagem (Gemini) + KPIs                │
└─────────────────────────────────────────────────────────────────┘
```

---

## 🔭 Roadmap (resumido)
- **Curto prazo**: ajustes de features, calibração de *scores*, templates de prompt.  
- **Médio prazo**: Next Best Action, churn, timing de abordagem, **Geração de texto com Gemini**.  
- **Longo prazo**: RL, recomendador híbrido, LTV, simulador de cenários, API pública.

---

## 🤝 Contribuindo
Relate bugs, sugira melhorias, melhore a documentação, adicione testes ou crie novas features. Workflow padrão: fork → branch → commit → PR.
