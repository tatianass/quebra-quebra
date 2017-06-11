#!/usr/bin/env bash

ANO=$1

cat data/deputados.txt | parallel -j 1 ./remuneracao_funcionario.sh ${ANO}01 {} > data/deputados_inserts_${ANO}01.sql
# cat deputados.txt | parallel -j 16 ./remuneracao_funcionario.sh ${ANO}02 {} > data/inserts_${ANO}02.sql
# cat deputados.txt | parallel -j 16 ./remuneracao_funcionario.sh ${ANO}03 {} > data/inserts_${ANO}03.sql
# cat deputados.txt | parallel -j 16 ./remuneracao_funcionario.sh ${ANO}04 {} > data/inserts_${ANO}04.sql
# cat deputados.txt | parallel -j 16 ./remuneracao_funcionario.sh ${ANO}05 {} > data/inserts_${ANO}05.sql
# cat deputados.txt | parallel -j 16 ./remuneracao_funcionario.sh ${ANO}06 {} > data/inserts_${ANO}06.sql
# cat deputados.txt | parallel -j 16 ./remuneracao_funcionario.sh ${ANO}07 {} > data/inserts_${ANO}07.sql
# cat deputados.txt | parallel -j 16 ./remuneracao_funcionario.sh ${ANO}08 {} > data/inserts_${ANO}08.sql
# cat deputados.txt | parallel -j 16 ./remuneracao_funcionario.sh ${ANO}09 {} > data/inserts_${ANO}09.sql
# cat deputados.txt | parallel -j 16 ./remuneracao_funcionario.sh ${ANO}10 {} > data/inserts_${ANO}10.sql
# cat deputados.txt | parallel -j 16 ./remuneracao_funcionario.sh ${ANO}11 {} > data/inserts_${ANO}11.sql
# cat deputados.txt | parallel -j 16 ./remuneracao_funcionario.sh ${ANO}12 {} > data/inserts_${ANO}12.sql
