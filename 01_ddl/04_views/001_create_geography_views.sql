CREATE OR REPLACE VIEW geography.v_city_full AS
SELECT
    ci.id AS city_id,
    ci.name AS city_name,
    sp.name AS state_province_name,
    co.name AS country_name,
    co.iso_code AS country_iso_code,
    cn.name AS continent_name,
    tz.name AS time_zone_name,
    tz.utc_offset
FROM geography.city ci
JOIN geography.state_province sp ON sp.id = ci.state_province_id
JOIN geography.country co ON co.id = sp.country_id
JOIN geography.continent cn ON cn.id = co.continent_id
LEFT JOIN geography.time_zone tz ON tz.state = 'ACTIVE'
WHERE ci.state = 'ACTIVE';