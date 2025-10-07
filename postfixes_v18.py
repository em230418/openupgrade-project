def main(env):
    for view_id, ext_id in env['ir.ui.view'].search([('key', '=', 'website.header_call_to_action_large')]).get_external_id().items():
        if not ext_id:
            REMOVE_ID = view_id
            break

    env["ir.ui.view"].search([("inherit_id.inherit_id", "=", REMOVE_ID)]).unlink()
    env["ir.ui.view"].search([("inherit_id", "=", REMOVE_ID)]).unlink()
    env["ir.ui.view"].search([("id", "=", REMOVE_ID)]).unlink()

main(env); env.cr.commit()
