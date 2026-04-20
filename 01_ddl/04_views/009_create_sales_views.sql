CREATE OR REPLACE VIEW sales.v_reservation_detail AS
SELECT
    r.id AS reservation_id,
    r.reservation_code,
    r.reserved_at,
    p.first_name,
    p.last_name,
    al.name AS airline_name,
    t.ticket_number,
    t.issued_at,
    fs.segment_number,
    orig.iata_code AS origin_iata,
    dest.iata_code AS destination_iata,
    fs.scheduled_departure_at,
    ts.seat_number
FROM sales.reservation r
JOIN customers.customer c ON c.id = r.customer_id
JOIN identity.person p ON p.id = c.person_id
JOIN airline.airline al ON al.id = c.airline_id
LEFT JOIN sales.ticket t ON t.reservation_id = r.id AND t.state = 'ACTIVE'
LEFT JOIN sales.ticket_segment ts ON ts.ticket_id = t.id
LEFT JOIN flight_ops.flight_segment fs ON fs.id = ts.flight_segment_id
LEFT JOIN airport.airport orig ON orig.id = fs.origin_airport_id
LEFT JOIN airport.airport dest ON dest.id = fs.destination_airport_id
WHERE r.state = 'ACTIVE';