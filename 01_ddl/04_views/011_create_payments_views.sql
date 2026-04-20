CREATE OR REPLACE VIEW payments.v_payment_summary AS
SELECT
    r.reservation_code,
    p.first_name,
    p.last_name,
    pay.id AS payment_id,
    pay.amount,
    cur.iso_currency_code AS currency,
    pay.paid_at,
    ref.id AS refund_id,
    ref.amount AS refund_amount,
    ref.requested_at AS refund_requested_at,
    ref.processed_at AS refund_processed_at
FROM payments.payment pay
JOIN sales.reservation r ON r.id = pay.reservation_id
JOIN customers.customer cu ON cu.id = r.customer_id
JOIN identity.person p ON p.id = cu.person_id
JOIN geography.currency cur ON cur.id = pay.currency_id
LEFT JOIN payments.refund ref ON ref.payment_id = pay.id AND ref.state = 'ACTIVE'
WHERE pay.state = 'ACTIVE';