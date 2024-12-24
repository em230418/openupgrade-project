update stock_move set product_uom = 8500 where id = 1657042;
update stock_move set product_uom = 8663 where id = 16069212;
-- discount product in POS
update product_template set active = true where id = 3492;
update product_product set active = true where product_tmpl_id = 3492;
-- incorrect working coupon program with expired items
update coupon_program set active = false where id = 8;

-- set rounding as "Product Unit of Measure"
update uom_uom set rounding = 0.001 where id in (select distinct product_uom_id from stock_move_line) and rounding < 1;
update uom_uom set rounding = 0.001 where id in (select distinct product_uom from stock_move) and rounding < 1;
