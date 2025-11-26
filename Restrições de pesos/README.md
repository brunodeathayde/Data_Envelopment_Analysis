# DEA com PuLP – Modelo CCR Orientado a Outputs

Este repositório apresenta um exemplo de implementação do **Data Envelopment Analysis (DEA)** em Python utilizando a biblioteca [PuLP](https://coin-or.github.io/pulp/).  
O modelo segue a formulação **CCR (Charnes, Cooper & Rhodes)** com **orientação a outputs**, aplicado a 15 DMUs (Decision Making Units), cada uma com 2 inputs e 1 output.

---

## 📌 Descrição do Modelo

- **Tipo:** DEA CCR (retornos constantes de escala)  
- **Orientação:** Outputs (maximização dos outputs ponderados mantendo os inputs fixos)  
- **Função objetivo:**  
  Maximizar a eficiência da DMU avaliada:  
  

\[
  \max \sum_r u_r \cdot y_{r,dmu}
  \]


- **Normalização:**  
  

\[
  \sum_i v_i \cdot x_{i,dmu} = 1
  \]


- **Restrições:**  
  Para todas as DMUs:  
  

\[
  \sum_r u_r \cdot y_{r,j} \leq \sum_i v_i \cdot x_{i,j}
  \]



---

## 📂 Estrutura dos Dados

- **Inputs:** matriz `inputs` com 15 linhas (DMUs) e 2 colunas (recursos utilizados).  
- **Outputs:** matriz `outputs` com 15 linhas (DMUs) e 1 coluna (resultado obtido).  

Exemplo de dados fictícios:
```python
inputs = [
    [3, 5], [2, 8], [4, 6], [5, 7], [6, 9],
    [3, 4], [7, 8], [2, 3], [4, 5], [5, 6],
    [6, 7], [3, 6], [2, 4], [7, 9], [8, 10]
]

outputs = [
    [5], [6], [8], [7], [9],
    [4], [10], [3], [6], [7],
    [8], [5], [4], [11], [12]
]
