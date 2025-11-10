# === Carregar pacotes ===
library(Benchmarking)
library(readxl)
library(writexl)

# === Ler os dados ===
dados <- read.csv("data.csv", sep = ",", header = TRUE)

# === Definir inputs e outputs como MATRIZES ===
inputs <- as.matrix(dados[, 2:3])     # colunas 2 e 3 = inputs
outputs <- as.matrix(dados[, 4])     # coluna 4 = output

# === DEA orientado a OUTPUT ===
dea_out_crs <- dea(inputs, outputs, RTS = "crs", ORIENTATION = "out")  # CCR
dea_out_vrs <- dea(inputs, outputs, RTS = "vrs", ORIENTATION = "out")  # BCC

# === DEA orientado a INPUT ===
dea_in_crs <- dea(inputs, outputs, RTS = "crs", ORIENTATION = "in")   # CCR
dea_in_vrs <- dea(inputs, outputs, RTS = "vrs", ORIENTATION = "in")   # BCC

# === Eficiências ===
eff_out_crs <- dea_out_crs$eff
eff_out_vrs <- dea_out_vrs$eff
eff_in_crs  <- dea_in_crs$eff
eff_in_vrs  <- dea_in_vrs$eff

# === Índice de escala ===
SE_out <- eff_out_crs / eff_out_vrs
SE_in  <- eff_in_crs / eff_in_vrs

# === Teste de hipótese para retornos de escala (orientação input) ===
teste_in <- t.test(SE_in, mu = 1, alternative = "less")
if (teste_in$p.value < 0.05) {
  cat("📌 Orientação INPUT: Evidência de retornos variáveis de escala (VRS). Modelo BCC recomendado.\n")
} else {
  cat("📌 Orientação INPUT: Retornos constantes de escala (CRS) são plausíveis. Modelo CCR recomendado.\n")
}

# === Teste de hipótese para retornos de escala (orientação output) ===
teste_out <- t.test(SE_out, mu = 1, alternative = "less")
if (teste_out$p.value < 0.05) {
  cat("📌 Orientação OUTPUT: Evidência de retornos variáveis de escala (VRS). Modelo BCC recomendado.\n")
} else {
  cat("📌 Orientação OUTPUT: Retornos constantes de escala (CRS) são plausíveis. Modelo CCR recomendado.\n")
}

# === Criar tabela com todas as eficiências ===
tabela <- data.frame(
  Aeroporto = dados[[1]],
  Eficiência_Input_CCR = round(eff_in_crs, 3),
  Eficiência_Input_VRS = round(eff_in_vrs, 3),
  Eficiência_Output_CCR = round(eff_out_crs, 3),
  Eficiência_Output_VRS = round(eff_out_vrs, 3)
)


# === Salvar em planilha Excel ===
write_xlsx(tabela, "eficiencia_aeroportos.xlsx")

