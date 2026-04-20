CREATE OR REPLACE VIEW airline.v_aircraft_detail AS
SELECT
    a.id AS aircraft_id,
    a.registration_code,
    a.in_service_on,
    a.retired_on,
    al.name AS airline_name,
    al.iata_code AS airline_iata,
    am.manufacturer,
    am.model AS aircraft_model,
    am.total_seats
FROM airline.aircraft a
JOIN airline.airline al ON al.id = a.airline_id
JOIN airline.aircraft_model am ON am.id = a.aircraft_model_id
WHERE a.state = 'ACTIVE';