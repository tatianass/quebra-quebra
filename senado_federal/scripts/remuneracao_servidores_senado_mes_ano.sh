#!/usr/bin/env bash

DATA=$1

cat dados/codigos.txt | parallel -j 16 wget "http://www.senado.gov.br/transparencia/rh/servidores/remuneracao.asp?fcodigo={}&fvinculo=&mes=01/${DATA}" --load-cookies=../dados/cookies.txt > dados/remuneracao${DATA}_{}.html