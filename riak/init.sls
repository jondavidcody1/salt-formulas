{% from "riak/map.jinja" import riak with context %}

riak:
  pkg.installed:
    - names:
      - build-essential
      - libpam0g-dev
      - libncurses5-dev
      - openssl
      - libssl-dev
      - fop
      - xsltproc
      - unixodbc-dev
      - libwxbase2.8-dev
      - libwxgtk2.8-dev
      - libqt4-opengl-dev
      - erlang
  file.managed:
    - name: /opt/src/riak-{{ riak.version }}.tar.gz
    - source: http://s3.amazonaws.com/downloads.basho.com/riak/2.0/{{ riak.version }}/riak-{{ riak.version }}.tar.gz
    - source_hash: sha1={{ riak.checksum }}
    - require:
      - pkg: riak
  cmd.run:
    - cwd: /opt/src
    - name: tar xvzf riak-{{ riak.version }}.tar.gz
    - user: root
    - group: root
    - shell: /bin/bash
    - require:
      - file: riak

riak-build:
  cmd.run:
    - cwd: /opt/src/riak-{{ riak.version }}
    - name: make rel
    - user: root
    - group: root
    - shell: /bin/bash
    - require:
      - cmd: riak
