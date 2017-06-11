<?php
include_once '../simplehtmldom/simple_html_dom.php';
include_once 'Folha.php';

echo "Tipo da Folha;Estrutura Remuneratória Básica;Vantagens Eventuais - Função Comissionada;Vantagens Eventuais - Antecipação e Gratificação Natalina;Vantagens Eventuais - Horas Extras;Vantagens Eventuais - Outras Remunerações Eventuais/Provisórias;Abono Permanência;Descontos Obrigatórios - Revisão do Teto Constitucional;Descontos Obrigatórios - Imposto de Renda;Descontos Obrigatórios - PSSS;Descontos Obrigatórios - Faltas;Vantagens Indenizatórias e Compensatórias - Diárias;Vantagens Indenizatórias e Compensatórias - Auxílios;Vantagens Indenizatórias e Compensatórias - Outras Vantagens Indenizatórias;\n";

$items = scandir('html');

foreach ($items as $item) {
    if (is_file("html/{$item}")) {
        $html = file_get_html("html/{$item}");

        $valores = $html->find('td.col2_resposta');
        
        $folha = new Folha(
            preg_replace('/<td.*>(.+)<\/td>/', '$1', (string) $valores[0]),
            preg_replace('/<td.*>(.+)<\/td>/', '$1', (string) $valores[1]),
            preg_replace('/<td.*>(.+)<\/td>/', '$1', (string) $valores[4]),
            preg_replace('/<td.*>(.+)<\/td>/', '$1', (string) $valores[5]),
            preg_replace('/<td.*>(.+)<\/td>/', '$1', (string) $valores[6]),
            preg_replace('/<td.*>(.+)<\/td>/', '$1', (string) $valores[7]),
            preg_replace('/<td.*>(.+)<\/td>/', '$1', (string) $valores[8]),
            preg_replace('/<td.*>(.+)<\/td>/', '$1', (string) $valores[10]),
            preg_replace('/<td.*>(.+)<\/td>/', '$1', (string) $valores[11]),
            preg_replace('/<td.*>(.+)<\/td>/', '$1', (string) $valores[12]),
            preg_replace('/<td.*>(.+)<\/td>/', '$1', (string) $valores[13]),
            preg_replace('/<td.*>(.+)<\/td>/', '$1', (string) $valores[16]),
            preg_replace('/<td.*>(.+)<\/td>/', '$1', (string) $valores[17]),
            preg_replace('/<td.*>(.+)<\/td>/', '$1', (string) $valores[18])
        );
        echo "{$folha}\n";
    }
}
