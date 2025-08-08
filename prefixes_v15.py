def main(env):
    # adding German states
    states = (
        ("state_de_bw","DE-BW"),
        ("state_de_by","DE-BY"),
        ("state_de_be","DE-BE"),
        ("state_de_bb","DE-BB"),
        ("state_de_hb","DE-HB"),
        ("state_de_hh","DE-HH"),
        ("state_de_he","DE-HE"),
        ("state_de_mv","DE-MV"),
        ("state_de_ni","DE-NI"),
        ("state_de_nw","DE-NW"),
        ("state_de_rp","DE-RP"),
        ("state_de_sl","DE-SL"),
        ("state_de_sn","DE-SN"),
        ("state_de_st","DE-ST"),
        ("state_de_sh","DE-SH"),
        ("state_de_th","DE-TH"),
    )
    for x in states:
        de = env.ref("base.de")
        record = env["res.country.state"].search([
            ("country_id", "=", de.id),
            ("code", "=", x[1]),
        ])
        if record:
            env["ir.model.data"].create({
                "name": x[0],
                "model": "res.country.state",
                "module": "base",
                "res_id": record.id,
            })

main(env); env.cr.commit()
