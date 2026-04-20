CREATE TABLE billing.invoice (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    reservation_id UUID NOT NULL,
    invoice_number VARCHAR(30) NOT NULL UNIQUE,
    issued_at TIMESTAMP NOT NULL DEFAULT NOW(),
    due_at TIMESTAMP,
    created_at TIMESTAMP NOT NULL DEFAULT NOW(),
    created_by VARCHAR(100),
    updated_at TIMESTAMP,
    updated_by VARCHAR(100),
    state VARCHAR(20) NOT NULL DEFAULT 'ACTIVE',
    CONSTRAINT fk_invoice_reservation
        FOREIGN KEY (reservation_id)
        REFERENCES sales.reservation(id),
    CONSTRAINT chk_due_after_issued
        CHECK (due_at IS NULL OR due_at >= issued_at)
);

CREATE TABLE billing.invoice_line (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    invoice_id UUID NOT NULL,
    description VARCHAR(200) NOT NULL,
    quantity SMALLINT NOT NULL,
    unit_price NUMERIC(12,2) NOT NULL,
    created_at TIMESTAMP NOT NULL DEFAULT NOW(),
    created_by VARCHAR(100),
    updated_at TIMESTAMP,
    updated_by VARCHAR(100),
    state VARCHAR(20) NOT NULL DEFAULT 'ACTIVE',
    CONSTRAINT fk_line_invoice
        FOREIGN KEY (invoice_id)
        REFERENCES billing.invoice(id),
    CONSTRAINT chk_quantity CHECK (quantity > 0),
    CONSTRAINT chk_unit_price CHECK (unit_price >= 0)
);