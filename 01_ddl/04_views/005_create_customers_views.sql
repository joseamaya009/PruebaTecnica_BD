CREATE OR REPLACE VIEW customers.v_customer_loyalty AS
SELECT
    c.id AS customer_id,
    p.first_name,
    p.last_name,
    al.name AS airline_name,
    lp.name AS loyalty_program_name
FROM customers.customer c
JOIN identity.person p ON p.id = c.person_id
JOIN airline.airline al ON al.id = c.airline_id
LEFT JOIN customers.loyalty_program lp ON lp.id = c.loyalty_program_id
WHERE c.state = 'ACTIVE';