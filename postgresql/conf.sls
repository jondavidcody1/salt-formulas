{% from "postgresql/map.jinja" import postgresql with context %}

include:
  - postgresql

postgresql-conf:
  postgres_user.present:
    - name: {{ postgresql.db_user }}
    - password: {{ postgresql.db_password }}
    - createdb: True
    - encrypted: True
    - login: True
    - user: postgres
    - require:
      - file: postgresql
  postgres_database.present:
    - name: {{ postgresql.db }}
    - encoding: UTF8
    - lc_collate: en_US.UTF8
    - lc_ctype: en_US.UTF8
    - owner: {{ postgresql.db_user }}
    - template: template0
    - user: postgres
    - require:
      - postgres_user: postgresql-conf
