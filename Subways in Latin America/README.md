# 📊 DEA Subways LA

Este projeto aplica a **Análise Envoltória de Dados (DEA)** para avaliar a eficiência técnica de diferentes sistemas de metrô em Los Angeles, com base em dados como extensão da linha, número de estações e passageiros por dia.

## 📁 Arquivos do repositório

| Arquivo | Descrição |
|--------|-----------|
| `dea_la_subways.R` | Script principal em R que realiza a análise DEA, gera gráficos e exporta resultados. |
| `la_subways.xlsx` | Base de dados com informações dos sistemas de metrô (extensão, estações, passageiros). |
| `eficiencia_vrs.xlsx` | Resultados da eficiência técnica sob o modelo VRS (BCC). |
| `reducao_inputs_para_eficiencia.xlsx` | Estimativas de quanto cada DMU deveria reduzir seus inputs para se tornar eficiente. |
| `boxplots_subways.png` | Boxplots das variáveis analisadas: extensão, estações e passageiros. |
| `scatter_extension_passengers.png` | Gráfico de dispersão entre extensão da linha e passageiros por dia. |
| `scatter_stations_passengers.png` | Gráfico de dispersão entre número de estações e passageiros por dia. |

## 📈 Metodologia

A análise DEA foi conduzida com os seguintes modelos:

- **CCR (CRS)**: Retornos constantes de escala.
- **BCC (VRS)**: Retornos variáveis de escala.

O script também realiza:

- Visualização dos dados com boxplots e gráficos de dispersão.
- Cálculo das correlações entre variáveis.
- Teste de hipótese para escolha entre modelos CCR e BCC.
- Exportação dos *peers* e das reduções necessárias de inputs para eficiência.

## 🚀 Como executar

1. Instale os pacotes necessários:
   ```r
   install.packages(c("readxl", "Benchmarking", "writexl"))
