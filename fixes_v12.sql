INSERT INTO ir_module_module(name, latest_version, state) VALUES
('stormoff_crm_dadata', '12.0.0.1.0', 'installed'),
('stormoff_mail', '12.0.0.1.0', 'installed'),
('stormoff_sms', '12.0.0.1.0', 'installed');

DELETE FROM auditlog_log_line;
DELETE FROM auditlog_log;
DELETE FROM auditlog_http_request;
DELETE FROM auditlog_http_session;
