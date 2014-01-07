app-pkgs:
  pkg.installed:
    - names:
      - python-virtualenv
      - python-devel
      - MySQL-python

settings:
  file.managed:
    - name: /var/www/myapp/settings.py
    - source: salt://webserver/settings.py
    - template: jinja

nginx:
  pkg:
    - latest
  service:
    - running
    - watch:
      - file: nginxconf

nginxconf:
  file.managed:
    - name: /etc/nginx/conf.d/default.conf
    - source: salt://webserver/nginx.conf
    - template: jinja
    - makedirs: True
    - mode: 755