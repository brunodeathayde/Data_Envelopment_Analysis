# Análise de Eficiência com DEA Bootstrap

Este repositório contém os arquivos utilizados para realizar uma análise de eficiência técnica de unidades de decisão (DMUs) utilizando o método DEA (Data Envelopment Analysis) com simulações via bootstrap.

## 📂 Arquivos incluídos

- **`main.R`**  
  Script principal em R que realiza a análise DEA, aplica o bootstrap e gera os gráficos de eficiência com intervalos de confiança.

- **`data.xlsx`**  
  Base de dados contendo os inputs e outputs das DMUs. A segunda coluna contém os rótulos utilizados nos gráficos.
  Input: Número de notificações de morte encefálica (potenciais doadores).
  Output: Número de órgãos transplantados.
  DMUs: Estados do Brasil.

- **`eficiencia_dmus.png`**  
  Gráfico gerado pelo script, mostrando a eficiência estimada de cada DMU com seus respectivos intervalos de confiança.

- **`Marinho and Araújo (2021).pdf`**  
  Artigo de referência utilizado como base teórica para a metodologia aplicada.

## 📊 Metodologia

A análise foi realizada com:

- DEA com retornos constantes de escala (RTS = "crs")
- Simulações bootstrap com 1000 repetições
- Correção de viés nas eficiências estimadas
- Visualização dos resultados com `ggplot2`

## 📚 Referência

Marinho, A., & Araújo, C. A. S. (2021). Using data envelopment analysis and the bootstrap method to evaluate organ transplantation efficiency in Brazil. Health Care Management Science, 24(3), 569-581. [PDF incluído]

## 🚀 Como executar

1. Instale os pacotes necessários no R:
   ```r
   install.packages(c("Benchmarking", "readxl", "ggplot2"))
