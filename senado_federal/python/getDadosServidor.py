from bs4 import BeautifulSoup
import urllib.request
import unicodecsv as csv
from unidecode import unidecode
import sys


def getHTML(url):
    return urllib.request.urlopen(url).read()

fp = getHTML('http://www.senado.gov.br/transparencia/rh/servidores/nova_consulta.asp?fnome=&fvinculo=&fsituacao=&flotacao=&fcategoria=&fcargo=0&fsimbolo=&ffuncao=0&fadini=&fadfim=&fconsulta=ok&btnsubmit=Pesquisar')

soup = BeautifulSoup(fp)

table = soup.find('table', attrs={ "class" : "table"})
headers = [header.text for header in table.find('thead').find_all('td')]

rows = []

for row in table.find_all('tr'):
	rows.append([unidecode(val.text).encode("ascii") for val in row.find_all('td')])

with open('../dados/info_servidores.csv', 'wb') as f:
	writer = csv.writer(f, delimiter =";")
	writer.writerow(headers)
	writer.writerows(row for row in rows if row)
