/* Database schema to keep the structure of entire database. */
CREATE TABLE animals (
    id INT PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
    name VARCHAR(100) NOT NULL,
    date_of_birth DATE,
    escape_attempts INT,
    neutered BOOLEAN,
    weight_kg REAL,
    species VARCHAR(100)
);

CREATE TABLE owners (
    id INT PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
    full_name VARCHAR(200) NOT NULL,
    age INT
);

CREATE TABLE species (
    id INT PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
    name VARCHAR(100) NOT NULL
);

ALTER TABLE
    animals DROP COLUMN species;

ALTER TABLE
    animals
ADD
    COLUMN species_id INT CONSTRAINT animal_species REFERENCES species (id);

ALTER TABLE
    animals
ADD
    COLUMN owner_id INT CONSTRAINT animal_owner REFERENCES owners (id);

CREATE TABLE vets (
    id INT PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
    name VARCHAR(100) NOT NULL,
    age INT,
    date_of_graduation DATE
);

CREATE TABLE specializations (
    vet_id INT,
    species_id INT,
    PRIMARY KEY (vet_id, species_id),
    FOREIGN KEY (vet_id) REFERENCES vets(id),
    FOREIGN KEY (species_id) REFERENCES species(id)
);

CREATE TABLE visits (
    animal_id INT,
    vet_id INT,
    visit_date DATE,
    PRIMARY KEY (animal_id, vet_id, visit_date),
    FOREIGN KEY (animal_id) REFERENCES animals(id),
    FOREIGN KEY (vet_id) REFERENCES vets(id)
);