-- criar a base de dados para a oficina e começar a usar
CREATE DATABASE oficina;
use oficina;

-- criar a table do cliente
CREATE TABLE Cliente(
	IdCliente INT PRIMARY KEY AUTO_INCREMENT,
    Nome VARCHAR(45) NOT NULL,
    Endereço VARCHAR(45),
    Telefone VARCHAR(45)
);

-- criar a table do veículo
CREATE TABLE Veículo(
	IdVeículo INT PRIMARY KEY AUTO_INCREMENT,
    Placa VARCHAR(45) NOT NULL,
    Tipo VARCHAR(45) NOT NULL,
    IdCliente INT,
    Modelo VARCHAR(45) NOT NULL,
    Marca VARCHAR(45) NOT NULL,
    Ano VARCHAR(45) NOT NULL,
    FOREIGN KEY (IdCliente) REFERENCES Cliente(IdCliente)
);

-- criar table de autorização 
CREATE TABLE Autorização(
	IdAutorização INT PRIMARY KEY AUTO_INCREMENT,
    Data_de_Autorização DATE NOT NULL,
    IdCliente INT,
    FOREIGN KEY (IdCliente) REFERENCES Cliente(IdCliente)
);

-- criar table de equipe de mecânicos
CREATE TABLE Equipe(
	IdEquipe INT PRIMARY KEY AUTO_INCREMENT,
    Referência VARCHAR(100) NOT NULL, -- Referência de mão de obra, serviços da equipe
    Nome VARCHAR(45) NOT NULL
);

-- criar table de mecânico
CREATE TABLE Mecânico(
	IdMecânico INT PRIMARY KEY AUTO_INCREMENT,
    Código VARCHAR(45) NOT NULL UNIQUE, -- Código para referênciar o mecânico além do Id
    Nome VARCHAR(45) NOT NULL,
    Endereço VARCHAR(45),
    Especialidade VARCHAR(45) NOT NULL,
    IdEquipe INT,
    FOREIGN KEY (IdEquipe) REFERENCES Equipe(IdEquipe)
);

-- criar a table de peças
CREATE TABLE Peça(
	IdPeça INT PRIMARY KEY AUTO_INCREMENT,
    Nome VARCHAR(45) NOT NULL,
    Quantidade INT NOT NULL,
    Valor FLOAT NOT NULL
);

-- criar a table da ordem de serviço 
CREATE TABLE Ordem_de_Serviço(
	Número INT PRIMARY KEY AUTO_INCREMENT,
    Valor FLOAT NOT NULL,
    Data_de_Entrega DATE NOT NULL,
    Data_de_Emissão DATE NOT NULL,
    Status_do_serviço ENUM('Em espera', 'Em processo', 'Finalizado', 'Cancelado'),
    IdEquipe INT,
    Serviços VARCHAR(45) NOT NULL,
    IdVeículo INT,
    IdAutorização INT,
    FOREIGN KEY (IdEquipe) REFERENCES Equipe(IdEquipe),
    FOREIGN KEY (IdVeículo) REFERENCES Veículo(IdVeículo),
    FOREIGN KEY (IdAutorização) REFERENCES Autorização(IdAutorização)
);

-- criar a table de registro de uso de peças
CREATE TABLE Registro_de_peça(
	Número_Ordem_de_Serviço INT,
    IdPeça INT,
    PRIMARY KEY (Número_Ordem_de_Serviço, IdPeça),
    FOREIGN KEY (Número_Ordem_de_Serviço) REFERENCES Ordem_de_Serviço(Número),
    FOREIGN KEY (IdPeça) REFERENCES Peça(IdPeça)
);

-- Agora, vamos para as inserções:
-- Inserir clientes
INSERT INTO Cliente (Nome, Endereço, Telefone) VALUES 
('João da Silva', 'Rua das Flores, 123', '1199999-0001'),
('Maria Oliveira', 'Avenida Brasil, 456', '1199999-0002'),
('Carlos Souza', 'Rua das Palmeiras, 789', '1199999-0003'),
('Ana Pereira', 'Rua do Sol, 321', '1199999-0004'),
('Felipe Ramos', 'Avenida Atlântica, 654', '1199999-0005'),
('Bruna Costa', 'Rua do Cedro, 987', '1199999-0006');

-- Inserir veículos
INSERT INTO Veículo (Placa, Tipo, IdCliente, Modelo, Marca, Ano) VALUES 
('ABC1234', 'Carro', 1, 'Civic', 'Honda', '2019'),
('DEF5678', 'Moto', 2, 'Fazer 250', 'Yamaha', '2020'),
('GHI9012', 'Carro', 3, 'Onix', 'Chevrolet', '2021'),
('JKL3456', 'Carro', 4, 'Corolla', 'Toyota', '2022'),
('MNO7890', 'Moto', 5, 'CB 500F', 'Honda', '2021'),
('PQR1234', 'Carro', 6, 'Golf', 'Volkswagen', '2018');

-- Inserir autorizações
INSERT INTO Autorização (Data_de_Autorização, IdCliente) VALUES 
('2024-03-20', 1),
('2024-03-21', 2),
('2024-03-22', 3),
('2024-03-23', 4),
('2024-03-24', 5),
('2024-03-25', 6);

-- Inserir equipes
INSERT INTO Equipe (Referência, Nome) VALUES 
('Equipe responsável por revisão geral', 'Equipe Revisão'),
('Equipe de troca de óleo e filtros', 'Equipe Troca Óleo'),
('Equipe de funilaria e pintura', 'Equipe Funilaria'),
('Equipe de suspensão e freios', 'Equipe Suspensão'),
('Equipe elétrica', 'Equipe Elétrica'),
('Equipe de diagnóstico', 'Equipe Diagnóstico');

-- Inserir mecânicos
INSERT INTO Mecânico (Código, Nome, Endereço, Especialidade, IdEquipe) VALUES 
('MEC001', 'Pedro Lima', 'Rua Alfa, 100', 'Revisão', 1),
('MEC002', 'Lucas Mendes', 'Rua Beta, 200', 'Troca de Óleo', 2),
('MEC003', 'Rafael Costa', 'Rua Gama, 300', 'Funilaria', 3),
('MEC004', 'André Silva', 'Rua Delta, 400', 'Suspensão', 4),
('MEC005', 'Thiago Souza', 'Rua Épsilon, 500', 'Elétrica', 5),
('MEC006', 'Bruno Martins', 'Rua Zeta, 600', 'Diagnóstico', 6);

-- Inserir peças
INSERT INTO Peça (Nome, Quantidade, Valor) VALUES 
('Filtro de Óleo', 50, 30.00),
('Óleo 10W40', 100, 50.00),
('Parachoque Traseiro', 10, 350.00),
('Pastilha de Freio', 30, 120.00),
('Amortecedor Dianteiro', 20, 400.00),
('Bateria 60Ah', 15, 500.00);

-- Inserir ordens de serviço
INSERT INTO Ordem_de_Serviço (Valor, Data_de_Entrega, Data_de_Emissão, Status_do_serviço, IdEquipe, Serviços, IdVeículo, IdAutorização) VALUES 
(500.00, '2024-03-25', '2024-03-20', 'Em processo', 1, 'Revisão completa', 1, 1),
(150.00, '2024-03-26', '2024-03-21', 'Em espera', 2, 'Troca de óleo', 2, 2),
(1200.00, '2024-03-30', '2024-03-22', 'Em processo', 3, 'Funilaria e pintura', 3, 3),
(850.00, '2024-03-27', '2024-03-23', 'Finalizado', 4, 'Troca de suspensão', 4, 4),
(200.00, '2024-03-28', '2024-03-24', 'Em processo', 5, 'Reparo elétrico', 5, 5),
(650.00, '2024-03-29', '2024-03-25', 'Em espera', 6, 'Diagnóstico completo', 6, 6);

-- Inserir registros de uso de peça
INSERT INTO Registro_de_peça (Número_Ordem_de_Serviço, IdPeça) VALUES 
(1, 1), -- ordem 1 usou Filtro de Óleo
(2, 1), 
(2, 2), 
(3, 3), 
(4, 4), 
(4, 5), 
(5, 6), 
(6, 2);

-- Agora, vamos as queries:
-- SELECT de forma simples
SELECT * FROM Veículo;
SELECT Nome, Especialidade FROM Mecânico;

-- Filtro com WHERE
SELECT * FROM Peça
WHERE Valor > 100;

SELECT * FROM Ordem_de_Serviço
WHERE Status_do_serviço = 'Em processo';

-- Atributos derivados
SELECT Nome, Quantidade, Valor, (Quantidade * Valor) AS Valor_Total_Estoque
FROM Peça;

SELECT SUM(Quantidade * Valor) AS Valor_Total_Estoque
FROM Peça;

-- Ordernação com ORDER BY
SELECT * FROM Cliente
ORDER BY Nome ASC;

SELECT * FROM Peça
ORDER BY Valor DESC;

-- Having statement
SELECT Status_do_serviço, COUNT(*) AS Quantidade
FROM Ordem_de_Serviço
GROUP BY Status_do_serviço
HAVING COUNT(*) > 1;

SELECT Marca, COUNT(*) AS Quantidade_Veiculos
FROM Veículo
GROUP BY Marca
HAVING COUNT(*) > 1;

-- Usando JOIN
SELECT 
    o.Número AS Ordem,
    c.Nome AS Cliente,
    v.Placa AS Placa_Veiculo,
    v.Modelo AS Modelo_Veiculo,
    e.Nome AS Equipe_Responsavel,
    o.Serviços,
    o.Status_do_serviço,
    o.Data_de_Entrega
FROM Ordem_de_Serviço o
JOIN Veículo v ON o.IdVeículo = v.IdVeículo
JOIN Cliente c ON v.IdCliente = c.IdCliente
JOIN Equipe e ON o.IdEquipe = e.IdEquipe
ORDER BY o.Data_de_Entrega;

SELECT 
    r.Número_Ordem_de_Serviço AS Ordem, 
    p.Nome AS Peça, 
    p.Valor AS Valor_Unitario
FROM Registro_de_peça r
JOIN Peça p ON r.IdPeça = p.IdPeça
ORDER BY r.Número_Ordem_de_Serviço;
