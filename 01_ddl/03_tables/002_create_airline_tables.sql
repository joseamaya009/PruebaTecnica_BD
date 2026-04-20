CREATE TABLE airline.airline (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    name VARCHAR(150) NOT NULL,
    iata_code CHAR(2) NOT NULL UNIQUE,
    icao_code CHAR(3) NOT NULL UNIQUE,
    home_country_id UUID NOT NULL,
    is_active BOOLEAN NOT NULL DEFAULT TRUE,
    created_at TIMESTAMP NOT NULL DEFAULT NOW(),
    created_by VARCHAR(100),
    updated_at TIMESTAMP,
    updated_by VARCHAR(100),
    state VARCHAR(20) NOT NULL DEFAULT 'ACTIVE',
    CONSTRAINT fk_airline_country
        FOREIGN KEY (home_country_id)
        REFERENCES geography.country(id),
    CONSTRAINT chk_iata_code CHECK (LENGTH(iata_code) = 2),
    CONSTRAINT chk_icao_code CHECK (LENGTH(icao_code) = 3)
);

CREATE TABLE airline.aircraft_model (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    manufacturer VARCHAR(100) NOT NULL,
    model VARCHAR(100) NOT NULL,
    total_seats SMALLINT NOT NULL,
    created_at TIMESTAMP NOT NULL DEFAULT NOW(),
    created_by VARCHAR(100),
    updated_at TIMESTAMP,
    updated_by VARCHAR(100),
    state VARCHAR(20) NOT NULL DEFAULT 'ACTIVE'
);

CREATE TABLE airline.aircraft (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    registration_code VARCHAR(20) NOT NULL UNIQUE,
    airline_id UUID NOT NULL,
    aircraft_model_id UUID NOT NULL,
    in_service_on DATE NOT NULL,
    retired_on DATE,
    created_at TIMESTAMP NOT NULL DEFAULT NOW(),
    created_by VARCHAR(100),
    updated_at TIMESTAMP,
    updated_by VARCHAR(100),
    state VARCHAR(20) NOT NULL DEFAULT 'ACTIVE',
    CONSTRAINT fk_aircraft_airline
        FOREIGN KEY (airline_id)
        REFERENCES airline.airline(id),
    CONSTRAINT fk_aircraft_model
        FOREIGN KEY (aircraft_model_id)
        REFERENCES airline.aircraft_model(id),
    CONSTRAINT chk_retired_after_service
        CHECK (retired_on IS NULL OR retired_on >= in_service_on)
);