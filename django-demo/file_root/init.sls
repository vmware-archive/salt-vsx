app-pkgs:
  pkg.installed:
    - names:
      - python-virtualenv
      - python-devel
      - MySQL-python

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
    - source: salt://django-demo/nginx.conf
    - template: jinja
    - makedirs: True
    - mode: 755

python-gunicorn:
  pkg.installed

Django14:
  pkg.installed

/var/www:
  file.directory:
    - user: root






