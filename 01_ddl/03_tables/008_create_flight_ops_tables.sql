CREATE TABLE flight_ops.flight (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    airline_id UUID NOT NULL,
    flight_number VARCHAR(10) NOT NULL,
    service_date DATE NOT NULL,
    aircraft_id UUID NOT NULL,
    created_at TIMESTAMP NOT NULL DEFAULT NOW(),
    created_by VARCHAR(100),
    updated_at TIMESTAMP,
    updated_by VARCHAR(100),
    state VARCHAR(20) NOT NULL DEFAULT 'ACTIVE',
    CONSTRAINT fk_flight_airline
        FOREIGN KEY (airline_id)
        REFERENCES airline.airline(id),
    CONSTRAINT fk_flight_aircraft
        FOREIGN KEY (aircraft_id)
        REFERENCES airline.aircraft(id),
    CONSTRAINT uq_flight
        UNIQUE (airline_id, flight_number, service_date)
);

CREATE TABLE flight_ops.flight_segment (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    flight_id UUID NOT NULL,
    segment_number SMALLINT NOT NULL,
    origin_airport_id UUID NOT NULL,
    destination_airport_id UUID NOT NULL,
    scheduled_departure_at TIMESTAMP NOT NULL,
    scheduled_arrival_at TIMESTAMP NOT NULL,
    actual_departure_at TIMESTAMP,
    actual_arrival_at TIMESTAMP,
    created_at TIMESTAMP NOT NULL DEFAULT NOW(),
    created_by VARCHAR(100),
    updated_at TIMESTAMP,
    updated_by VARCHAR(100),
    state VARCHAR(20) NOT NULL DEFAULT 'ACTIVE',
    CONSTRAINT fk_segment_flight
        FOREIGN KEY (flight_id)
        REFERENCES flight_ops.flight(id),
    CONSTRAINT fk_segment_origin
        FOREIGN KEY (origin_airport_id)
        REFERENCES airport.airport(id),
    CONSTRAINT fk_segment_destination
        FOREIGN KEY (destination_airport_id)
        REFERENCES airport.airport(id),
    CONSTRAINT chk_different_airports
        CHECK (origin_airport_id <> destination_airport_id),
    CONSTRAINT chk_arrival_after_departure
        CHECK (scheduled_arrival_at > scheduled_departure_at),
    CONSTRAINT uq_segment
        UNIQUE (flight_id, segment_number)
);