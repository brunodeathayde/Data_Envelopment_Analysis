# Exemplo do Data Set milkProd

setwd("/home/Paulus/Dropbox/Ensino UFC/Graduação/Análise de Eficiência e Produtividade/Source/Exemplos")

library(Benchmarking)
data(milkProd)
x <- with(milkProd,cbind(energy,vet,cows))
y <- with(milkProd,cbind(milk))
e <- dea(x,y,RTS="crs")
eff(e)
summary(e)
np <- get.number.peers(e)
peers(e)
vet <- milkProd$vet
(1 - eff(e))*vet
 