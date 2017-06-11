# quebra-quebra

## Scripts PHP

Este diretório contém os seguintes arquivos:

- **deputados.json** - JSON com o perfil de todos os deputados, resultado da conversão de um arquivo de XML disponível no site da Câmara dos Deputados.
- **dep-nomes-encode.php** - Retorna os nomes de todos os deputados a partir do arquivo __deputados.json__.
- **dep-links.php** - Retorna o link de acesso às informações remunerações de cada deputado de acordo com o nome e o período informados via QueryString.
  - **Exemplo:** dep-links.php?periodoFolha=201704&nome=FULANO+DE+TAL
