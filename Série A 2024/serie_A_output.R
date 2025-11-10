library(Benchmarking)
library(readxl)
library(writexl)  

# === Ler os dados ===
dados <- read_excel("serie_A_2024.xlsx")

# === Definir inputs e outputs como MATRIZES ===
inputs <- as.matrix(dados[, 2, drop = FALSE])         # coluna 2 = input
outputs <- as.matrix(dados[, 3:4, drop = FALSE])      # colunas 3 e 4 = outputs

# === Calcular DEA CCR e BCC (orientação output) ===
e_crs <- dea(inputs, outputs, RTS = "crs", ORIENTATION = "out")  # Modelo CCR
e_vrs <- dea(inputs, outputs, RTS = "vrs", ORIENTATION = "out")  # Modelo BCC

# === Calcular eficiências e índice de escala ===
eff_crs <- e_crs$eff
eff_vrs <- e_vrs$eff
SE <- eff_crs / eff_vrs
print(SE)

# === Teste de hipótese para retornos de escala ===
teste <- t.test(SE, mu = 1, alternative = "less")
if (teste$p.value < 0.05) {
  cat("Resultado: p-value =", round(teste$p.value, 4), "\n")
  cat("📌 Evidência de retornos variáveis de escala (VRS). Modelo BCC recomendado.\n")
} else {
  cat("Resultado: p-value =", round(teste$p.value, 4), "\n")
  cat("📌 Retornos constantes de escala (CRS) são plausíveis. Modelo CCR recomendado.\n")
}

# === Criar tabela com times e eficiências ===
tabela <- data.frame(
  Time = dados[[1]],              # nomes dos times na coluna 1
  Eficiência = eff_vrs            # eficiências calculadas
)

# === Salvar em planilha Excel ===
write_xlsx(tabela, "eficiencia_times_outputs.xlsx")

