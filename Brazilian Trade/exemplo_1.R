# Carregando bibliotecas
library(readxl)
library(Benchmarking)

# Definindo o diretório de trabalho
#setwd("/home/Paulus/Dropbox/Ensino UFC/Graduação/Análise de Eficiência e Produtividade/Source/Comércio")

# Carregando os dados de exportações
exp <- read_excel("exportacoes.xls")
exp_2020 <- exp[["2020"]]
exp_2021 <- exp[["2021"]]
exp_2022 <- exp[["2022"]]
exp_2023 <- exp[["2023"]]
exp_2024 <- exp[["2024"]]

# Carregando os dados de importações
imp <- read_excel("importacoes.xls")  # Corrigido: não deve ser o mesmo arquivo de exportações
imp_2020 <- imp[["2020"]]
imp_2021 <- imp[["2021"]]
imp_2022 <- imp[["2022"]]
imp_2023 <- imp[["2023"]]
imp_2024 <- imp[["2024"]]

# Carregando os dados de população de 25 anos ou mais
pop <- read_excel("populacao_25_mais.xls")
pop_2020 <- pop[["2020"]]
pop_2021 <- pop[["2021"]]
pop_2022 <- pop[["2022"]]
pop_2023 <- pop[["2023"]]
pop_2024 <- pop[["2024"]]

# Boxplots salvos em PNG
png("boxplots_comercio_2020.png", width = 1200, height = 400)
par(mfrow = c(1, 3))
boxplot(pop_2020, main = "População (2020)", col = "skyblue", ylab = "Habitantes")
boxplot(exp_2020, main = "Exportações (2020)", col = "lightgreen", ylab = "Valor exportado")
boxplot(imp_2020, main = "Importações (2020)", col = "salmon", ylab = "Valor importado")
par(mfrow = c(1, 1))
dev.off()

# Gráficos de dispersão
png("scatter_pop_exp_2020.png", width = 600, height = 500)
plot(pop_2020, exp_2020, main = "População vs Exportações (2020)",
     xlab = "População em 2020", ylab = "Exportações em 2020", pch = 19, col = "blue")
abline(lm(exp_2020 ~ pop_2020), col = "red", lwd = 2)
dev.off()

png("scatter_pop_imp_2020.png", width = 600, height = 500)
plot(pop_2020, imp_2020, main = "População vs Importações (2020)",
     xlab = "População em 2020", ylab = "Importações em 2020", pch = 19, col = "forestgreen")
abline(lm(imp_2020 ~ pop_2020), col = "orange", lwd = 2)
dev.off()

# Correlações
cor_exp <- cor(pop_2020, exp_2020, method = "pearson", use = "complete.obs")
cor_imp <- cor(pop_2020, imp_2020, method = "pearson", use = "complete.obs")
print(paste("Correlação entre população e exportações:", round(cor_exp, 3)))
print(paste("Correlação entre população e importações:", round(cor_imp, 3)))


