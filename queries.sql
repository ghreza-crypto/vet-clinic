/*Queries that provide answers to the questions from all projects.*/

SELECT * from animals WHERE name LIKE '%mon';

SELECT name from animals WHERE date_of_birth BETWEEN '2016/01/01' AND '2019/01/01';

SELECT name from animals WHERE neutered = TRUE AND escape_attempts < 3;

SELECT date_of_birth from animals WHERE name IN ('Agumon', 'Pikachu');

SELECT name, escape_attempts from animals WHERE weight_kg > 10.5;

SELECT * from animals WHERE neutered = TRUE;

SELECT * from animals WHERE name != 'Gabumon';

SELECT * from animals WHERE weight_kg BETWEEN 10.4 AND 17.3;

--1 Transaction 
BEGIN TRANSACTION;
UPDATE animals SET species = 'unspecified';
SELECT * FROM animals;
ROLLBACK;
SELECT * FROM animals;

--2 transaction
BEGIN TRANSACTION;
UPDATE animals SET species = 'digimon' WHERE name LIKE '%mon';
UPDATE animals SET species = 'pokemon' WHERE species IS NULL;
COMMIT;
SELECT * FROM animals; 

--3 Transaction 
BEGIN TRANSACTION;
DELETE FROM animals;
ROLLBACK;
SELECT * FROM animals;

-- 4 Transaction 
BEGIN TRANSACTION;
DELETE from animals WHERE date_of_birth > '2022/01/01';
SAVEPOINT animals_after_2022;
UPDATE animals SET weight_kg = (weight_kg * -1);
ROLLBACK TO SAVEPOINT animals_after_2022;
UPDATE animals SET weight_kg = (weight_kg * -1) WHERE weight_kg < 0;
COMMIT;
SELECT * from animals;

--How many animals are there?
SELECT COUNT(*) from animals;

--How many animals have never tried to escape?
SELECT COUNT(*) from animals WHERE escape_attempts = 0;

--What is the average weight of animals?
SELECT AVG(weight_kg) from animals;

--Who escapes the most, neutered or not neutered animals?
SELECT neutered, SUM(escape_attempts) from animals GROUP BY neutered;

--What is the minimum and maximum weight of each type of animal?
SELECT species, MIN(weight_kg), MAX(weight_kg) from animals GROUP BY species;

--What is the average number of escape attempts per animal type of those born between 1990 and 2000?
SELECT species, AVG(escape_attempts) from animals 
WHERE date_of_birth BETWEEN '1990/01/01' AND '2000/12/31'
GROUP BY species;

--What animals belong to Melody Pond?
SELECT animals.name FROM animals
JOIN owners ON animals.owner_id = owners.id
WHERE owners.full_name = 'Melody';

--List of all animals that are pokemon (their type is Pokemon).
SELECT animals.name, species.name as Type FROM animals
JOIN species ON animals.species_id = species.id
WHERE species.name = 'Pokemon';

--List all owners and their animals, remember to include those that don't own any animal.
SELECT animals.name as animal, owners.full_name as owner FROM animals
RIGHT JOIN owners ON animals.owner_id = owners.id;

--How many animals are there per species?
SELECT COUNT(*), species.name FROM animals 
JOIN species ON animals.species_id = species.id
GROUP BY species.name;

--List all Digimon owned by Jennifer Orwell.
SELECT animals.name as animal_name, species.name as type, owners.full_name as owner 
FROM animals
JOIN owners ON animals.owner_id = owners.id
JOIN species ON animals.species_id = species.id
WHERE owners.full_name = 'Jennifer Orwell' 
AND species.name LIKE 'Digimon';

--List all animals owned by Dean Winchester that haven't tried to escape.
SELECT animals.name as animal_name, animals.escape_attempts, owners.full_name as owner 
FROM animals 
JOIN owners ON animals.owner_id = owners.id
WHERE owners.full_name = 'Dean Winchester' 
AND animals.escape_attempts = 0;

--Who owns the most animals?
SELECT COUNT(*) as Number_of_animals, owners.full_name as owner
FROM animals
JOIN owners ON animals.owner_id = owners.id
GROUP BY owners.full_name;


