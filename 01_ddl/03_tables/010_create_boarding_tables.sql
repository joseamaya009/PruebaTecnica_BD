CREATE TABLE boarding.check_in (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    ticket_segment_id UUID NOT NULL UNIQUE,
    checked_in_at TIMESTAMP NOT NULL DEFAULT NOW(),
    created_at TIMESTAMP NOT NULL DEFAULT NOW(),
    created_by VARCHAR(100),
    updated_at TIMESTAMP,
    updated_by VARCHAR(100),
    state VARCHAR(20) NOT NULL DEFAULT 'ACTIVE',
    CONSTRAINT fk_checkin_ticket_segment
        FOREIGN KEY (ticket_segment_id)
        REFERENCES sales.ticket_segment(id)
);

CREATE TABLE boarding.boarding_pass (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    check_in_id UUID NOT NULL UNIQUE,
    boarding_gate_id UUID NOT NULL,
    boarding_group VARCHAR(10),
    created_at TIMESTAMP NOT NULL DEFAULT NOW(),
    created_by VARCHAR(100),
    updated_at TIMESTAMP,
    updated_by VARCHAR(100),
    state VARCHAR(20) NOT NULL DEFAULT 'ACTIVE',
    CONSTRAINT fk_pass_checkin
        FOREIGN KEY (check_in_id)
        REFERENCES boarding.check_in(id),
    CONSTRAINT fk_pass_gate
        FOREIGN KEY (boarding_gate_id)
        REFERENCES airport.boarding_gate(id)
);