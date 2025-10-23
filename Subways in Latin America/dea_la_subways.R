# Pacotes necessários
library(readxl)
library(Benchmarking)
library(writexl)

# Caminho da pasta onde os arquivos serão salvos
setwd("C:/Users/bruno/OneDrive/Documentos/Subways in LA")

# Para rodar o script todo de uma vez
# Ctrl + Shift + Enter (Linux/Windows) ou Cmd + Shift + Enter (Mac)

# Leitura da planilha
data <- read_xlsx("la_subways.xlsx")

# Conversão das variáveis para numérico
extension   <- as.numeric(gsub("[^0-9\\.]", "", data[["Extensão (km)"]]))
stations    <- as.numeric(gsub("[^0-9\\.]", "", data[["Estações"]]))
passengers  <- as.numeric(gsub("[^0-9\\.]", "", data[["Passageiros/dia"]]))

# Boxplots salvos em PNG
png("boxplots_subways.png", width = 1200, height = 400)
par(mfrow = c(1, 3))
boxplot(extension, main = "Extensão (km)", col = "skyblue", ylab = "km")
boxplot(stations, main = "Estações", col = "lightgreen", ylab = "Quantidade")
boxplot(passengers, main = "Passageiros/dia", col = "salmon", ylab = "Pessoas por dia")
par(mfrow = c(1, 1))
dev.off()

# Gráficos de dispersão
png("scatter_extension_passengers.png", width = 600, height = 500)
plot(extension, passengers, main = "Extensão (km) vs Passageiros/dia",
     xlab = "Extensão (km)", ylab = "Passageiros por dia", pch = 19, col = "blue")
abline(lm(passengers ~ extension), col = "red", lwd = 2)
dev.off()

png("scatter_stations_passengers.png", width = 600, height = 500)
plot(stations, passengers, main = "Estações vs Passageiros/dia",
     xlab = "Número de Estações", ylab = "Passageiros por dia", pch = 19, col = "forestgreen")
abline(lm(passengers ~ stations), col = "orange", lwd = 2)
dev.off()

# Correlações
cor_ext <- cor(extension, passengers)
cor_sta <- cor(stations, passengers)
print(paste("Correlação entre extensão e passageiros:", round(cor_ext, 3)))
print(paste("Correlação entre estações e passageiros:", round(cor_sta, 3)))

# Modelo DEA
inputs <- cbind(extension, stations)
outputs <- cbind(passengers)

# Modelo CRS (CCR)
e_crs <- dea(inputs, outputs, RTS = "crs")

# Modelo VRS (BCC)
#e_vrs <- dea(inputs, outputs, RTS = "vrs")
e_vrs <- dea(inputs, outputs, RTS = "vrs", ORIENTATION = "in")

# Eficiências
eff_crs <- e_crs$eff
eff_vrs <- e_vrs$eff
SE <- eff_crs / eff_vrs
print(SE)

# Teste de hipótese
teste <- t.test(SE, mu = 1, alternative = "less")
if (teste$p.value < 0.05) {
  cat("Resultado: p-value =", round(teste$p.value, 4), "\n")
  cat("Evidência de retornos variáveis de escala (VRS). Modelo BCC recomendado.\n")
} else {
  cat("Resultado: p-value =", round(teste$p.value, 4), "\n")
  cat("Retornos constantes de escala (CRS) são plausíveis. Modelo CCR recomendado.\n")
}

# Exportando resultados

# 1. Eficiências técnicas
eficiencia_df <- data.frame(
  DMU = data[[1]],
  Eficiencia_VRS = e_vrs$eff
)
write_xlsx(eficiencia_df, "eficiencia_vrs.xlsx")

# 2. Peers (unidades de referência)
# Determinar os peers da i-ésima DMU
peers(e_vrs)  

# Eficiência técnica VRS
eff_vrs <- e_vrs$eff

# Cálculo das reduções necessárias
reducao_extensao <- (1 - eff_vrs) * extension
reducao_estacoes <- (1 - eff_vrs) * stations

# Criação do dataframe com os resultados
reducao_df <- data.frame(
  DMU = data[[1]],
  Eficiencia_VRS = round(eff_vrs, 4),
  Extensao_Atual = extension,
  Reducao_Extensao = round(reducao_extensao, 2),
  Estacoes_Atual = stations,
  Reducao_Estacoes = round(reducao_estacoes, 2)
)

# Exportar para Excel
write_xlsx(reducao_df, "reducao_inputs_para_eficiencia.xlsx")


