CREATE OR REPLACE VIEW airport.v_airport_full AS
SELECT
    ap.id AS airport_id,
    ap.name AS airport_name,
    ap.iata_code,
    ap.icao_code,
    ci.name AS city_name,
    co.name AS country_name,
    t.id AS terminal_id,
    t.code AS terminal_code,
    t.name AS terminal_name,
    bg.id AS gate_id,
    bg.code AS gate_code
FROM airport.airport ap
JOIN geography.city ci ON ci.id = ap.city_id
JOIN geography.state_province sp ON sp.id = ci.state_province_id
JOIN geography.country co ON co.id = sp.country_id
LEFT JOIN airport.terminal t ON t.airport_id = ap.id AND t.state = 'ACTIVE'
LEFT JOIN airport.boarding_gate bg ON bg.terminal_id = t.id AND bg.state = 'ACTIVE'
WHERE ap.state = 'ACTIVE';