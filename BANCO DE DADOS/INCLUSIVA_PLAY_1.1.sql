CREATE DATABASE IF NOT EXISTS INCLUSIVAPLAY;
USE INCLUSIVAPLAY;

-- Tabela USUARIO
CREATE TABLE USUARIO (
    idUSUARIO INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(70) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    senha VARCHAR(255) NOT NULL,
    cpf VARCHAR(14) UNIQUE NOT NULL,
    tipo_usuario ENUM('admin', 'user') NOT NULL,
    telefone VARCHAR(20),
    data_cadastro VARCHAR(45),
    configuracao_acessibilidade_idconfiguracao_acessibilidade INT,
    CONSTRAINT fk_usuario_config FOREIGN KEY (configuracao_acessibilidade_idconfiguracao_acessibilidade) 
        REFERENCES configuracao_acessibilidade(idconfiguracao_acessibilidade)
);

-- Tabela Centro_Esportivo
CREATE TABLE Centro_Esportivo (
    idCentro_Esportivo INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    endereco VARCHAR(255),
    coordenadas POINT NOT NULL,  -- Criação de uma coluna POINT para latitude e longitude (INSERIR MAPA DOS LOCAIS -)
    telefone VARCHAR(20),
    nivel_esporte_autismo ENUM('iniciante', 'intermediário', 'avançado'),
    acessibilidade_cadeirante TINYINT DEFAULT 0,  -- Acessibilidade para cadeirantes
    acessibilidade_auditiva TINYINT DEFAULT 0,  -- Acessibilidade auditiva
    Avaliação_idAvaliação INT,
    CONSTRAINT fk_centro_avaliacao FOREIGN KEY (Avaliação_idAvaliação) REFERENCES Avaliação(idAvaliação),
    SPATIAL INDEX(coordenadas)  -- Índice espacial para otimizar buscas geográficas  (google maps - verificar para futuras correções)
);

-- Tabela Esporte
CREATE TABLE Esporte (
    idEsporte INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(80) NOT NULL
);

-- Tabela Avaliação
CREATE TABLE Avaliação (
    idAvaliação INT AUTO_INCREMENT PRIMARY KEY,
    id_usuario INT,
    is_centro INT,
    nota TINYINT CHECK (nota BETWEEN 0 AND 10),
    comentario TEXT,
    data_avaliacao VARCHAR(45),
    CONSTRAINT fk_avaliacao_usuario FOREIGN KEY (id_usuario) REFERENCES USUARIO(idUSUARIO)
);

-- Tabela configuracao_acessibilidade
CREATE TABLE configuracao_acessibilidade (
    idconfiguracao_acessibilidade INT AUTO_INCREMENT PRIMARY KEY,
    id_usuario INT UNIQUE,
    modo_alto_contraste TINYINT,    
    suporte_leitor_tela TINYINT,    
    design_simplificado TINYINT,    
    CONSTRAINT fk_config_usuario FOREIGN KEY (id_usuario) REFERENCES USUARIO(idUSUARIO)
);

-- Tabela de relacionamento centro_esportivo_esporte (Muitos para Muitos verificar cardinalidades / não esquecer)
CREATE TABLE centro_esportivo_esporte (
    idcentro_esportivo_esporte INT AUTO_INCREMENT PRIMARY KEY,
    id_centro INT,
    id_esporte INT,
    CONSTRAINT fk_centro_esporte_centro FOREIGN KEY (id_centro) REFERENCES Centro_Esportivo(idCentro_Esportivo),
    CONSTRAINT fk_centro_esporte_esporte FOREIGN KEY (id_esporte) REFERENCES Esporte(idEsporte)
);

-- Tabela Horario_Atividades
CREATE TABLE Horario_Atividades (
    idHorario_Atividades INT AUTO_INCREMENT PRIMARY KEY,
    idCentro_Esportivo INT,
    horario_inicio TIME,
    horario_fim TIME,
    atividade_nome VARCHAR(100),
    CONSTRAINT fk_horario_atividade_centro FOREIGN KEY (idCentro_Esportivo) REFERENCES Centro_Esportivo(idCentro_Esportivo)
);

-- Tabela Consentimento LGPD ( preciso estudar mais a fundo )
CREATE TABLE Consentimento_LGPD (
    idConsentimento INT AUTO_INCREMENT PRIMARY KEY,
    id_usuario INT,
    consentimento_dado TINYINT DEFAULT 0,  -- 1 para consentido, 0 para não consentido (talvez hja mudanças aqui)
    data_consentimento DATETIME DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT fk_consentimento_usuario FOREIGN KEY (id_usuario) REFERENCES USUARIO(idUSUARIO)
);


SHOW TABLES;

select * from usuario
select *from Centro_Esportivo
select *from  Esporte
select * from Avaliação
select *from configuracao_acessibilidade
select *from  centro_esportivo_esporte

select *from Horario_Atividades

select *from Consentimento_LGPD






