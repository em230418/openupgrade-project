DELETE from crm_team where alias_id in (select id from mail_alias where alias_name is null and alias_domain is null);
DELETE FROM mail_alias WHERE alias_name IS NULL AND alias_domain IS NULL AND id not in (SELECT alias_id FROM mail_group);

ALTER TABLE mail_alias ADD COLUMN IF NOT EXISTS alias_domain_id INTEGER;
