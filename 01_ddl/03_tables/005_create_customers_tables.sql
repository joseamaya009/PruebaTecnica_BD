CREATE TABLE customers.loyalty_program (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    airline_id UUID NOT NULL,
    name VARCHAR(150) NOT NULL,
    created_at TIMESTAMP NOT NULL DEFAULT NOW(),
    created_by VARCHAR(100),
    updated_at TIMESTAMP,
    updated_by VARCHAR(100),
    state VARCHAR(20) NOT NULL DEFAULT 'ACTIVE',
    CONSTRAINT fk_program_airline
        FOREIGN KEY (airline_id)
        REFERENCES airline.airline(id)
);

CREATE TABLE customers.customer (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    person_id UUID NOT NULL,
    airline_id UUID NOT NULL,
    loyalty_program_id UUID,
    created_at TIMESTAMP NOT NULL DEFAULT NOW(),
    created_by VARCHAR(100),
    updated_at TIMESTAMP,
    updated_by VARCHAR(100),
    state VARCHAR(20) NOT NULL DEFAULT 'ACTIVE',
    CONSTRAINT fk_customer_person
        FOREIGN KEY (person_id)
        REFERENCES identity.person(id),
    CONSTRAINT fk_customer_airline
        FOREIGN KEY (airline_id)
        REFERENCES airline.airline(id),
    CONSTRAINT fk_customer_program
        FOREIGN KEY (loyalty_program_id)
        REFERENCES customers.loyalty_program(id),
    CONSTRAINT uq_customer
        UNIQUE (person_id, airline_id)
);