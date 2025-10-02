def main(env):
    env["ir.model.data"].search([
        ("module", "=", "website"),
        ("name", "=", "header_call_to_action"),
    ]).write({
        "res_id": 3691,
    })

    REMOVE_ID = 3265
    env["ir.ui.view"].search([("inherit_id.inherit_id", "=", REMOVE_ID)]).unlink()
    env["ir.ui.view"].search([("inherit_id", "=", REMOVE_ID)]).unlink()
    env["ir.ui.view"].search([("id", "=", REMOVE_ID)]).unlink()

main(env); env.cr.commit()
