CREATE OR REPLACE VIEW identity.v_person_full AS
SELECT
    p.id AS person_id,
    p.first_name,
    p.last_name,
    p.gender_code,
    p.birth_date,
    pt.name AS person_type,
    pd.document_number,
    dt.name AS document_type,
    co.name AS issuing_country,
    pd.issued_on,
    pd.expires_on
FROM identity.person p
JOIN identity.person_type pt ON pt.id = p.person_type_id
LEFT JOIN identity.person_document pd ON pd.person_id = p.id AND pd.state = 'ACTIVE'
LEFT JOIN identity.document_type dt ON dt.id = pd.document_type_id
LEFT JOIN geography.country co ON co.id = pd.issuing_country_id
WHERE p.state = 'ACTIVE';