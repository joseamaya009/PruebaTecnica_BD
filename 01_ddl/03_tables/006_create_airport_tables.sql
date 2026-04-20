CREATE TABLE airport.airport (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    name VARCHAR(150) NOT NULL,
    iata_code CHAR(3) NOT NULL UNIQUE,
    icao_code CHAR(4) NOT NULL UNIQUE,
    city_id UUID NOT NULL,
    created_at TIMESTAMP NOT NULL DEFAULT NOW(),
    created_by VARCHAR(100),
    updated_at TIMESTAMP,
    updated_by VARCHAR(100),
    state VARCHAR(20) NOT NULL DEFAULT 'ACTIVE',
    CONSTRAINT fk_airport_city
        FOREIGN KEY (city_id)
        REFERENCES geography.city(id),
    CONSTRAINT chk_airport_iata CHECK (LENGTH(iata_code) = 3),
    CONSTRAINT chk_airport_icao CHECK (LENGTH(icao_code) = 4)
);

CREATE TABLE airport.terminal (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    airport_id UUID NOT NULL,
    code VARCHAR(10) NOT NULL,
    name VARCHAR(100),
    created_at TIMESTAMP NOT NULL DEFAULT NOW(),
    created_by VARCHAR(100),
    updated_at TIMESTAMP,
    updated_by VARCHAR(100),
    state VARCHAR(20) NOT NULL DEFAULT 'ACTIVE',
    CONSTRAINT fk_terminal_airport
        FOREIGN KEY (airport_id)
        REFERENCES airport.airport(id),
    CONSTRAINT uq_terminal_code
        UNIQUE (airport_id, code)
);

CREATE TABLE airport.boarding_gate (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    terminal_id UUID NOT NULL,
    code VARCHAR(10) NOT NULL,
    created_at TIMESTAMP NOT NULL DEFAULT NOW(),
    created_by VARCHAR(100),
    updated_at TIMESTAMP,
    updated_by VARCHAR(100),
    state VARCHAR(20) NOT NULL DEFAULT 'ACTIVE',
    CONSTRAINT fk_gate_terminal
        FOREIGN KEY (terminal_id)
        REFERENCES airport.terminal(id),
    CONSTRAINT uq_gate_code
        UNIQUE (terminal_id, code)
);