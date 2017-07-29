# Senado Federal

CREATE TABLE senado_tipo_folha (
  id SMALLINT UNSIGNED NOT NULL AUTO_INCREMENT,
  descricao VARCHAR(100) UNIQUE NOT NULL,
  CONSTRAINT pk_senado_tipo_folha PRIMARY KEY(id)
) DEFAULT CHARACTER SET utf8 COLLATE utf8_unicode_ci;

INSERT INTO senado_tipo_folha (descricao) VALUES ('NORMAL'), ('SUPLEMENTAR');

CREATE TABLE senado_servidor (
  id INT UNSIGNED NOT NULL AUTO_INCREMENT,
  nome VARCHAR(150) NOT NULL,
  ano_admissao YEAR(4) NOT NULL,
  CONSTRAINT pk_senado_servidor PRIMARY KEY(id)
) DEFAULT CHARACTER SET utf8 COLLATE utf8_unicode_ci;

CREATE TABLE senado_vinculo (
  id SMALLINT UNSIGNED NOT NULL AUTO_INCREMENT,
  descricao VARCHAR(100) UNIQUE NOT NULL,
  CONSTRAINT pk_senado_vinculo PRIMARY KEY(id)
) DEFAULT CHARACTER SET utf8 COLLATE utf8_unicode_ci;

INSERT INTO senado_vinculo (descricao) VALUES ('EFETIVO'), ('COMISSIONADO'), ('REQUISITADO');

CREATE TABLE senado_cargo (
  id SMALLINT UNSIGNED NOT NULL AUTO_INCREMENT,
  descricao VARCHAR(100) UNIQUE NOT NULL,
  CONSTRAINT pk_senado_cargo PRIMARY KEY(id)
) DEFAULT CHARACTER SET utf8 COLLATE utf8_unicode_ci;

INSERT INTO senado_cargo (descricao) VALUES
  ('ADVOGADO'), ('ANALISTA LEGISLATIVO'), ('CARGO ISOLADO'), ('CONSULTOR LEGISLATIVO'),
  ('IPC'), ('REQUISITADO SEM CARGO'), ('TÉCNICO LEGISLATIVO');

CREATE TABLE senado_situacao (
  id SMALLINT UNSIGNED NOT NULL AUTO_INCREMENT,
  descricao VARCHAR(100) UNIQUE NOT NULL,
  CONSTRAINT pk_senado_situacao PRIMARY KEY(id)
) DEFAULT CHARACTER SET utf8 COLLATE utf8_unicode_ci;

INSERT INTO senado_situacao (descricao) VALUES ('ATIVO'), ('APOSENTADO');

CREATE TABLE senado_folha (
  id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  tipo_id SMALLINT UNSIGNED NOT NULL,
  servidor_id INT UNSIGNED NOT NULL,
  vinculo_id SMALLINT UNSIGNED NOT NULL,
  cargo_id SMALLINT UNSIGNED NOT NULL,
  situacao_id SMALLINT UNSIGNED NOT NULL,
  remuneracao_basica DECIMAL(10,2) NOT NULL,
  vantagens_pessoais DECIMAL(10,2) NOT NULL,
  funcao_cargo_comissao DECIMAL(10,2) NOT NULL,
  gratificacao_natalina DECIMAL(10,2) NOT NULL,
  horas_extras DECIMAL(10,2) NOT NULL,
  outras_remuneracoes_eventuais DECIMAL(10,2) NOT NULL,
  abono_permanencia DECIMAL(10,2) NOT NULL,
  reversao_teto_constitucional DECIMAL(10,2) NOT NULL,
  imposto_renda DECIMAL(10,2) NOT NULL,
  psss DECIMAL(10,2) NOT NULL,
  faltas DECIMAL(10,2) NOT NULL,
  diarias DECIMAL(10,2) NOT NULL,
  auxilios DECIMAL(10,2) NOT NULL,
  outras_vantagens_indenizatorias DECIMAL(10,2) NOT NULL,
  CONSTRAINT pk_senado_folha PRIMARY KEY(id),
  CONSTRAINT fk_senado_folha_tipo FOREIGN KEY(tipo_id)
    REFERENCES senado_tipo_folha(id)
    ON UPDATE CASCADE ON DELETE NO ACTION,
  CONSTRAINT fk_senado_folha_servidor FOREIGN KEY(servidor_id)
    REFERENCES senado_servidor(id)
    ON UPDATE CASCADE ON DELETE NO ACTION,
  CONSTRAINT fk_senado_folha_vinculo FOREIGN KEY(vinculo_id)
    REFERENCES senado_vinculo(id)
    ON UPDATE CASCADE ON DELETE NO ACTION,
  CONSTRAINT fk_senado_folha_cargo FOREIGN KEY(cargo_id)
    REFERENCES senado_cargo(id)
    ON UPDATE CASCADE ON DELETE NO ACTION,
  CONSTRAINT fk_senado_folha_situacao FOREIGN KEY(situacao_id)
    REFERENCES senado_situacao(id)
    ON UPDATE CASCADE ON DELETE NO ACTION
) DEFAULT CHARACTER SET utf8 COLLATE utf8_unicode_ci;
