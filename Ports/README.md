# 📊 Seleção de Variáveis com Base na Correlação

Este repositório apresenta um modelo de seleção de variáveis para análise de eficiência, especialmente útil em contextos como Análise Envoltória de Dados (DEA). O objetivo é identificar e remover variáveis altamente correlacionadas entre inputs e outputs, que podem comprometer a explicação e robustez do modelo.

---

## 🧠 Metodologia

O processo de seleção de variáveis segue os seguintes passos:

1. **Leitura dos dados**  
   Os dados são carregados a partir do arquivo `portos.xlsx`, contendo informações sobre diferentes unidades de análise (DMUs).
   Inputs: Extensão de berço (m); Profundidade de calado (m) e Capacidade estática (t).
   Outputs: Navios (quantidade); Movimentação (t); e Movimentação horária (t/dia).

3. **Cálculo da matriz de correlação**  
   É calculada a matriz de correlação entre todas as variáveis de input e output.

4. **Filtragem de variáveis**  
   Variáveis com correlação **maior ou igual a 0.8** são consideradas redundantes e são excluídas do modelo, por serem pouco explicativas ou colineares.

5. **Aplicação do modelo DEA**  
   Após a filtragem, os dados são utilizados para estimar a eficiência técnica das DMUs.

---

## 📁 Estrutura do Repositório

| Arquivo                     | Descrição                                                                 |
|----------------------------|---------------------------------------------------------------------------|
| `portos.xlsx`              | Base de dados com inputs e outputs de portos brasileiros.                 |
| `portos.R`                 | Script em R que realiza a leitura, seleção de variáveis e aplicação DEA. |
| `Sousa Júnior et al. (2013).pdf` | Sousa Junior, J. N. C.; Nobre Junior, E. F.; Prata, B. A.; Mello, J. C. C. B. S. Avaliação da eficiência dos portos utilizando análise envoltória de dados: estudo de caso dos portos da região nordeste do Brasil. Journal of Transport Literature, v. 7, p. 75–106, 2013.         |

---

## 🛠️ Requisitos

- R (versão ≥ 4.0)
- Pacotes:
  - `readxl`
  - `Benchmarking`
  - `corrplot` (opcional para visualização)

