<?php

function getCodigosServidoresSenado(): array
{
    $content = file_get_contents('lista-servidores-senado.html');
    preg_match_all('/fcodigo=(\d+)/', $content, $matches);

    return $matches[1];
}

$codigos = getCodigosServidoresSenado();
echo implode("\n", $codigos);
