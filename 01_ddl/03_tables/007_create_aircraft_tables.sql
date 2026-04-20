CREATE TABLE aircraft.aircraft_cabin (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    aircraft_id UUID NOT NULL,
    cabin_class VARCHAR(50) NOT NULL,
    deck_number SMALLINT NOT NULL,
    created_at TIMESTAMP NOT NULL DEFAULT NOW(),
    created_by VARCHAR(100),
    updated_at TIMESTAMP,
    updated_by VARCHAR(100),
    state VARCHAR(20) NOT NULL DEFAULT 'ACTIVE',
    CONSTRAINT fk_cabin_aircraft
        FOREIGN KEY (aircraft_id)
        REFERENCES airline.aircraft(id),
    CONSTRAINT chk_deck_number CHECK (deck_number > 0)
);

CREATE TABLE aircraft.aircraft_seat (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    aircraft_cabin_id UUID NOT NULL,
    seat_row_number SMALLINT NOT NULL,
    seat_column_code VARCHAR(5) NOT NULL,
    seat_type VARCHAR(50),
    created_at TIMESTAMP NOT NULL DEFAULT NOW(),
    created_by VARCHAR(100),
    updated_at TIMESTAMP,
    updated_by VARCHAR(100),
    state VARCHAR(20) NOT NULL DEFAULT 'ACTIVE',
    CONSTRAINT fk_seat_cabin
        FOREIGN KEY (aircraft_cabin_id)
        REFERENCES aircraft.aircraft_cabin(id),
    CONSTRAINT chk_seat_row CHECK (seat_row_number > 0),
    CONSTRAINT uq_seat
        UNIQUE (aircraft_cabin_id, seat_row_number, seat_column_code)
);

CREATE TABLE aircraft.maintenance_event (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    aircraft_id UUID NOT NULL,
    description TEXT,
    status_code VARCHAR(20) NOT NULL,
    started_at TIMESTAMP,
    completed_at TIMESTAMP,
    created_at TIMESTAMP NOT NULL DEFAULT NOW(),
    created_by VARCHAR(100),
    updated_at TIMESTAMP,
    updated_by VARCHAR(100),
    state VARCHAR(20) NOT NULL DEFAULT 'ACTIVE',
    CONSTRAINT fk_maintenance_aircraft
        FOREIGN KEY (aircraft_id)
        REFERENCES airline.aircraft(id),
    CONSTRAINT chk_status_code
        CHECK (status_code IN ('PLANNED', 'IN_PROGRESS', 'COMPLETED', 'CANCELLED')),
    CONSTRAINT chk_completed_after_started
        CHECK (completed_at IS NULL OR completed_at >= started_at)
);