<?php

function getNomesParlamentares(): array
{
    $json = file_get_contents('deputados.json');
    preg_match_all('/"nome": "(.+)"/', $json, $matches);

    $nomesParlamentares = [];

    foreach ($matches[0] as $match) {
        $nomesParlamentares[] = urlencode(preg_replace('/"nome": "(.+)"/', '$1', $match));
    }

    return $nomesParlamentares;
}

foreach (getNomesParlamentares() as $nome) {
    echo "{$nome}\n";
}
