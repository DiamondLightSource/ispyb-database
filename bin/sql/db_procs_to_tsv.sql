SELECT concat('"**', r.ROUTINE_NAME, '**",') as "name",
    concat('"', trim(REPLACE(REPLACE(REPLACE(REPLACE(p.param_list, '\n', ' '), '\r', ' '), '\t', ' '), '"', '')), '",') as "params",
    concat('"', REPLACE(r.ROUTINE_COMMENT, '"', ''), '"') as "comment"
--    ,r.LAST_ALTERED as "modified"
--    ,GROUP_CONCAT(pp.user) as "users"
-- INTO OUTFILE '${file}'
-- FIELDS TERMINATED BY ','
-- ENCLOSED BY '"'
-- -- FIELDS ESCAPED BY '\'
-- LINES TERMINATED BY '\n'
FROM information_schema.ROUTINES r
--    LEFT OUTER JOIN mysql.procs_priv pp ON pp.routine_name = r.routine_name
    INNER JOIN mysql.proc p ON p.name = r.routine_name AND p.db = r.ROUTINE_SCHEMA
WHERE r.ROUTINE_SCHEMA = database()
    AND r.ROUTINE_TYPE = 'PROCEDURE'
-- GROUP BY r.ROUTINE_NAME,
--    r.ROUTINE_COMMENT,
--    r.LAST_ALTERED,
--    TRIM(REPLACE(REPLACE(REPLACE(p.param_list, '\n', ' '), '\r', ' '), '\t', ' '))
ORDER BY ROUTINE_NAME ASC;
