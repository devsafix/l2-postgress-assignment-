-- Active: 1747412702955@@localhost@5432@conservation_db
CREATE DATABASE conservation_db;

-- Rangers Table
CREATE TABLE rangers (
    ranger_id SERIAL PRIMARY KEY,
    name VARCHAR(50) NOT NULL,
    region VARCHAR(50) NOT NULL
);