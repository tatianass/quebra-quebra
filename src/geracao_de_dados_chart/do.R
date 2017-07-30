source("load.R")
source("clean.R")
source("func.R")

data <- camara
geraJson("vinculo", "camara")
geraJson("cargo", "camara")

data <-senado
geraJson("vinculo", "senado")
geraJson("cargo", "senado")
geraJson("especialidade", "senado")
