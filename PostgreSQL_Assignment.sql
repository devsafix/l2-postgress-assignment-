-- Active: 1747412702955@@localhost@5432@conservation_db

-- Problem 1 - Register a new ranger with provided data with name = 'Derek Fox' and region = 'Coastal Plains'
INSERT INTO
    rangers (ranger_id, name, region)
VALUES (
        4,
        'Derek Fox',
        'Coastal Plains'
    );

-- Problem 2 - Count unique species ever sighted.
SELECT COUNT(DISTINCT species_id) AS unique_species_count
FROM sightings;

-- Problem 3 - Find all sightings where the location includes "Pass".
SELECT * FROM sightings WHERE location LIKE '%Pass';

-- Problem 4 - List each ranger's name and their total number of sightings.
SELECT r.name AS name, COUNT(s.sighting_id) AS total_sightings
FROM rangers AS r
    LEFT JOIN sightings AS s ON r.ranger_id = s.ranger_id
GROUP BY
    r.name
HAVING
    COUNT(s.sighting_id) > 0
ORDER BY r.name;

-- Problem 5 - List species that have never been sighted.
SELECT common_name
FROM species
    LEFT JOIN sightings ON species.species_id = sightings.species_id
WHERE
    sightings.sighting_id IS NULL;

-- Problem 6 - Show the most recent 2 sightings.
SELECT common_name, sighting_time, name
FROM
    sightings
    JOIN species ON sightings.species_id = species.species_id
    JOIN rangers ON sightings.ranger_id = rangers.ranger_id
ORDER BY sighting_time DESC
LIMIT 2;

-- Problem 7 - Update all species discovered before year 1800 to have status 'Historic'.
UPDATE species
SET
    conservation_status = 'Historic'
WHERE
    EXTRACT(
        YEAR
        FROM discovery_date
    ) < 1800;

-- Problem 8 - Label each sighting's time of day as 'Morning', 'Afternoon', or 'Evening'.
SELECT
    sighting_id,
    CASE
        WHEN EXTRACT(
            HOUR
            FROM sighting_time
        ) < 12 THEN 'Morning'
        WHEN EXTRACT(
            HOUR
            FROM sighting_time
        ) >= 12
        AND EXTRACT(
            HOUR
            FROM sighting_time
        ) < 17 THEN 'Afternoon'
        ELSE 'Evening'
    END AS time_of_day
FROM sightings;

-- Problem 9 - Delete rangers who have never sighted any species.
DELETE FROM rangers
WHERE
    NOT EXISTS (
        SELECT
        FROM sightings
        WHERE
            sightings.ranger_id = rangers.ranger_id
    );