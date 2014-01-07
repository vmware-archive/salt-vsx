mysql-server:
  pkg:
    - installed
  service:
    - running
    - name: mysqld
    - enable: True
    - watch:
      - pkg: mysql-server

{{ pillar['mysql_user'] }}:
  mysql_user.present:
    - host: {{ pillar['mysql_remote_host'] }}
    - password: {{ pillar['mysql_password'] }}
    - require:
      - pkg: mysql-server
