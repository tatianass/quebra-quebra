#coding=utf-8
#################################################################################
#Author: Italo de Pontes Oliveira						#
#Based on Spotipy API								#
#created in: 08, july, 2017							#
#e-mail: italooliveira at copin dot ufcg dot edu dot br				#
#Github link: github.com/italoPontes/PhdWorks					#
#Whatsapp: +55 83 993 554 224							#
#################################################################################
import os
import sys
		
'''
#################################################################################
# Funcao 'main'
#################################################################################
'''
if __name__ == '__main__':
	############################################################
	#Passing all arguments
	############################################################
	if len(sys.argv) == 4:
		diretorio_de_htmls = sys.argv[1]
		nome_arquivo_saida = sys.argv[2]
		arquivo_de_log = sys.argv[3]
	else:
		print("Você deve chamar: %s [diretorio_entrada] [csv_saida] [log_file]" % (sys.argv[0]))
		sys.exit()
	
	todos_arquivos = os.listdir(diretorio_de_htmls)
	
	for nome_arquivo in todos_arquivos:
		nome_do_arquivo = str("%s/%s" % (diretorio_de_htmls, nome_arquivo))
		command = ("python convert_html_to_csv.py \"%s\" %s %s" % (nome_do_arquivo, nome_arquivo_saida, arquivo_de_log))
		os.system(command)
	
	sys.exit()
