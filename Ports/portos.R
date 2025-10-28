library(Benchmarking)
library(readxl)

# Carregar dados ===
dados <- read_excel("portos.xlsx")

# Converter colunas para numéricas (exceto a 1ª, que é o nome da DMU)
dados[, 2:7] <- lapply(dados[, 2:7], function(x) as.numeric(as.character(x)))

# Vetor de DMUs
DMUs <- dados[[1]]

# Inputs: colunas 2 a 4
inputs <- as.data.frame(dados[, 2:4])
# Outputs: colunas 5 a 7
outputs <- as.data.frame(dados[, 5:7])

# Modelo inicial (todas as variáveis) 
dea_full <- dea(inputs,outputs, RTS = "crs")
eff_full <- efficiencies(dea_full)
cat("Eficiências originais (todas as variáveis):\n")
print(round(eff_full, 2))

# === 3. Visualizar correlações ===
cat("\nMatriz de correlação - Inputs:\n")
print(round(cor(inputs), 2))
cat("\nMatriz de correlação - Outputs:\n")
print(round(cor(outputs), 2))

# === 4. Função para remover variáveis altamente correlacionadas ===
remove_high_corr <- function(df, threshold = 0.8) {
  corr_matrix <- cor(df)
  vars_to_remove <- c()
  
  for (i in 1:(ncol(corr_matrix)-1)) {
    for (j in (i+1):ncol(corr_matrix)) {
      if (abs(corr_matrix[i, j]) >= threshold) {  # >= agora
        # Remover a variável com menor variabilidade (menor desvio padrão)
        sd_i <- sd(df[[i]], na.rm = TRUE)
        sd_j <- sd(df[[j]], na.rm = TRUE)
        if (sd_i < sd_j) {
          vars_to_remove <- c(vars_to_remove, colnames(df)[i])
        } else {
          vars_to_remove <- c(vars_to_remove, colnames(df)[j])
        }
      }
    }
  }
  
  vars_to_remove <- unique(vars_to_remove)
  if (length(vars_to_remove) > 0) {
    cat("\nVariáveis removidas por alta correlação (|r| ≥", threshold, "):",
        paste(vars_to_remove, collapse = ", "), "\n")
    df <- df[, !(colnames(df) %in% vars_to_remove), drop = FALSE]
  } else {
    cat("\nNenhuma variável removida (nenhuma correlação ≥", threshold, ").\n")
  }
  
  return(df)
}

# Aplicar a função aos inputs e outputs 
inputs_auto <- remove_high_corr(inputs, threshold = 0.8)
outputs_auto <- remove_high_corr(outputs, threshold = 0.8)

# Modelo com variáveis selecionadas 
dea_auto <- dea(inputs_auto, outputs_auto, RTS = "crs")
eff_auto <- efficiencies(dea_auto)

# Comparar resultados ===
comparison <- data.frame(
  DMU = DMUs,
  Eff_full = round(eff_full, 2),
  Eff_auto = round(eff_auto, 2)
)
comparison$Diff <- comparison$Eff_auto - comparison$Eff_full

cat("\nComparação de eficiências (antes vs. depois da seleção):\n")
print(comparison)

cat("\nInputs finais utilizados:\n")
print(colnames(inputs_auto))
cat("Outputs finais utilizados:\n")
print(colnames(outputs_auto))

