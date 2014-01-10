mysql-server:
  pkg:
    - installed
  service:
    - running
    - name: mysqld
    - enable: True
    - watch:
      - pkg: mysql-server

{% for remote_host in pillar['remote_host_array'] %}
{{ remote_host }}:
  mysql_user.present:
    - name: {{ pillar['mysql_user'] }}
    - host: {{ remote_host }}
    - password: {{ pillar['mysql_password'] }}
    - require:
      - pkg: mysql-server
{% endfor %}

{{ pillar['mysql_db'] }}:
  mysql_database.present