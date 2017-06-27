#Autor: Ítalo de Pontes
#Os CSV's são gerados mensalmente, assim, para cada arquivo de dados, uma nova variável é atribuida
#Input in UTF-8 format
mesReferencia = "~/Dropbox/quebraquebra/camara/2015/RemuneracaoMensalServidores012015.csv"

#Por convensão, decidiu-se utilizar o formato de arquivo CSV, logo
#o separador sempre será a vírgula. Essa decisão foi inspirada nos
#modelos fornecidos pela própria câmara, disponível em:
#http://www2.camara.leg.br/transparencia/recursos-humanos/remuneracao/relatorios-consolidados-por-ano-e-mes/esclarecimentos-consulta-remuneracao
#Read without 'factors': https://stackoverflow.com/questions/5187745/imported-a-csv-dataset-to-r-but-the-values-becomes-factors
data <- read.csv2(file=mesReferencia, sep=";", header=FALSE, stringsAsFactors=FALSE, na.strings="unknown", skip=1) #Skip o header

#dec="." <- testar isso

###########################################################
#Adiciona coluna mes a todos os dados e concatena em uma só variável
###########################################################
colnames(data) <-  c("cargo","grupo_funcional","folha_pagamento","ano_ingresso","remuneracao_fixa","vantagens_pessoais","funcao_comissao","gratificacao_natalina","ferias","remuneracoes_eventuais","abono_permanencia","redutor_constitucional","previdencia","imposto_renda","remuneracao_apos_desconto","diarias","auxilios","vantagens_indenizatorias")

###########################################################
#Quantos funcionários constam na folha de pagamento deste mês?
###########################################################
qntdServidores <- nrow(data)

###########################################################
#Quantos milhões/bilhões são pagos mensalmente em <...>?
###########################################################
sum(data$remuneracao_fixa)
sum(data$vantagens_pessoais)
sum(data$funcao_comissao)
sum(data$gratificacao_natalina)
sum(data$ferias)
sum(data$remuneracoes_eventuais)
sum(data$abono_permanencia)
sum(data$redutor_constitucional)
#previdencia
#imposto_renda
sum(data$remuneracao_apos_desconto)
sum(data$diarias)
sum(data$auxilios)
sum(data$vantagens_indenizatorias)

###########################################################
#Qual total mensal?                                       #
###########################################################
sum(data$remuneracao_fixa,data$vantagens_pessoais,data$funcao_comissao,data$gratificacao_natalina,data$ferias,data$remuneracoes_eventuais,data$abono_permanencia,data$redutor_constitucional,data$previdencia,data$imposto_renda,data$diarias,data$auxilios,data$vantagens_indenizatorias)
#Removido "Remuneração apos descontos"

###########################################################
#Quais são os top 10 salários em 2016 (no geral)          #
###########################################################
salariosAgregados <- aggregate(remuneracao_apos_desconto~cargo, FUN=sum, data)
topSalarios <- salariosAgregados[order(salariosAgregados$remuneracao_apos_desconto, decreasing=TRUE)[1:10],]
rownames(topSalarios) <- NULL
colnames(topSalarios) <- c("Cargo", "Remuneracao após desconto")
topSalarios

###########################################################
#Quais cargos mais bem remunerados?                       #
###########################################################
library("dplyr")

topSalariosFunction <- function(data)
{
  salariosAgregados <- aggregate(remuneracao_apos_desconto~cargo, FUN=sum, data)
  topSalarios <- salariosAgregados[order(salariosAgregados$remuneracao_apos_desconto, decreasing=TRUE)[1:10],]
  rownames(topSalarios) <- NULL
  colnames(topSalarios) <- c("Cargo", "Remuneracao")
  return(topSalarios)
}

#Filtra os funcionários de cada cargo
soAnalista <- filter(data, grepl("Analista Legislativo", cargo))
soTecnico <- filter(data, grepl("cnico Legislativo", cargo))
soSecretario <- filter(data, grepl("Secret", cargo))
soNaturezaEspecial <- filter(data, grepl("Cargo de Natureza Especial", cargo))
soDeputado <- filter(data, grepl("Deputado", cargo))
soOutros <- filter(data, !grepl("Analista Legislativo|cnico Legislativo|Secret|Cargo de Natureza Especial|Deputado", cargo))

#Retorna os top 10 salários de cada cargo
analistas <- topSalariosFunction(soAnalista)
tecnicos <- topSalariosFunction(soTecnico)
secretarios <- topSalariosFunction(soSecretario)
especiais <- topSalariosFunction(soNaturezaEspecial)
deputado <- topSalariosFunction(soDeputado)
outros <- topSalariosFunction(soOutros)

#Mostra o top 10 de cada cargo
show(analistas)
show(tecnicos)
show(secretarios)
show(especiais)
show(deputado)
show(outros)

#Relaciona o total obtido com o total real
totalAnalista <- sum(soAnalista$remuneracao_apos_desconto)
totalTecnico <- sum(soTecnico$remuneracao_apos_desconto)
totalSecretario <- sum(soSecretario$remuneracao_apos_desconto)
totalNatureza <- sum(soNaturezaEspecial$remuneracao_apos_desconto)
totalDeputado <- sum(soDeputado$remuneracao_apos_desconto)
totalOutros <- sum(outros$remuneracao_apos_desconto)

somaObtida <- (totalAnalista+totalTecnico+totalSecretario+totalNatureza+totalDeputado+totalOutros)
somaReal <- sum(data$remuneracao_apos_desconto)
#Diferença de:
somaReal-somaObtida
#Proporção de:
(somaObtida/somaReal)*100

###########################################################
#Filtrar por grupo funcional
###########################################################
soQuadroEfetivo <- filter(data, grepl("QUADRO EFETIVO - RJU", grupo_funcional))
soCargoNaturezaEspecial <- filter(data, grepl("CARGO DE NATUREZA ESPECIAL", grupo_funcional))
soInativo <- filter(data, grepl("INATIVO", grupo_funcional))
soParlamentar <- filter(data, grepl("PARLAMENTAR", grupo_funcional))
soPensaoCivil <- filter(data, grepl("PENSÃO CIVIL", grupo_funcional))

#top 10 remuneracoes por grupo funcional
topQuadroEfetivo <- topSalariosFunction(soQuadroEfetivo)
topNaturezaEspecial <- topSalariosFunction(soCargoNaturezaEspecial)
topInativo <- topSalariosFunction(soInativo)
topParlamentar <- topSalariosFunction(soParlamentar)
topPensaoCivil <- topSalariosFunction(soPensaoCivil)

#Mostra as top 10 remuneracoes em diferentes grupos funcionais
show(topQuadroEfetivo)
show(topNaturezaEspecial)
show(topInativo)
show(topParlamentar)
show(topPensaoCivil)

#Calcula total por Quadro Funcional
totalQuadroEfetivo <- sum(soQuadroEfetivo$remuneracao_apos_desconto)
totalCargoNatureza <- sum(soCargoNaturezaEspecial$remuneracao_apos_desconto)
totalParlamentar <- sum(soParlamentar$remuneracao_apos_desconto)
totalInativo <- sum(soInativo$remuneracao_apos_desconto)
totalPensao <- sum(soPensaoCivil$remuneracao_apos_desconto)

somaObtidaTodosCargos <- sum(totalQuadroEfetivo+totalCargoNatureza+totalParlamentar+totalInativo+totalPensao)
#Diferença de:
somaReal-somaObtidaTodosCargos
#Proporção de:
(somaObtidaTodosCargos/somaReal)*100

###########################################################
#Quantos deputados receberam no ano X acima do teto (33k)?
###########################################################
#install.packages("plotly")
library(plotly)
p <- plot_ly(y= data[data$mes=="1",]$remuneracao_total, type="box", name="Janeiro") %>%
  add_trace(y= deputadosAno2017[deputadosAno2017$mes=="2",]$remuneracao_total, name="Fevereiro") %>%
  add_trace(y= deputadosAno2017[deputadosAno2017$mes=="3",]$remuneracao_total, name="Marco") %>%
  add_trace(y= deputadosAno2017[deputadosAno2017$mes=="4",]$remuneracao_total, name="Abril") %>%
  layout(title="Remuneracao Total em 2017", xaxis=list(title="Mes"), yaxis=list(title="Valor Recebido"))
show(p)
