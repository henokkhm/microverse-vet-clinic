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

-- Queries
-- What animals belong to Melody Pond?
SELECT
    A.id as animal_id,
    name as animal_name,
    full_name as owner
FROM
    animals A
    JOIN owners O ON A.owner_id = O.id
WHERE
    full_name = 'Melody Pond';

-- List of all animals that are pokemon.
SELECT
    A.id,
    A.name,
    S.name as species_name
FROM
    animals A
    JOIN species S ON A.species_id = S.id
WHERE
    S.name = 'Pokemon';

-- List all owners and their animals, remember to include those that don't own any animal.
SELECT
    full_name as owner,
    name as animal_name
FROM
    Owners O
    LEFT JOIN Animals A ON O.id = A.owner_id;

-- How many animals are there per species?
SELECT
    S.name as species_name,
    COUNT(A.name)
FROM
    animals A
    JOIN species S ON A.species_id = S.id
GROUP BY
    S.name;

-- List all Digimon owned by Jennifer Orwell.
SELECT
    A.name AS animal_name,
    O.full_name AS owner_name,
    S.name AS species_name
FROM
    Animals A
    JOIN Owners O ON O.id = A.owner_id
    JOIN species S ON A.species_id = S.id
WHERE
    O.full_name = 'Jennifer Orwell'
    AND S.name = 'Digimon';

-- List all animals owned by Dean Winchester that haven't tried to escape.
SELECT
    A.name AS animal_name,
    O.full_name AS owner_name,
    S.name AS species_name,
    A.escape_attempts
FROM
    Animals A
    JOIN Owners O ON O.id = A.owner_id
    JOIN species S ON A.species_id = S.id
WHERE
    O.full_name = 'Dean Winchester'
    AND A.escape_attempts = 0;

-- Who owns the most animals?
SELECT
    O.full_name AS owner_name,
    COUNT(A.name) AS animal_count
FROM
    Animals A
    JOIN Owners O ON O.id = A.owner_id
GROUP BY
    O.full_name
ORDER BY
    animal_count DESC
LIMIT
    1;

-- Who was the last animal seen by William Tatcher?
SELECT
    a.name AS animal_name,
    v.name AS vet_name,
    visit_date
FROM
    visits AS vs
    JOIN vets AS v ON vs.vet_id = v.id
    JOIN animals AS a ON vs.animal_id = a.id
WHERE
    v.name = 'William Tatcher'
ORDER BY
    visit_date DESC
LIMIT
    1;

-- How many different animals did Stephanie Mendez see?
SELECT
    v.name AS vet_name,
    COUNT(a.name)
FROM
    visits AS vs
    JOIN vets AS v ON vs.vet_id = v.id
    JOIN animals AS a ON vs.animal_id = a.id
WHERE
    v.name = 'Stephanie Mendez'
GROUP BY
    v.name;

-- List all vets and their specialties, including vets with no specialties.
SELECT
    v.name AS vet_name,
    sp.name AS specialization
FROM
    specializations AS s
    RIGHT JOIN vets AS v ON v.id = s.vet_id
    LEFT JOIN species AS sp ON sp.id = s.species_id;

-- List all animals that visited Stephanie Mendez between April 1st and August 30th, 2020.
SELECT
    v.name AS vet_name,
    a.name AS animal_name,
    vs.visit_date
FROM
    visits AS vs
    JOIN vets AS v ON vs.vet_id = v.id
    JOIN animals AS a ON vs.animal_id = a.id
WHERE
    v.name = 'Stephanie Mendez'
    AND visit_date BETWEEN '2020-04-01'
    AND '2020-08-30';

-- What animal has the most visits to vets?
SELECT
    a.name AS animal_name,
    COUNT(vs.visit_date) as number_of_visits
FROM
    visits AS vs
    JOIN vets AS v ON vs.vet_id = v.id
    JOIN animals AS a ON vs.animal_id = a.id
GROUP BY
    a.name
ORDER BY
    number_of_visits DESC
LIMIT
    1;

-- Who was Maisy Smith's first visit?
SELECT
    v.name AS vet_name,
    a.name AS animal_name,
    vs.visit_date
FROM
    visits AS vs
    JOIN vets AS v ON vs.vet_id = v.id
    JOIN animals AS a ON vs.animal_id = a.id
WHERE
    v.name = 'Maisy Smith'
ORDER BY
    visit_date
LIMIT
    1;

-- Details for most recent visit: animal information, vet information, and date of visit.
SELECT
    a.name AS animal_name,
    a.date_of_birth,
    a.escape_attempts,
    a.neutered,
    a.weight_kg,
    a.species_id,
    v.name AS vet_name,
    v.age,
    v.date_of_graduation,
    vs.visit_date
FROM
    visits AS vs
    JOIN vets AS v ON vs.vet_id = v.id
    JOIN animals AS a ON vs.animal_id = a.id
ORDER BY
    visit_date DESC
LIMIT
    1;

-- How many visits were with a vet that did not specialize in that animal's species?
SELECT
    v.name AS vet_name,
    a.name AS animal_name,
    a.species_id AS animal_species_id,
    sp.species_id AS vets_specialization_soecies_id
FROM
    visits AS vs
    JOIN vets AS v ON vs.vet_id = v.id
    JOIN animals AS a ON vs.animal_id = a.id
    JOIN specializations AS sp ON sp.vet_id = v.id
WHERE
    sp.species_id != a.species_id;

-- What specialty should Maisy Smith consider getting? Look for the species she gets the most.
SELECT
    v.name AS vet_name,
    s.name AS animal_species,
    COUNT(s.name) AS number_of_animals
FROM
    visits AS vs
    JOIN vets AS v ON vs.vet_id = v.id
    JOIN animals AS a ON vs.animal_id = a.id
    JOIN species AS s ON a.species_id = s.id
WHERE
    v.name = 'Maisy Smith'
GROUP BY
    s.name,
    v.name
ORDER BY
    number_of_animals DESC
LIMIT
    1;

EXPLAIN ANALYZE SELECT COUNT(*) FROM visits where animal_id = 4;
EXPLAIN ANALYZE SELECT * FROM visits where vet_id = 2;
EXPLAIN ANALYZE SELECT * FROM owners where email = 'owner_18327@mail.com';
