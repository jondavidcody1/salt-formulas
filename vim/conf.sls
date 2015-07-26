{% from "vim/map.jinja" import vim with context %}

include:
  - vim

amix_vimrc:
  git.latest:
    - name: {{ vim.url }}
    - target: /home/{{ vim.user }}/.vim_runtime
    - user: {{ vim.user }}
    - rev: master
    - require:
      - pkg: vim
  cmd.run:
    - name: chmod +x install_*.sh && sh install_awesome_vimrc.sh
    - cwd: /home/{{ vim.user }}/.vim_runtime
    - user: {{ vim.user }}
    - group: {{ vim.group }}
    - shell: /bin/bash
    - require:
      - git: amix_vimrc
