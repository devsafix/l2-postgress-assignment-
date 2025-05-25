-- Active: 1747412702955@@localhost@5432@conservation_db

-- Problem 1
INSERT INTO
    rangers (ranger_id, name, region)
VALUES (
        4,
        'Derek Fox',
        'Coastal Plains'
    );

-- Problem 2
SELECT COUNT(DISTINCT species_id) AS unique_species_count
FROM sightings;

-- Problem 3
SELECT * FROM sightings WHERE location LIKE '%Pass';

-- Problem 4
SELECT r.name AS name, COUNT(s.sighting_id) AS total_sightings
FROM rangers AS r
    LEFT JOIN sightings AS s ON r.ranger_id = s.ranger_id
GROUP BY
    r.name
HAVING
    COUNT(s.sighting_id) > 0
ORDER BY r.name;

-- Problem 5
SELECT common_name
FROM species
    LEFT JOIN sightings ON species.species_id = sightings.species_id
WHERE
    sightings.sighting_id IS NULL;

-- Problem 6
SELECT common_name, sighting_time, name
FROM
    sightings
    JOIN species ON sightings.species_id = species.species_id
    JOIN rangers ON sightings.ranger_id = rangers.ranger_id
ORDER BY sighting_time DESC
LIMIT 2;

-- Problem 7
UPDATE species
SET
    conservation_status = 'Historic'
WHERE
    EXTRACT(
        YEAR
        FROM discovery_date
    ) < 1800;