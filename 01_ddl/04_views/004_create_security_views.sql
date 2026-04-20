CREATE OR REPLACE VIEW security.v_user_permissions AS
SELECT
    u.id AS user_id,
    u.username,
    u.email,
    r.name AS role_name,
    pe.name AS permission_name,
    f.name AS form_name,
    f.route AS form_route
FROM security."user" u
JOIN security.role r ON r.id = u.role_id
LEFT JOIN security.role_permission rp ON rp.role_id = r.id
LEFT JOIN security.permission pe ON pe.id = rp.permission_id
LEFT JOIN security.form_module fm ON fm.permission_id = pe.id
LEFT JOIN security.form f ON f.id = fm.form_id
WHERE u.state = 'ACTIVE'
  AND r.state = 'ACTIVE';