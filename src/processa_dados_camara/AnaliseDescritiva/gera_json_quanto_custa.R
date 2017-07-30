library(dplyr)

#carregando dados
data_filename = "~/workspace/camara_dados.txt"
data <- read.csv2(file=data_filename, sep=",", header=FALSE, stringsAsFactors=FALSE, na.strings="unknown", dec=".", encoding = "UTF-8")
colnames(data) <-  c("mes","ano","cargo","vinculo","nome","remuneracao_fixa","vantagens_pessoais","remuneracao_eventual","abono_permanencia","descontos","outros_diarias","outros_auxilios","outros_vantagens")


soPensaoCivil <- filter(data, grepl("PARLAMENTAR", vinculo))
