<?php
ini_set('display_errors', 1);
error_reporting(E_ALL);

function escape(string $value): string {
    return trim(strtoupper(str_replace('\'', '\\\'', $value)));
}

chdir('./csv');
$arquivos = glob('{*.csv}', GLOB_BRACE);

foreach ($arquivos as $arquivo) {
    $file = file($arquivo);
    echo "<p>{$arquivo}</p>";
//    $atributos = explode(',', $file[0]);
//    var_dump($atributos);die;

    for ($i = 0; $i < count($file); $i++) {
        $registro = explode(',', $file[$i]);

        $servidor = escape($registro[1]);
        $vinculo = escape($registro[2]);
        $situacao = escape($registro[3]);
        $anoAdmissao = (int)$registro[4];
        $cargo = escape($registro[5]);
        $padrao = escape($registro[6]);
        $especialidade = escape($registro[7]);
        $mes = (int)$registro[8];
        $ano = (int)$registro[9];

        $tipo = escape($registro[10]);
        $remuneracaoBasica = (float)$registro[11];
        $vantagensPessoais = (float)$registro[12];
        $funcaoCargoComissao = (float)$registro[13];
        $gratificacaoNatalina = (float)$registro[14];
        $horasExtras = (float)$registro[15];
        $outrasRemuneracoesEventuais = (float)$registro[16];
        $adicionalPericulosidade = (float)$registro[17];
        $adicionalNoturno = (float)$registro[18];
        $abonoPermanencia = (float)$registro[19];
        $reversao = (float)$registro[20];
        $impostoRenda = (float)$registro[21];
        $psss = (float)$registro[22];
        $faltas = (float)$registro[23];
        $diarias = (float)$registro[25];
        $auxilioAlimentacao = (float)$registro[27];
        $outrasVantagensIndenizatorias = (float)$registro[28];
        $licencaPremio = (float)$registro[29];

        $sql = "INSERT INTO senado_folha (tipo, ano, mes, servidor, ano_admissao, "
            . "vinculo, cargo, padrao, especialidade, situacao, "
            . "remuneracao_basica, vantagens_pessoais, funcao_cargo_comissao, gratificacao_natalina, "
            . "horas_extras, outras_remuneracoes_eventuais, "
            . "adicional_periculosidade, adicional_noturno, "
            . "abono_permanencia, reversao_teto_constitucional, imposto_renda, "
            . "psss, faltas, diarias, auxilio_alimentacao, outras_vantagens_indenizatorias, licenca_premio "
            . ") VALUES ( "
            . "'{$tipo}', '${ano}', {$mes}, '{$servidor}', '{$anoAdmissao}', "
            . "'{$vinculo}', '{$cargo}', '{$padrao}', '{$especialidade}', '{$situacao}', "
            . "{$remuneracaoBasica}, {$vantagensPessoais}, {$funcaoCargoComissao}, {$gratificacaoNatalina}, "
            . "{$horasExtras}, {$outrasRemuneracoesEventuais}, "
            . "{$adicionalPericulosidade}, {$adicionalNoturno}, "
            . "{$abonoPermanencia}, {$reversao}, {$impostoRenda}, "
            . "{$psss}, {$faltas}, {$diarias}, {$auxilioAlimentacao}, {$outrasRemuneracoesEventuais}, {$licencaPremio} "
            . ");\r\n ";

        $tipo = escape($registro[30]);
        $remuneracaoBasica = (float)$registro[31];
        $vantagensPessoais = (float)$registro[32];
        $funcaoCargoComissao = (float)$registro[33];
        $gratificacaoNatalina = (float)$registro[34];
        $horasExtras = (float)$registro[35];
        $outrasRemuneracoesEventuais = (float)$registro[36];
        $adicionalPericulosidade = (float)$registro[37];
        $adicionalNoturno = (float)$registro[38];
        $abonoPermanencia = (float)$registro[39];
        $reversao = (float)$registro[40];
        $impostoRenda = (float)$registro[41];
        $psss = (float)$registro[42];
        $faltas = (float)$registro[43];
        $diarias = (float)$registro[45];
        $auxilioAlimentacao = (float)$registro[47];
        $outrasVantagensIndenizatorias = (float)$registro[48];
        $licencaPremio = (float)$registro[49];

        $sql .= "INSERT INTO senado_folha (tipo, ano, mes, servidor, ano_admissao, "
            . "vinculo, cargo, padrao, especialidade, situacao, "
            . "remuneracao_basica, vantagens_pessoais, funcao_cargo_comissao, gratificacao_natalina, "
            . "horas_extras, outras_remuneracoes_eventuais, "
            . "adicional_periculosidade, adicional_noturno, "
            . "abono_permanencia, reversao_teto_constitucional, imposto_renda, "
            . "psss, faltas, diarias, auxilio_alimentacao, outras_vantagens_indenizatorias, licenca_premio "
            . ") VALUES ( "
            . "'{$tipo}', '${ano}', {$mes}, '{$servidor}', '{$anoAdmissao}', "
            . "'{$vinculo}', '{$cargo}', '{$padrao}', '{$especialidade}', '{$situacao}', "
            . "{$remuneracaoBasica}, {$vantagensPessoais}, {$funcaoCargoComissao}, {$gratificacaoNatalina}, "
            . "{$horasExtras}, {$outrasRemuneracoesEventuais}, "
            . "{$adicionalPericulosidade}, {$adicionalNoturno}, "
            . "{$abonoPermanencia}, {$reversao}, {$impostoRenda}, "
            . "{$psss}, {$faltas}, {$diarias}, {$auxilioAlimentacao}, {$outrasRemuneracoesEventuais}, {$licencaPremio} "
            . ");\r\n ";

        $sqlFile = fopen("../sql/senado-folha-{$ano}-{$mes}.sql", 'a');
        fwrite($sqlFile, $sql);
        fclose($sqlFile);
    }
}
