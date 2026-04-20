CREATE TABLE payments.payment (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    reservation_id UUID NOT NULL,
    amount NUMERIC(12,2) NOT NULL,
    currency_id UUID NOT NULL,
    paid_at TIMESTAMP NOT NULL DEFAULT NOW(),
    created_at TIMESTAMP NOT NULL DEFAULT NOW(),
    created_by VARCHAR(100),
    updated_at TIMESTAMP,
    updated_by VARCHAR(100),
    state VARCHAR(20) NOT NULL DEFAULT 'ACTIVE',
    CONSTRAINT fk_payment_reservation
        FOREIGN KEY (reservation_id)
        REFERENCES sales.reservation(id),
    CONSTRAINT fk_payment_currency
        FOREIGN KEY (currency_id)
        REFERENCES geography.currency(id),
    CONSTRAINT chk_payment_amount CHECK (amount > 0)
);

CREATE TABLE payments.refund (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    payment_id UUID NOT NULL,
    amount NUMERIC(12,2) NOT NULL,
    reason TEXT,
    requested_at TIMESTAMP NOT NULL DEFAULT NOW(),
    processed_at TIMESTAMP,
    created_at TIMESTAMP NOT NULL DEFAULT NOW(),
    created_by VARCHAR(100),
    updated_at TIMESTAMP,
    updated_by VARCHAR(100),
    state VARCHAR(20) NOT NULL DEFAULT 'ACTIVE',
    CONSTRAINT fk_refund_payment
        FOREIGN KEY (payment_id)
        REFERENCES payments.payment(id),
    CONSTRAINT chk_refund_amount CHECK (amount > 0),
    CONSTRAINT chk_processed_after_requested
        CHECK (processed_at IS NULL OR processed_at >= requested_at)
);