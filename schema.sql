/* Database schema to keep the structure of entire database. */

CREATE TABLE animals (
    name varchar(100)
);

CREATE TABLE animals (
    id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    date_of_birth date NOT NULL,
    escape_attempts INT NOT NULL,
    neutered BOOLEAN NOT NULL,
    weight_kg DECIMAL NOT NULL
);
