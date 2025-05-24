-- Active: 1747412702955@@localhost@5432@conservation_db
CREATE DATABASE conservation_db;

-- Rangers Table
CREATE TABLE rangers (
    ranger_id SERIAL PRIMARY KEY,
    name VARCHAR(50) NOT NULL,
    region VARCHAR(50) NOT NULL
);

-- Species Table
CREATE TABLE species (
    species_id SERIAL PRIMARY KEY,
    common_name VARCHAR(50) NOT NULL,
    scientific_name VARCHAR(50) NOT NULL,
    discovery_date DATE NOT NULL,
    conservation_status VARCHAR(50) CHECK (
        conservation_status IN (
            'Endangered',
            'Vulnerable',
            'Near Threatened',
            'Least Concern'
        )
    )
);

-- Sightings Table
CREATE TABLE sightings (
    sighting_id SERIAL PRIMARY KEY,
    species_id INT REFERENCES species (species_id) ON DELETE CASCADE,
    ranger_id INT REFERENCES rangers (ranger_id) ON DELETE CASCADE,
    location VARCHAR(100) NOT NULL,
    sighting_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    notes TEXT
);