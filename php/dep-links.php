<?php
function getLink(string $periodoFolha, string $nomeParlamentar): string
{
    $url = 'http://www2.camara.leg.br/transpnet/consulta';
    $fields = [
        'periodoFolha' => urlencode($periodoFolha),
        'nome' => urlencode($nomeParlamentar)
    ];
    $strFields = '';

    foreach ($fields as $name => $value) {
        $strFields .= sprintf('%s=%s&', $name, $value);
    }

    $strFields = rtrim($strFields, '&');

    $ch = curl_init();
    curl_setopt($ch, CURLOPT_URL, $url);
    curl_setopt($ch, CURLOPT_RETURNTRANSFER, TRUE);
    curl_setopt($ch, CURLOPT_POST, count($fields));
    curl_setopt($ch, CURLOPT_POSTFIELDS, $strFields);
    $result = curl_exec($ch);
    curl_close($ch);

    preg_match('/<a href="(.+)">' . $nomeParlamentar . '<\/a>/', $result, $matches);
    $link = $matches[1];

    return $link;
}

if (isset($_GET['nome'])) {
    $periodoFolha = $_GET['periodoFolha'];
    $nome = $_GET['nome'];
    $link = sprintf('http://www2.camara.leg.br/transpnet/%s', getLink($periodoFolha, $nome));

    echo $link;
}
