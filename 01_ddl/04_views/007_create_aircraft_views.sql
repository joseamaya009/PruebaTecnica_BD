CREATE OR REPLACE VIEW aircraft.v_maintenance_history AS
SELECT
    a.id AS aircraft_id,
    a.registration_code,
    al.name AS airline_name,
    me.id AS event_id,
    me.description,
    me.status_code,
    me.started_at,
    me.completed_at
FROM aircraft.maintenance_event me
JOIN airline.aircraft a ON a.id = me.aircraft_id
JOIN airline.airline al ON al.id = a.airline_id
WHERE me.state = 'ACTIVE'
ORDER BY me.started_at DESC;