# Carregando bibliotecas
library(readxl)
library(Benchmarking)
library(writexl)
library(ggplot2)
library(dplyr)

# Carregando os dados
exp <- read_excel("exportacoes.xls")
imp <- read_excel("importacoes.xls")
pop <- read_excel("populacao_25_mais.xls")

# Lista de anos
anos <- c("2020", "2021", "2022", "2023", "2024")

# Identificação das DMUs
siglas <- exp[["Sigla"]]
regioes <- exp[["Região"]]  # Certifique-se de que esta coluna existe e está completa

# Lista para armazenar resultados por ano
resultados <- list()
testes_hipotese <- data.frame(
  Ano = character(),
  P_Value = numeric(),
  Modelo_Recomendado = character(),
  stringsAsFactors = FALSE
)

# Loop para análise DEA e teste de hipótese por ano
for (ano in anos) {
  input <- as.matrix(pop[[ano]])
  output <- cbind(exp[[ano]], imp[[ano]])
  
  # Modelos DEA
  dea_crs <- dea(X = input, Y = output, RTS = "crs")
  dea_vrs <- dea(X = input, Y = output, RTS = "vrs", ORIENTATION = "in")
  
  # Eficiências
  eff_crs <- dea_crs$eff
  eff_vrs <- dea_vrs$eff
  eff_scale <- eff_crs / eff_vrs
  
  # Teste de hipótese: H0 = retornos constantes (CRS), H1 = retornos variáveis (VRS)
  teste <- t.test(eff_scale, mu = 1, alternative = "less")
  modelo <- if (teste$p.value < 0.05) "BCC (VRS)" else "CCR (CRS)"
  
  # Armazenar resultado do teste
  testes_hipotese <- rbind(testes_hipotese, data.frame(
    Ano = ano,
    P_Value = round(teste$p.value, 4),
    Modelo_Recomendado = modelo
  ))
  
  # Criar data frame com eficiências
  df <- data.frame(
    Sigla = siglas,
    Regiao = regioes,
    Eficiência_CRS = round(eff_crs, 3),
    Eficiência_VRS = round(eff_vrs, 3),
    Eficiência_Escala = round(eff_scale, 3)
  )
  
  # Salvar no objeto resultados
  resultados[[ano]] <- df
}

# Exportar eficiências por ano em abas separadas
write_xlsx(resultados, path = "eficiencias_DEA_por_ano.xlsx")

# Exportar resultados dos testes de hipótese
write_xlsx(testes_hipotese, path = "testes_hipotese_DEA.xlsx")

# Preparar dados longos para gráficos
eficiencia_long <- bind_rows(
  lapply(names(resultados), function(ano) {
    df <- resultados[[ano]][, c("Sigla", "Regiao", "Eficiência_VRS")]
    df$Ano <- ano
    return(df)
  })
)

# Gerar gráfico por região e salvar como PNG
eficiencia_long %>%
  group_by(Regiao) %>%
  group_split() %>%
  lapply(function(df) {
    regiao_nome <- unique(df$Regiao)
    p <- ggplot(df, aes(x = Ano, y = Eficiência_VRS, group = Sigla, color = Sigla)) +
      geom_line(size = 1) +
      geom_point(size = 2) +
      labs(title = paste("Eficiência DEA (VRS) - Região", regiao_nome),
           x = "Ano", y = "Eficiência VRS") +
      theme_minimal() +
      theme(legend.position = "right",
            axis.text.x = element_text(angle = 45, hjust = 1))
    
    ggsave(filename = paste0("eficiencia_vrs_", regiao_nome, ".png"),
           plot = p, width = 10, height = 6)
  })
