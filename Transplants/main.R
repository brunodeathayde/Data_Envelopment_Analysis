library(Benchmarking)
library(readxl)
library(ggplot2)

# 1. Ler os dados
dados <- read_excel("data.xlsx")
# Extrai os rótulos (estados) da segunda coluna
rotulos <- as.character(dados[[2]])

# 2. Definir inputs e outputs como matrizes
# Input: Número de notificações de morte encefálica (potenciais doadores)
input <- as.matrix(dados[, "X", drop = FALSE])
# Output: Número de órgãos transplantados
output <- as.matrix(dados[, "Y", drop = FALSE])

# 3. Calcular o DEA CCR
dea_result <- dea(input, output, RTS = "crs")
eff_scores <- dea_result$eff
dea_result$eff

# 4. Aplicar bootstrap
# O bootstrap reamostra os dados (inputs e outputs) com reposição, gerando várias 
# versões simuladas do conjunto de dados. Deste modo, calcula a eficiência DEA para 
# cada simulação, avaliando a variabilidade e o viés das eficiências originais.
set.seed(123)
boot_result <- dea.boot(input, output, RTS = "crs", NREP = 1000)

# 5. Calcular estatísticas por DMU
bootstrap_means <- apply(boot_result$boot, 2, mean)
conf_int <- t(apply(boot_result$boot, 2, quantile, probs = c(0.025, 0.975)))
colnames(conf_int) <- c("Lower95", "Upper95")

# 6. Cria o data frame 
df <- data.frame(
  DMU = factor(rotulos, levels = rotulos),  # Mantém a ordem original
  Eff = boot_result$eff,
  Lower = boot_result$conf.int[,1],
  Upper = boot_result$conf.int[,2]
)

# 7. Gera o gráfico 
ggplot(df, aes(x = DMU, y = Eff)) +
  geom_point(color = "blue", size = 3) +
  geom_errorbar(aes(ymin = Lower, ymax = Upper), width = 0.2) +
  labs(title = "Eficiência com Intervalos de Confiança",
       x = "DMU", y = "Eficiência") +
  theme_minimal() +
  theme(axis.text.x = element_text(angle = 45, hjust = 1))  # Inclina os rótulos

#Interpretação do gráfico:
# Círculos (geom_point) → representam a eficiência estimada original de cada DMU, 
# calculada pelo modelo DEA.
# Traços verticais (geom_errorbar) → representam o intervalo de confiança da 
# eficiência, determinado pelo bootstrap.


ggsave("eficiencia_dmus.png", width = 10, height = 6)

