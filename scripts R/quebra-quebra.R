#Codigo para conectar no banco.
#install.packages("RMySQL")
#install.packages("plotly")

library(RMySQL)
library(plotly)
mydb = dbConnect(MySQL(), user='bbbbd3102abeeb', password='cf660cf8', dbname='heroku_2767f33366f77cb', host='us-cdbr-iron-east-03.cleardb.net')
data <- dbReadTable(mydb, "folha")

apenasDeputados <- data[data$cargo == "DEPUTADO", ]
apenasDeputados <- apenasDeputados[apenasDeputados$mes == "2", ]
apenasDeputados <- apenasDeputados[apenasDeputados$ano == "2016", ]

# Analise dos gastos de remuneracao mensal
remuneracao_fixa <- sum(apenasDeputados$remuneracao_fixa)
remuneracao_fixa
descontos_mensais <- sum(apenasDeputados$descontos)
descontos_mensais
remuneracao_total <- sum(apenasDeputados$remuneracao_fixa+apenasDeputados$vantagens_pessoais+apenasDeputados$remuneracao_eventual+apenasDeputados$abono_permanencia+apenasDeputados$outros_diarias+apenasDeputados$outros_auxilios+apenasDeputados$outros_vantagens)
remuneracao_total

descontos_fixo_mensais <- remuneracao_fixa-descontos_mensais
descontos_fixo_mensais
remuneracao_total_com_descontos <- remuneracao_total-descontos_mensais
remuneracao_total_com_descontos
descontos_mensais/remuneracao_fixa


p <- plot_ly(y = rnorm(50), type = "box") %>%
  add_trace(y = rnorm(50, 1))
show(p)

# Graficos em 2016
deputadosAno2016 <- apenasDeputados[apenasDeputados$ano=="2016",]
p <- plot_ly(y= deputadosAno2016[deputadosAno2016$mes=="1",]$remuneracao_eventual, type="box", name="Janeiro") %>%
  add_trace(y= deputadosAno2016[deputadosAno2016$mes=="2",]$remuneracao_eventual, name="Fevereiro") %>%
  add_trace(y= deputadosAno2016[deputadosAno2016$mes=="3",]$remuneracao_eventual, name="Marco") %>%
  add_trace(y= deputadosAno2016[deputadosAno2016$mes=="4",]$remuneracao_eventual, name="Abril") %>%
  add_trace(y= deputadosAno2016[deputadosAno2016$mes=="5",]$remuneracao_eventual, name="Maio") %>%
  add_trace(y= deputadosAno2016[deputadosAno2016$mes=="6",]$remuneracao_eventual, name="Junho") %>%
  add_trace(y= deputadosAno2016[deputadosAno2016$mes=="7",]$remuneracao_eventual, name="Julho") %>%
  add_trace(y= deputadosAno2016[deputadosAno2016$mes=="8",]$remuneracao_eventual, name="Agosto") %>%
  add_trace(y= deputadosAno2016[deputadosAno2016$mes=="9",]$remuneracao_eventual, name="Setembro") %>%
  add_trace(y= deputadosAno2016[deputadosAno2016$mes=="10",]$remuneracao_eventual, name="Outubro") %>%
  add_trace(y= deputadosAno2016[deputadosAno2016$mes=="11",]$remuneracao_eventual, name="Novembro") %>%
  add_trace(y= deputadosAno2016[deputadosAno2016$mes=="12",]$remuneracao_eventual, name="Dezembro") %>%
  layout(title="Remuneracao Eventual em 2016", xaxis=list(title="Mes"), yaxis=list(title="Valor Recebido"))
show(p)

#Mais remunerados total em 2016
remuneracao_candidato <- rowSums(deputadosAno2016[,c(7,8,9,10,12,13,14)])-deputadosAno2016$descontos
deputadosAno2016$remuneracao_total <- remuneracao_candidato
sum(deputadosAno2016$remuneracao_total)
remuneracao_total_por_candidato <- aggregate(remuneracao_total~nome, FUN=sum, data=deputadosAno2016)
topDeputadosRemunerados2016 <- remuneracao_total_por_candidato[order(remuneracao_total_por_candidato$remuneracao_total, decreasing=TRUE)[1:10],]
rownames(topDeputadosRemunerados2016) <- NULL
colnames(topDeputadosRemunerados2016) <- c("Nome", "Valor total recebido em 2016")
topDeputadosRemunerados2016


#Mais remunerados eventual em 2016
remuneracao_eventual_por_candidato <- aggregate(remuneracao_eventual~nome, FUN=sum, data=deputadosAno2016)
topDeputadosRemunerados2016 <- remuneracao_eventual_por_candidato[order(remuneracao_eventual_por_candidato$remuneracao_eventual, decreasing=TRUE)[1:10],]
rownames(topDeputadosRemunerados2016) <- NULL
colnames(topDeputadosRemunerados2016) <- c("Nome", "Remuneracao eventual recebida em 2016")
topDeputadosRemunerados2016




#Graficos Remuneracao Eventual em 2017
deputadosAno2017 <- apenasDeputados[apenasDeputados$ano=="2017",]
p <- plot_ly(y= deputadosAno2017[deputadosAno2017$mes=="1",]$remuneracao_eventual, type="box", name="Janeiro") %>%
  add_trace(y= deputadosAno2017[deputadosAno2017$mes=="2",]$remuneracao_eventual, name="Fevereiro") %>%
  add_trace(y= deputadosAno2017[deputadosAno2017$mes=="3",]$remuneracao_eventual, name="Marco") %>%
  add_trace(y= deputadosAno2017[deputadosAno2017$mes=="4",]$remuneracao_eventual, name="Abril") %>%
  layout(title="Remuneracao Eventual em 2017", xaxis=list(title="Mes"), yaxis=list(title="Valor Recebido"))
show(p)

#Graficos Remuneracao Total em 2017
p <- plot_ly(y= deputadosAno2017[deputadosAno2017$mes=="1",]$remuneracao_total, type="box", name="Janeiro") %>%
  add_trace(y= deputadosAno2017[deputadosAno2017$mes=="2",]$remuneracao_total, name="Fevereiro") %>%
  add_trace(y= deputadosAno2017[deputadosAno2017$mes=="3",]$remuneracao_total, name="Marco") %>%
  add_trace(y= deputadosAno2017[deputadosAno2017$mes=="4",]$remuneracao_total, name="Abril") %>%
  layout(title="Remuneracao Total em 2017", xaxis=list(title="Mes"), yaxis=list(title="Valor Recebido"))
show(p)

#Mais remunerados eventual em 2017
remuneracao_eventual_por_candidato <- aggregate(remuneracao_eventual~nome, FUN=sum, data=deputadosAno2017)
topDeputadosRemunerados2017 <- remuneracao_eventual_por_candidato[order(remuneracao_eventual_por_candidato$remuneracao_eventual, decreasing=TRUE)[1:10],]
rownames(topDeputadosRemunerados2017) <- NULL
colnames(topDeputadosRemunerados2017) <- c("Nome", "Remuneracao eventual recebida em 2017")
topDeputadosRemunerados2017

#Mais remunerados total em 2017
remuneracao_candidato <- rowSums(deputadosAno2017[,c(7,8,9,10,12,13,14)])-deputadosAno2017$descontos
deputadosAno2017$remuneracao_total <- remuneracao_candidato
sum(deputadosAno2017$remuneracao_total)
remuneracao_total_por_candidato <- aggregate(remuneracao_total~nome, FUN=sum, data=deputadosAno2017)
topDeputadosRemunerados2017 <- remuneracao_total_por_candidato[order(remuneracao_total_por_candidato$remuneracao_total, decreasing=TRUE)[1:10],]
rownames(topDeputadosRemunerados2017) <- NULL
colnames(topDeputadosRemunerados2017) <- c("Nome", "Valor total recebido em 2017")
topDeputadosRemunerados2017