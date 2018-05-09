SELECT `name`, `type`, concat('"', `comment`, '"')
FROM (
  SELECT
    t.table_name "tname", concat('**', t.table_name, '**') as "name", t.table_comment "comment", 'table' as "type", 0 as "pos"
  FROM information_schema.tables t
  WHERE t.table_schema=database()

  UNION ALL
  SELECT
    c.table_name "tname", concat('``', c.column_name, '``') as "name", c.column_comment "comment", c.data_type "type", CAST(c.ordinal_position AS decimal(10,1)) "pos"
  FROM information_schema.columns c
  WHERE c.table_schema=database()
) q
ORDER BY tname, pos;
