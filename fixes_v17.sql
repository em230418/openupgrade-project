UPDATE res_partner SET tz = 'Asia/Kolkata' WHERE tz = 'Asia/Calcutta';
INSERT INTO res_groups_implied_rel (gid, hid) VALUES (1,23);
delete from ir_ui_view where name = 'account.journal.dashboard.kanban.inherit';
