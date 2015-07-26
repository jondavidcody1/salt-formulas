{% from "git/map.jinja" import git with context %}

include:
  - git

git-conf:
  cmd.run:
    - cwd: ~
    - name: git config --global user.name {{ git.gituser }} && git config --global user.email {{ git.gitemail }}
    - user: {{ git.user }}
    - group: {{ git.user }}
    - shell: /bin/bash
    - require:
      - pkg: git
