# 📊 DEA Universidades – Documentação do Repositório

Este repositório contém os arquivos utilizados e gerados no estudo de **Análise Envoltória de Dados (DEA)** aplicado às universidades brasileiras, considerando variáveis de insumo e produto.

---

## 📂 Estrutura de Arquivos

| Arquivo | Tipo | Descrição |
|---------|------|-----------|
| **Gualandi Filho et al. (2023).pdf** | Documento | Artigo científico de referência utilizado como base teórica para o modelo DEA. |
| **data.xlsx** | Dados | Base de dados original com variáveis de entrada (inputs) e saída (outputs) para as DMUs (universidades). |
| **eficiencias.xlsx** | Resultados | Planilha com as eficiências calculadas para cada DMU no modelo DEA CCR orientado a outputs. |
| **eficiencias_pesos.xlsx** | Resultados | Planilha com as eficiências considerando restrições de os pesos. |

---

## 📊 Variáveis utilizadas no modelo DEA

| Tipo    | Variável | Descrição |
|---------|----------|-----------|
| **Entrada** | **CC/AE** | Custo Corrente sem hospital universitário / Aluno Equivalente. Razão entre todas as despesas correntes da instituição (excluindo hospitais e maternidades universitários) e a quantidade de alunos equivalentes (graduação, pós-graduação em tempo integral e residência médica). |
| **Entrada** | **AI/PE** | Aluno Tempo Integral / Professor Equivalente. Razão entre o número total de alunos matriculados em tempo integral e o número de professores equivalentes (com ou sem dedicação exclusiva). |
| **Entrada** | **AI/FE** | Aluno Tempo Integral / Funcionário Equivalente sem hospital universitário. Razão entre o número total de alunos matriculados em tempo integral e o número de funcionários equivalentes da instituição (excluindo hospital universitário). |
| **Entrada** | **FE/PE** | Funcionário Equivalente sem hospital universitário / Professor Equivalente. Razão entre o número de professores equivalentes (com ou sem dedicação exclusiva) e o número de funcionários equivalentes (excluindo hospital universitário). |
| **Entrada** | **GPE** | Grau de Participação Estudantil. Razão da quantidade de alunos matriculados em tempo integral pelo número total de alunos. |
| **Entrada** | **GEPG** | Grau de Envolvimento Discente com Pós-graduação. Razão da quantidade de alunos matriculados em programas de pós-graduação (mestrado e doutorado) pelo número total de alunos. |
| **Entrada** | **IQCD** | Índice de Qualificação do Corpo Docente. Grau de qualificação dos professores da instituição, atribuindo pontuações aos níveis de formação (graduado, especialista, mestre e doutor). |
| **Saída** | **CAPES** | Conceito CAPES/MEC para Pós-graduação. Razão entre a média das notas de avaliação Capes dos cursos de mestrado e doutorado e a quantidade de programas de pós-graduação da universidade. |
| **Saída** | **TSG** | Taxa de Sucesso na Graduação. Razão entre o número de alunos concluintes. |

---

## 🚀 Como usar

1. Carregue o arquivo `data.xlsx` no Google Colab ou ambiente Python.  
2. Execute o modelo DEA CCR orientado a outputs com as variáveis listadas acima.  
3. Os resultados de eficiência são exportados para `eficiencias.xlsx`.  
4. Os pesos dos inputs e outputs são exportados para `eficiencias_pesos.xlsx`.  

---

## 📖 Referência

- Gualandi Filho, P. E., Sousa, E. F. D., Carmo, C. T. D., & Gonçalves, T. J. M. (2023). Avaliação de eficiência de universidades federais brasileiras: uma abordagem pela Análise Envoltória de Dados. Avaliação: Revista da Avaliação da Educação Superior (Campinas), 28, e023018.



