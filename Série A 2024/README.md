# ⚽ Análise de Eficiência no Brasileirão 2024

Este repositório contém scripts em R para avaliar a eficiência dos clubes da Série A do Campeonato Brasileiro, utilizando dois enfoques distintos: modelos orientados a **input** e a **output**.

---

## 📂 Arquivos

- `serie_a.R`: Implementa o **modelo orientado a input**, ideal para analisar quais clubes conseguem maior desempenho com menor investimento.
- `serie_A_output.R`: Implementa o **modelo orientado a output**, focado em identificar quais clubes maximizam seus resultados com os recursos disponíveis.

---

## 🧭 Modelo Orientado a Input

**Foco:** Minimizar os recursos utilizados para alcançar os mesmos resultados.

### Quando usar:
- Avaliar eficiência financeira.
- Comparar clubes que atingem desempenho semelhante com diferentes orçamentos.
- Ideal quando os *outputs* são fixos ou desejáveis (ex.: pontos, saldo de gols).

### Exemplo:
- **Input:** Orçamento  
- **Outputs:** Pontos, saldo de gols  
- **Pergunta:** “Quem está fazendo mais com menos?”

---

## 🚀 Modelo Orientado a Output

**Foco:** Maximizar os resultados com os mesmos recursos.

### Quando usar:
- Avaliar produtividade esportiva.
- Comparar clubes com orçamentos semelhantes.
- Ideal quando os *inputs* são fixos ou controláveis.

### Exemplo:
- **Input:** Orçamento  
- **Outputs:** Pontos, saldo de gols  
- **Pergunta:** “Quem está tirando mais proveito do que investe?”

---

## 🎯 Recomendação Prática

Para o caso do Brasileirão, com orçamento como *input* e desempenho como *output*, o modelo orientado a **input** é geralmente mais adequado. Ele responde à pergunta:

> “Quais clubes são mais eficientes em transformar investimento em desempenho?”

---


## Fontes

Dados sobre os outputs:
https://www.cbf.com.br/futebol-brasileiro/tabelas/campeonato-brasileiro/serie-a/2024

Dados sobre o input:
https://www.capology.com/br/brasileiro/folhas-de-pagamento/2024/
