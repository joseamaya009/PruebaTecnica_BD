CREATE TABLE identity.person_type (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    name VARCHAR(100) NOT NULL UNIQUE,
    created_at TIMESTAMP NOT NULL DEFAULT NOW(),
    created_by VARCHAR(100),
    updated_at TIMESTAMP,
    updated_by VARCHAR(100),
    state VARCHAR(20) NOT NULL DEFAULT 'ACTIVE'
);

CREATE TABLE identity.document_type (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    name VARCHAR(100) NOT NULL UNIQUE,
    abbreviation VARCHAR(20),
    created_at TIMESTAMP NOT NULL DEFAULT NOW(),
    created_by VARCHAR(100),
    updated_at TIMESTAMP,
    updated_by VARCHAR(100),
    state VARCHAR(20) NOT NULL DEFAULT 'ACTIVE'
);

CREATE TABLE identity.person (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    first_name VARCHAR(100) NOT NULL,
    last_name VARCHAR(100) NOT NULL,
    gender_code CHAR(1),
    birth_date DATE,
    person_type_id UUID NOT NULL,
    created_at TIMESTAMP NOT NULL DEFAULT NOW(),
    created_by VARCHAR(100),
    updated_at TIMESTAMP,
    updated_by VARCHAR(100),
    state VARCHAR(20) NOT NULL DEFAULT 'ACTIVE',
    CONSTRAINT fk_person_type
        FOREIGN KEY (person_type_id)
        REFERENCES identity.person_type(id),
    CONSTRAINT chk_gender_code
        CHECK (gender_code IN ('F', 'M', 'X') OR gender_code IS NULL)
);

CREATE TABLE identity.person_document (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    person_id UUID NOT NULL,
    document_type_id UUID NOT NULL,
    document_number VARCHAR(50) NOT NULL,
    issuing_country_id UUID NOT NULL,
    issued_on DATE,
    expires_on DATE,
    created_at TIMESTAMP NOT NULL DEFAULT NOW(),
    created_by VARCHAR(100),
    updated_at TIMESTAMP,
    updated_by VARCHAR(100),
    state VARCHAR(20) NOT NULL DEFAULT 'ACTIVE',
    CONSTRAINT fk_document_person
        FOREIGN KEY (person_id)
        REFERENCES identity.person(id),
    CONSTRAINT fk_document_type
        FOREIGN KEY (document_type_id)
        REFERENCES identity.document_type(id),
    CONSTRAINT fk_document_country
        FOREIGN KEY (issuing_country_id)
        REFERENCES geography.country(id),
    CONSTRAINT uq_person_document
        UNIQUE (document_type_id, issuing_country_id, document_number),
    CONSTRAINT chk_expiry_after_issue
        CHECK (expires_on IS NULL OR expires_on > issued_on)
);