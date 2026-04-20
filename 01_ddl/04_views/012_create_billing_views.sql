CREATE OR REPLACE VIEW billing.v_invoice_total AS
SELECT
    inv.id AS invoice_id,
    inv.invoice_number,
    inv.issued_at,
    inv.due_at,
    r.reservation_code,
    p.first_name,
    p.last_name,
    COUNT(il.id) AS total_lines,
    SUM(il.quantity * il.unit_price) AS total_amount
FROM billing.invoice inv
JOIN sales.reservation r ON r.id = inv.reservation_id
JOIN customers.customer cu ON cu.id = r.customer_id
JOIN identity.person p ON p.id = cu.person_id
LEFT JOIN billing.invoice_line il ON il.invoice_id = inv.id AND il.state = 'ACTIVE'
WHERE inv.state = 'ACTIVE'
GROUP BY
    inv.id,
    inv.invoice_number,
    inv.issued_at,
    inv.due_at,
    r.reservation_code,
    p.first_name,
    p.last_name;