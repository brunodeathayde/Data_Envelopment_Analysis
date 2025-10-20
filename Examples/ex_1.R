# Exemplo do Data Set charnes1981

setwd("/home/Paulus/Dropbox/Ensino UFC/Graduação/Análise de Eficiência e Produtividade/Source/Exemplos")

library(Benchmarking)
data(charnes1981)
x <- with(charnes1981,cbind(x1,x2,x3,x4,x5))
y <- with(charnes1981,cbind(y1,y2,y3))
e <- dea(x,y,RTS="crs")
eff(e)
summary(e)
np <- get.number.peers(e)
peers(e)
