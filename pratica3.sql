CREATE TABLE customers (
	id SERIAL PRIMARY KEY,
	"fullName" TEXT NOT NULL,
	cpf VARCHAR(11) UNIQUE NOT NULL,
	email TEXT NOT NULL,
	password TEXT NOT NULL
);

CREATE TABLE "bankAccount" (
	id SERIAL PRIMARY KEY,
	"customerId" INTEGER NOT NULL REFERENCES "customers"("id"),
	"accountNumber" INTEGER UNIQUE NOT NULL,
	agency TEXT NOT NULL,
	"openDate" TIMESTAMP NOT NULL DEFAULT NOW(),
	"closeDate" TIMESTAMP
);

CREATE TYPE "transactionsTypes" AS ENUM ('deposit', 'withdraw');

CREATE TABLE transactions (
	id SERIAL PRIMARY KEY,
	"bankAccountId" INTEGER NOT NULL REFERENCES "bankAccount"("id"),
	amount INTEGER NOT NULL,
	"type" "transactionsType",
	"time" TIMESTAMP NOT NULL DEFAULT NOW(),
	"description" TEXT NOT NULL,
	"cancelled" BOOLEAN NOT NULL DEFAULT FALSE
);

CREATE TABLE "creditCards" (
	id SERIAL PRIMARY KEY,
	"bankAccountId" INTEGER NOT NULL REFERENCES "bankAccount"("id"),
	name TEXT NOT NULL,
	"number" TEXT UNIQUE NOT NULL,
	"securityCode" TEXT NOT NULL,
	"expirationMonth" INTEGER NOT NULL,
	"expirationYear" INTEGER NOT NULL,
	"password" TEXT NOT NULL,
	"limit" INTEGER NOT NULL
);

CREATE TYPE "phoneType" AS ENUM ('landline', 'mobile');

CREATE TABLE "customerPhones" (
	id SERIAL PRIMARY KEY,
	customerId INTEGER NOT NULL REFERENCES "customers"("id"),
	"number" TEXT UNIQUE NOT NULL,
	"type" "phoneType"
);

CREATE TABLE "states" (
	id SERIAL PRIMARY KEY,
	name TEXT UNIQUE NOT NULL
);

CREATE TABLE "cities" (
	id SERIAL PRIMARY KEY,
	name TEXT UNIQUE NOT NULL,
	"stateId" INTEGER NOT NULL REFERENCES "states"("id")
);

CREATE TABLE "customerAddresses" (
	id,
	"customerId" INTEGER UNIQUE NOT NULL REFERENCES "customers"("id"),
	"street" TEXT NOT NULL,
	"number" INTEGER NOT NULL,
	complement TEXT,
	"postalCode" INTEGER NOT NULL,
	"cityId" INTEGER NOT NULL REFERENCES "cities"("id")
);
