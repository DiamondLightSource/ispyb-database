SELECT concat('"**', r.ROUTINE_NAME, '**",') as "name",
    concat('"', trim(REPLACE(REPLACE(REPLACE(REPLACE(p.param_list, '\n', ' '), '\r', ' '), '\t', ' '), '"', '')), '",') as "params",
    concat('"', IFNULL(GROUP_CONCAT(DISTINCT pp.user ORDER BY pp.user SEPARATOR ', '), 'none'), '",') as "users",
    concat('"', REPLACE(r.ROUTINE_COMMENT, '"', ''), '"') as "comment"
FROM information_schema.ROUTINES r
    INNER JOIN mysql.proc p ON p.name = r.routine_name AND p.db = r.ROUTINE_SCHEMA
    LEFT OUTER JOIN mysql.procs_priv pp ON r.routine_name = pp.Routine_name AND r.ROUTINE_SCHEMA = pp.Db
WHERE r.ROUTINE_SCHEMA = database()
    AND r.ROUTINE_TYPE = 'PROCEDURE'
GROUP BY r.ROUTINE_NAME, p.param_list, r.ROUTINE_COMMENT
ORDER BY r.ROUTINE_NAME ASC;
