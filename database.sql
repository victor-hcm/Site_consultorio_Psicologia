CREATE DATABASE IF NOT EXISTS consultorio_psicologia;
USE consultorio_psicologia;

CREATE TABLE SERVICOS (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    descricao TEXT NOT NULL,
    duracao_minutos INT NOT NULL,
    valor DECIMAL(10,2) NOT NULL,
    valor_anterior DECIMAL(10,2) NULL,
    publico VARCHAR(100) NOT NULL,
    categoria VARCHAR(50) NOT NULL,
    modalidade VARCHAR(50) NOT NULL,
    imagem VARCHAR(255) NOT NULL,
    ativo BOOLEAN DEFAULT TRUE
);

CREATE TABLE PACIENTES (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(150) NOT NULL,
    email VARCHAR(150) UNIQUE NOT NULL,
    cpf VARCHAR(14) UNIQUE NOT NULL,
    telefone VARCHAR(20) NOT NULL,
    data_nascimento DATE NOT NULL,
    senha_hash VARCHAR(255) NOT NULL,
    consentimento_lgpd BOOLEAN NOT NULL,
    data_cadastro TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE AGENDAMENTOS (
    id INT AUTO_INCREMENT PRIMARY KEY,
    paciente_id INT NOT NULL,
    servico_id INT NOT NULL,
    data_hora DATETIME NOT NULL,
    modalidade VARCHAR(50) NOT NULL,
    status ENUM('pendente', 'confirmado', 'cancelado', 'realizado') DEFAULT 'pendente',
    valor DECIMAL(10,2) NOT NULL,
    FOREIGN KEY (paciente_id) REFERENCES PACIENTES(id),
    FOREIGN KEY (servico_id) REFERENCES SERVICOS(id)
);

CREATE TABLE CONTATOS (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(150) NOT NULL,
    email VARCHAR(150) NOT NULL,
    mensagem TEXT NOT NULL,
    data_envio TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    lido BOOLEAN DEFAULT FALSE
);

CREATE TABLE ADMINS (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(150) NOT NULL,
    email VARCHAR(150) UNIQUE NOT NULL,
    senha_hash VARCHAR(255) NOT NULL,
    perfil VARCHAR(50) DEFAULT 'admin'
);

-- SEED: 6 Serviços Obrigatórios com valores de mercado
INSERT INTO SERVICOS (nome, descricao, duracao_minutos, valor, valor_anterior, publico, categoria, modalidade, imagem) VALUES
('Acolhimento Inicial (1ª consulta)', 'Primeiro contato humanizado para entender suas demandas e orientar sobre o processo terapêutico.', 50, 150.00, 200.00, 'Todos os públicos', 'Triagem', 'Presencial/Online', 'assets/acolhimento.jpg'),
('Psicoterapia Individual', 'Espaço seguro de autoconhecimento e desenvolvimento emocional para lidar com ansiedade e estresse.', 50, 200.00, 250.00, 'Adultos', 'Psicoterapia', 'Presencial/Online', 'assets/individual.jpg'),
('Psicoterapia para Adolescentes', 'Apoio especializado para os desafios da adolescência e regulação emocional.', 50, 200.00, 250.00, 'Adolescentes', 'Psicoterapia', 'Presencial/Online', 'assets/adolescente.jpg'),
('Terapia de Casal', 'Mediação e fortalecimento da comunicação e resolução de conflitos a dois.', 60, 280.00, 350.00, 'Casais', 'Relacionamento', 'Presencial/Online', 'assets/casal.jpg'),
('Orientação de Pais', 'Suporte parental prático e empático para lidar com limites e dinâmica familiar.', 50, 220.00, 260.00, 'Pais e responsáveis', 'Família', 'Presencial/Online', 'assets/pais.jpg'),
('Avaliação Psicológica', 'Processo estruturado com testes e entrevistas clínicas para fins diagnósticos ou de autoconhecimento.', 50, 350.00, 400.00, 'Adultos e adolescentes', 'Avaliação', 'Presencial', 'assets/avaliacao.jpg');

INSERT INTO ADMINS (nome, email, senha_hash) VALUES 
('Dra. Camila Mendes', 'admin@espacomedvida.com', '$2y$10$exemploDeHashBcryptSeguroParaTrabalho123');