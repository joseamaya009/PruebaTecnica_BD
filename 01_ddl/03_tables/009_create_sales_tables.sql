CREATE TABLE sales.reservation (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    customer_id UUID NOT NULL,
    reservation_code VARCHAR(20) NOT NULL UNIQUE,
    reserved_at TIMESTAMP NOT NULL DEFAULT NOW(),
    created_at TIMESTAMP NOT NULL DEFAULT NOW(),
    created_by VARCHAR(100),
    updated_at TIMESTAMP,
    updated_by VARCHAR(100),
    state VARCHAR(20) NOT NULL DEFAULT 'ACTIVE',
    CONSTRAINT fk_reservation_customer
        FOREIGN KEY (customer_id)
        REFERENCES customers.customer(id)
);

CREATE TABLE sales.ticket (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    reservation_id UUID NOT NULL,
    ticket_number VARCHAR(20) NOT NULL UNIQUE,
    issued_at TIMESTAMP NOT NULL DEFAULT NOW(),
    created_at TIMESTAMP NOT NULL DEFAULT NOW(),
    created_by VARCHAR(100),
    updated_at TIMESTAMP,
    updated_by VARCHAR(100),
    state VARCHAR(20) NOT NULL DEFAULT 'ACTIVE',
    CONSTRAINT fk_ticket_reservation
        FOREIGN KEY (reservation_id)
        REFERENCES sales.reservation(id)
);

CREATE TABLE sales.ticket_segment (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    ticket_id UUID NOT NULL,
    flight_segment_id UUID NOT NULL,
    seat_number VARCHAR(10),
    created_at TIMESTAMP NOT NULL DEFAULT NOW(),
    created_by VARCHAR(100),
    updated_at TIMESTAMP,
    updated_by VARCHAR(100),
    state VARCHAR(20) NOT NULL DEFAULT 'ACTIVE',
    CONSTRAINT fk_ts_ticket
        FOREIGN KEY (ticket_id)
        REFERENCES sales.ticket(id),
    CONSTRAINT fk_ts_segment
        FOREIGN KEY (flight_segment_id)
        REFERENCES flight_ops.flight_segment(id),
    CONSTRAINT uq_ticket_segment
        UNIQUE (ticket_id, flight_segment_id)
);