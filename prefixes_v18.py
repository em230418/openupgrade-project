import os
import psycopg2

def main(cr):
    icp = env["ir.config_parameter"]

    env.cr.execute("SELECT array_agg(DISTINCT alias_domain) FROM mail_alias WHERE alias_domain IS NOT NULL")
    alias_domains = env.cr.fetchone()[0]

    env.cr.execute("ALTER TABLE mail_alias ADD COLUMN IF NOT EXISTS alias_domain_id INTEGER")

    for domain in alias_domains:
        print(domain)
        bounce_alias = icp.get_param("mail.bounce.alias") or "bounce"
        env.cr.execute(f"""
        SELECT id
        FROM mail_alias_domain
        WHERE name = '{domain}' AND bounce_alias = '{bounce_alias}'
        """)

        alias_domain_id = None
        for row in env.cr.fetchall():
            alias_domain_id = row[0]

        if not alias_domain_id:
            env.cr.execute(
                f"""
                INSERT INTO mail_alias_domain (
                    name, bounce_alias, catchall_alias, default_from
                )
                VALUES (
                    '{domain}',
                    '{bounce_alias}',
                    '{icp.get_param("mail.catchall.alias") or "catchall"}',
                    '{icp.get_param("mail.default.from") or "notifications"}'
                )
                RETURNING id;
                """,
            )

            (alias_domain_id,) = env.cr.fetchone()

        print(alias_domain_id)
        env.cr.execute(
            f"""
            UPDATE mail_alias
                SET alias_domain_id = {alias_domain_id}
            WHERE alias_domain = '{domain}';
            """,
        )
        print(env.cr.rowcount)
    env.cr.commit()

main(env)
