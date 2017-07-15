<?php
ini_set('display_errors', 1);
error_reporting(E_ALL);

$sqlServidores = '';
$sqlFolha = '';

$file = file('./csv-folha/senado-2017-05.csv');
//var_dump($file);

$atributos = explode(',', $file[0]);
//var_dump($atributos);

for ($i = 1; $i < count($file); $i++) {
    $registro = explode(',', $file[$i]);

    $idServidor = $registro[0];
    $nomeServidor = str_replace('\'', '\\\'', $registro[1]);
    $anoAdmissaoServidor = $registro[4];
    $sqlServidores .= "REPLACE INTO fagne763_quebraquebra.senado_servidor (id, nome, ano_admissao) VALUES ({$idServidor}, '{$nomeServidor}', {$anoAdmissaoServidor});\n";
}

file_put_contents('./sql-folha/senado-servidor-2017-05.sql', $sqlServidores);
