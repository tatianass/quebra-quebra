from bs4 import BeautifulSoup

def getCodigo(href):
	print(href.split('detalhe.asp?fcodigo='))
	return href.split('detalhe.asp?fcodigo=')[1]

with open("../dados/nova_consulta.html") as fp:
    soup = BeautifulSoup(fp)

with open('../dados/codigos.txt', 'w') as codigos:
    for a in soup.find_all('a', href=True):
        codigos.write(getCodigo(a['href']))
        codigos.write('\n')

codigos.close()
