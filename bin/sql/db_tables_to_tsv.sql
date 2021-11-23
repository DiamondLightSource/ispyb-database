SELECT `name`, `type`, concat('"', `comment`, '"')
FROM (
  SELECT
    t.table_name AS "tname",
    concat('**', t.table_name, '**') AS "name",
    t.table_comment "comment",
    'table' AS "type",
    0 AS "pos"
  FROM information_schema.tables t
  WHERE t.table_schema=database()

  UNION ALL
  SELECT
    c.table_name "tname", 
    concat('``', c.column_name, '``') AS "name",
    replace(c.column_comment, '\"', '\'') AS "comment",
    c.data_type AS "type",
    CAST(c.ordinal_position AS decimal(10,1)) AS "pos"
  FROM information_schema.columns c
  WHERE c.table_schema=database()
) q
ORDER BY tname, pos;
