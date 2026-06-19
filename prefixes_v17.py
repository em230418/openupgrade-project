import os
import psycopg2

def main(cr):
    icp = env["ir.config_parameter"]

    env.cr.execute("SELECT array_agg(DISTINCT alias_domain) FROM mail_alias WHERE alias_domain IS NOT NULL")
    alias_domains = env.cr.fetchone()[0]

    env.cr.execute("ALTER TABLE mail_alias ADD COLUMN IF NOT EXISTS alias_domain_id INTEGER")

    for domain in alias_domains:
        env.cr.execute(
            f"""
            INSERT INTO mail_alias_domain (
                name, bounce_alias, catchall_alias, default_from)
            VALUES (
                '{domain}',
                '{icp.get_param("mail.bounce.alias") or "bounce"}',
                '{icp.get_param("mail.catchall.alias") or "catchall"}',
                '{icp.get_param("mail.default.from") or "notifications"}'
                )
            RETURNING id;
            """,
        )
        (alias_domain_id,) = env.cr.fetchone()
        env.cr.execute(
            f"""
            UPDATE mail_alias
                SET alias_domain_id = {alias_domain_id}
            WHERE alias_domain = '{domain}';
            """,
        )

conn = psycopg2.connect(dbname="db", user="odoo", password="odoo", host="db", port=5432)
cr = conn.cursor()
main(cr)
conn.commit()
