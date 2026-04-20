CREATE OR REPLACE VIEW boarding.v_boarding_status AS
SELECT
    f.flight_number,
    f.service_date,
    fs.segment_number,
    orig.iata_code AS origin_iata,
    dest.iata_code AS destination_iata,
    p.first_name,
    p.last_name,
    ts.seat_number,
    ci.checked_in_at,
    bp.boarding_group,
    bg.code AS gate_code,
    t.code AS terminal_code
FROM flight_ops.flight f
JOIN flight_ops.flight_segment fs ON fs.flight_id = f.id
JOIN airport.airport orig ON orig.id = fs.origin_airport_id
JOIN airport.airport dest ON dest.id = fs.destination_airport_id
LEFT JOIN sales.ticket_segment ts ON ts.flight_segment_id = fs.id
LEFT JOIN sales.ticket tk ON tk.id = ts.ticket_id
LEFT JOIN sales.reservation r ON r.id = tk.reservation_id
LEFT JOIN customers.customer cu ON cu.id = r.customer_id
LEFT JOIN identity.person p ON p.id = cu.person_id
LEFT JOIN boarding.check_in ci ON ci.ticket_segment_id = ts.id
LEFT JOIN boarding.boarding_pass bp ON bp.check_in_id = ci.id
LEFT JOIN airport.boarding_gate bg ON bg.id = bp.boarding_gate_id
LEFT JOIN airport.terminal t ON t.id = bg.terminal_id
WHERE f.state = 'ACTIVE'
ORDER BY f.service_date, f.flight_number, fs.segment_number;