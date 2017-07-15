<?php
ini_set('display_errors', 1);
error_reporting(E_ALL);

function escape(string $value): string {
    return str_replace('\'', '\\\'', $value);
}

chdir('./csv');
$arquivos = glob('{*.csv}', GLOB_BRACE);

foreach ($arquivos as $arquivo) {
    preg_match('/^senado-(\d{4}-\d{2}).csv/', $arquivo, $matches);
    $periodo = $matches[1];
    
    $sqlServidor = '';
    $sqlCargo = '';
    $sqlFolha = '';

    $file = file($arquivo);
    $atributos = explode(',', $file[0]);
//    var_dump($atributos);

    for ($i = 1; $i < count($file); $i++) {
        $registro = explode(',', $file[$i]);

        $idServidor = trim($registro[0]);
        $nomeServidor = trim(escape($registro[1]));
        $anoAdmissaoServidor = trim($registro[4]);
        $sqlServidor .= "REPLACE INTO fagne763_quebraquebra.senado_servidor (id, nome, ano_admissao) "
            . "VALUES ({$idServidor}, '{$nomeServidor}', {$anoAdmissaoServidor});\r\n";

        $cargo = trim(escape($registro[5]));
        $sqlCargo .= "REPLACE INTO fagne763_quebraquebra.senado_cargo (descricao) "
            . "VALUES ('{$cargo}');\r\n";
    }

    file_put_contents("../sql/senado-servidor-{$periodo}.sql", $sqlServidor);
    file_put_contents("../sql/senado-cargo-{$periodo}.sql", $sqlCargo);
}
