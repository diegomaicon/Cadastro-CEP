--
-- Arquivo gerado com SQLiteStudio v3.4.4 em sex mar 22 20:31:45 2024
--
-- Codificação de texto usada: System
--
PRAGMA foreign_keys = off;
BEGIN TRANSACTION;

-- Tabela: CEP
DROP TABLE IF EXISTS CEP;

CREATE TABLE IF NOT EXISTS CEP (
    ID          INTEGER    PRIMARY KEY AUTOINCREMENT
                           UNIQUE
                           NOT NULL,
    CEP         TEXT (8)   UNIQUE
                           NOT NULL,
    LOGRADOURO  TEXT (255),
    COMPLEMENTO TEXT (100),
    BAIRRO      TEXT (100),
    LOCALIDADE  TEXT (100),
    UF          TEXT (2),
    IBGE        INTEGER
);


COMMIT TRANSACTION;
PRAGMA foreign_keys = on;
