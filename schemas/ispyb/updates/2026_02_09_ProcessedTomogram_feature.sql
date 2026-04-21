INSERT IGNORE INTO SchemaStatus (scriptName, schemaStatus) VALUES ('2026_02_09_ProcessedTomogram_feature.sql', 'ONGOING');

ALTER TABLE ProcessedTomogram
  ADD feature enum(
      'Membrane',
      'Microtubule',
      'Ribosome',
      'Tric',
      'Actin',
      'Cytoplasm',
      'Cytoplasmic granule',
      'Lipid droplet',
      'Mitochondrial granule',
      'Mitochondrion',
      'Npc',
      'Nuclear envelope',
      'Nucleus',
      'Prohibitin',
      'Proteasome',
      'Vault',
      'Vimentin',
      'Void')
    COMMENT 'Tomogram feature',
  ALGORITHM=INSTANT;

UPDATE SchemaStatus SET schemaStatus = 'DONE' WHERE scriptName = '2026_02_09_ProcessedTomogram_feature.sql';
