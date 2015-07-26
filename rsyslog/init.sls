{% from "rsyslog/map.jinja" import rsyslog with context %}

rsyslog:
  pkg.installed:
    - names:
      - libestr-dev
      - libjson-c-dev
      - uuid-dev
      - libgcrypt11-dev
  file.managed:
    - name: /opt/src/rsyslog-{{ rsyslog.version }}.tar.gz
    - source: http://www.rsyslog.com/files/download/rsyslog/rsyslog-{{ rsyslog.version }}.tar.gz
    - source_hash: sha256={{ rsyslog.checksum }}
    - require:
      - pkg: rsyslog
  cmd.run:
    - cwd: /opt/src
    - name: tar xvzf rsyslog-{{ rsyslog.version }}.tar.gz
    - user: root
    - group: root
    - shell: /bin/bash
    - require:
      - file: rsyslog

rsyslog-build:
  file.directory:
    - name: /var/spool/rsyslog
    - user: root
    - group: root
    - mode: 755
    - makedirs: True
    - require:
      - cmd: rsyslog
  cmd.run:
    - cwd: /opt/src/rsyslog-{{ rsyslog.version }}
    - name: ./configure --disable-liblogging-stdlog --disable-generate-man-pages && make check install clean
    - user: root
    - group: root
    - shell: /bin/bash
    - require:
      - file: rsyslog-build
