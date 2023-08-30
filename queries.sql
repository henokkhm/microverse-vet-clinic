/*Queries that provide answers to the questions from all projects.*/
/* List all animals whose name ends in "mon". */
SELECT
    *
from
    animals
WHERE
    name LIKE '%mon';

/* List the name of all animals born between 2016 and 2019. */
SELECT
    name
from
    animals
WHERE
    date_of_birth BETWEEN '2016-01-01'
    AND '2019-12-31';

/* List the name of all animals that are neutered and have less than 3 escape attempts. */
SELECT
    name
from
    animals
WHERE
    neutered
    AND escape_attempts < 3;

/* List the date of birth of all animals named either "Agumon" or "Pikachu". */
SELECT
    date_of_birth
from
    animals
WHERE
    name = 'Agumon'
    OR name = 'Pikachu';

/* List name and escape attempts of animals that weigh more than 10.5kg */
SELECT
    name,
    escape_attempts
from
    animals
WHERE
    weight_kg > 10.5;

/* List all animals that are neutered. */
SELECT
    *
from
    animals
WHERE
    neutered;

/* List all animals not named Gabumon. */
SELECT
    *
from
    animals
WHERE
    name != 'Gabumon';

/* List all animals with a weight between 10.4kg and 17.3kg inclusive */
SELECT
    *
from
    animals
WHERE
    weight_kg BETWEEN 10.4
    AND 17.3;

-- Check current state of table
select
    *
from
    animals;

BEGIN;

UPDATE
    animals
SET
    species = 'unspecified';

-- Check current state of table
select
    *
from
    animals;

ROLLBACK;

-- Check current state of table
select
    *
from
    animals;

-- Check current state of table
select
    *
from
    animals;

BEGIN;

UPDATE
    animals
SET
    species = 'digimon'
WHERE
    name LIKE '%mon';

UPDATE
    animals
SET
    species = 'pokemon'
WHERE
    species IS NULL;

-- Check current state of table
select
    *
from
    animals;

COMMIT;

-- Check current state of table
select
    *
from
    animals;

-- Check current state of table
select
    *
from
    animals;

BEGIN;

DELETE FROM
    animals;

-- Check current state of table
select
    *
from
    animals;

ROLLBACK;

-- Check current state of table
select
    *
from
    animals;

-- Check current state of table
select
    *
from
    animals;

BEGIN;

DELETE FROM
    animals
WHERE
    date_of_birth > '2022-01-01';

SAVEPOINT savepoint_1;

ROLLBACK;

-- Check current state of table
select
    *
from
    animals;

-- Check current state of table
select
    *
from
    animals;

BEGIN;

DELETE FROM
    animals
WHERE
    date_of_birth > '2022-01-01';

SAVEPOINT savepoint_1;

UPDATE
    animals
SET
    weight_kg = weight_kg * -1;

-- Check current state of table
select
    *
from
    animals;

ROLLBACK TO savepoint_1;

-- Check current state of table
select
    *
from
    animals;

UPDATE
    animals
SET
    weight_kg = weight_kg * -1
WHERE
    weight_kg < 0;

-- Check current state of table
select
    *
from
    animals;

-- How many animals are there?
SELECT
    COUNT(name)
FROM
    animals;

-- How many animals have never tried to escape?
SELECT
    COUNT(name)
FROM
    animals
WHERE
    escape_attempts = 0;

-- What is the average weight of animals?
SELECT
    AVG(weight_kg)
FROM
    animals;

-- Who escapes the most, neutered or not neutered animals?
SELECT
    neutered,
    SUM(escape_attempts)
FROM
    animals
GROUP BY
    neutered;

-- What is the minimum and maximum weight of each type of animal?
SELECT
    species,
    MIN(weight_kg),
    MAX(weight_kg)
FROM
    animals
GROUP BY
    species;

-- What is the average number of escape attempts per animal type of those born between 1990 and 2000?
SELECT
    species,
    AVG(escape_attempts) as average_escape_attempts
FROM
    (
        SELECT
            *
        FROM
            animals
        WHERE
            date_of_birth BETWEEN '1990-01-01'
            AND '2000-12-31'
    ) AS foo
GROUP BY
    species;