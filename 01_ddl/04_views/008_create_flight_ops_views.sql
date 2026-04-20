CREATE OR REPLACE VIEW flight_ops.v_flight_detail AS
SELECT
    f.id AS flight_id,
    f.flight_number,
    f.service_date,
    al.name AS airline_name,
    a.registration_code AS aircraft_registration,
    fs.segment_number,
    orig.iata_code AS origin_iata,
    orig.name AS origin_airport,
    dest.iata_code AS destination_iata,
    dest.name AS destination_airport,
    fs.scheduled_departure_at,
    fs.scheduled_arrival_at,
    fs.actual_departure_at,
    fs.actual_arrival_at
FROM flight_ops.flight f
JOIN airline.airline al ON al.id = f.airline_id
JOIN airline.aircraft a ON a.id = f.aircraft_id
JOIN flight_ops.flight_segment fs ON fs.flight_id = f.id
JOIN airport.airport orig ON orig.id = fs.origin_airport_id
JOIN airport.airport dest ON dest.id = fs.destination_airport_id
WHERE f.state = 'ACTIVE'
ORDER BY f.service_date, f.flight_number, fs.segment_number;