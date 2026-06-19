delete from ir_module_module_dependency where name ilike 'muk%';
delete from ir_module_module_dependency where name IN ('itl_tools', 'itl_styles', 'l10n_ru_itl', 'res_partner_completeness', 'model_completeness');
delete from ir_module_module_dependency where name IN ('muk_web_theme_mail', 'payment_itl', 'muk_web_branding', 'saas_openshift_client', 'dms');
INSERT INTO ir_module_module (name, state, latest_version) VALUES ('partner_manual_rank', 'installed', '12.0.0.0.0');
