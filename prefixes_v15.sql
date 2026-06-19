delete from ir_module_module_dependency where name = 'auditlog';
update ir_module_module set state = 'uninstalled' where name = 'auditlog';
