# Tutorial para dados do Senado
Segue os passos utilizados para o download dos dados do site do senado.leg.gov:
1º: Adicionar a extensão de baixar cookies no Mozilla:
https://addons.mozilla.org/pt-BR/firefox/addon/export-cookies/?src=api

2º: Entrar no site: http://www.senado.gov.br/transparencia/rh/servidores/nova_consulta.asp

3º: Selecionar um servidor qualquer

4º: Escolher a data para a qual quer obter os dados

5º: Colocar o captcha e clicar em mais informações

6: Vá em Ferramentas, na barra superior do Mozilla, e clique em baixar cookies

7º: Baixe os dados utilizando o shell do linux com o comando (há comandos semelhantes em outros sistemas operacionais, porém não foram testados):
'''
cat codigos.txt | xargs -i wget "http://www.senado.gov.br/transparencia/rh/servidores/remuneracao.asp?fcodigo={}&fvinculo=&mes=01/01/2017" --load-cookies=cookies.txt 
'''
OBS: codigos.txt está disponível no github do projeto, a data deve ser conforme a selecionada no passo 4 e, os cookies são os que foram baixados no passe 7

