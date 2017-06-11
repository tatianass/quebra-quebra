<?php

//0 => Tipo da Folha
//1 => Estrutura Remuneratória Básica
//2 => Vantagens Pessoais
//3 => --
//4 => Vantagens Eventuais - Função Comissionada
//5 => Vantagens Eventuais - Antecipação e Gratificação Natalina
//6 => Vantagens Eventuais - Horas Extras
//7 => Vantagens Eventuais - Outras Remunerações Eventuais/Provisórias
//8 => Abono Permanência
//9 => --
//10 => Descontos Obrigatórios - Revisão do Teto Constitucional
//11 => Descontos Obrigatórios - Imposto de Renda
//12 => Descontos Obrigatórios - PSSS
//13 => Descontos Obrigatórios - Faltas
//14 => Remuneração Após Descontos Obrigatórios
//15 => --
//16 => Vantagens Indenizatórias e Compensatórias - Diárias
//17 => Vantagens Indenizatórias e Compensatórias - Auxílios
//18 => Vantagens Indenizatórias e Compensatórias - Outras Vantagens Indenizatórias
//
//19 => Tipo da Folha

class Folha
{
    /** @var string */
    private $tipoFolha;
    /** @var string */
    private $estruturaRemuneratoriaBasica;
    /** @var string */
    private $vantagensEventuaisFuncaoComissionada;
    /** @var string */
    private $vantagensEventuaisAntecipacaoGratificacaoNatalina;
    /** @var string */
    private $vantagensEventuaisHorasExtras;
    /** @var string */
    private $vantagensEventuaisOutrasRemuneracoes;
    /** @var string */
    private $abonoPermanencia;
    /** @var string */
    private $descontosRevisaoTeto;
    /** @var string */
    private $descontosImpostoRenda;
    /** @var string */
    private $descontosPSSS;
    /** @var string */
    private $descontosFaltas;
    /** @var string */
    private $vantagensIndenizatoriasDiarias;
    /** @var string */
    private $vantagensIndenizatoriasAuxilios;
    /** @var string */
    private $vantagensIndenizatoriasOutras;

    /**
     * Folha constructor.
     * @param string $tipoFolha
     * @param string $estruturaRemuneratoriaBasica
     * @param string $vantagensEventuaisFuncaoComissionada
     * @param string $vantagensEventuaisAntecipacaoGratificacaoNatalina
     * @param string $vantagensEventuaisHorasExtras
     * @param string $vantagensEventuaisOutrasRemuneracoes
     * @param string $abonoPermanencia
     * @param string $descontosRevisaoTeto
     * @param string $descontosImpostoRenda
     * @param string $descontosPSSS
     * @param string $descontosFaltas
     * @param string $vantagensIndenizatoriasDiarias
     * @param string $vantagensIndenizatoriasAuxilios
     * @param string $vantagensIndenizatoriasOutras
     */
    public function __construct(string $tipoFolha, string $estruturaRemuneratoriaBasica, string $vantagensEventuaisFuncaoComissionada, string $vantagensEventuaisAntecipacaoGratificacaoNatalina, string $vantagensEventuaisHorasExtras, string $vantagensEventuaisOutrasRemuneracoes, string $abonoPermanencia, string $descontosRevisaoTeto, string $descontosImpostoRenda, string $descontosPSSS, string $descontosFaltas, string $vantagensIndenizatoriasDiarias, string $vantagensIndenizatoriasAuxilios, string $vantagensIndenizatoriasOutras)
    {
        $this->tipoFolha = $tipoFolha;
        $this->estruturaRemuneratoriaBasica = $estruturaRemuneratoriaBasica;
        $this->vantagensEventuaisFuncaoComissionada = $vantagensEventuaisFuncaoComissionada;
        $this->vantagensEventuaisAntecipacaoGratificacaoNatalina = $vantagensEventuaisAntecipacaoGratificacaoNatalina;
        $this->vantagensEventuaisHorasExtras = $vantagensEventuaisHorasExtras;
        $this->vantagensEventuaisOutrasRemuneracoes = $vantagensEventuaisOutrasRemuneracoes;
        $this->abonoPermanencia = $abonoPermanencia;
        $this->descontosRevisaoTeto = $descontosRevisaoTeto;
        $this->descontosImpostoRenda = $descontosImpostoRenda;
        $this->descontosPSSS = $descontosPSSS;
        $this->descontosFaltas = $descontosFaltas;
        $this->vantagensIndenizatoriasDiarias = $vantagensIndenizatoriasDiarias;
        $this->vantagensIndenizatoriasAuxilios = $vantagensIndenizatoriasAuxilios;
        $this->vantagensIndenizatoriasOutras = $vantagensIndenizatoriasOutras;
    }

    /**
     * @return string
     */
    public function getTipoFolha(): string
    {
        return $this->tipoFolha;
    }

    /**
     * @return string
     */
    public function getEstruturaRemuneratoriaBasica(): string
    {
        return $this->estruturaRemuneratoriaBasica;
    }

    /**
     * @return string
     */
    public function getVantagensEventuaisFuncaoComissionada(): string
    {
        return $this->vantagensEventuaisFuncaoComissionada;
    }

    /**
     * @return string
     */
    public function getVantagensEventuaisAntecipacaoGratificacaoNatalina(): string
    {
        return $this->vantagensEventuaisAntecipacaoGratificacaoNatalina;
    }

    /**
     * @return string
     */
    public function getVantagensEventuaisHorasExtras(): string
    {
        return $this->vantagensEventuaisHorasExtras;
    }

    /**
     * @return string
     */
    public function getVantagensEventuaisOutrasRemuneracoes(): string
    {
        return $this->vantagensEventuaisOutrasRemuneracoes;
    }

    /**
     * @return string
     */
    public function getAbonoPermanencia(): string
    {
        return $this->abonoPermanencia;
    }

    /**
     * @return string
     */
    public function getDescontosRevisaoTeto(): string
    {
        return $this->descontosRevisaoTeto;
    }

    /**
     * @return string
     */
    public function getDescontosImpostoRenda(): string
    {
        return $this->descontosImpostoRenda;
    }

    /**
     * @return string
     */
    public function getDescontosPSSS(): string
    {
        return $this->descontosPSSS;
    }

    /**
     * @return string
     */
    public function getDescontosFaltas(): string
    {
        return $this->descontosFaltas;
    }

    /**
     * @return string
     */
    public function getVantagensIndenizatoriasDiarias(): string
    {
        return $this->vantagensIndenizatoriasDiarias;
    }

    /**
     * @return string
     */
    public function getVantagensIndenizatoriasAuxilios(): string
    {
        return $this->vantagensIndenizatoriasAuxilios;
    }

    /**
     * @return string
     */
    public function getVantagensIndenizatoriasOutras(): string
    {
        return $this->vantagensIndenizatoriasOutras;
    }

    public function __toString()
    {
        return sprintf('%s;%s;%s;%s;%s;%s;%s;%s;%s;%s;%s;%s;%s;%s;',
            $this->tipoFolha,
            $this->estruturaRemuneratoriaBasica,
            $this->vantagensEventuaisFuncaoComissionada,
            $this->vantagensEventuaisAntecipacaoGratificacaoNatalina,
            $this->vantagensEventuaisHorasExtras ,
            $this->vantagensEventuaisOutrasRemuneracoes,
            $this->abonoPermanencia,
            $this->descontosRevisaoTeto,
            $this->descontosImpostoRenda,
            $this->descontosPSSS,
            $this->descontosFaltas,
            $this->vantagensIndenizatoriasDiarias,
            $this->vantagensIndenizatoriasAuxilios,
            $this->vantagensIndenizatoriasOutras
        );
    }
}
