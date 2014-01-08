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

django-project-init:
  cmd.wait:
    - name: /usr/bin/django-admin startproject myapp
    - cwd: /var/www
    - watch:
      - pkg: Django14
  cmd.wait:
    - name: /var/www/myapp/manage.py syncdb
    - watch:
      - file: django-app

settings:
  file.managed:
    - name: /var/www/myapp/settings.py
    - source: salt://django-demo/settings.py
    - template: jinja

django-app:
  file.managed:
    - name: /var/www/myapp/views.py
    - source: salt://django-demo/app/views.py

  file.managed:
    - name: /var/www/myapp/models.py
    - source: salt://django-demo/app/models.py

django-server:
  cmd.wait:
    - name: /usr/bin/gunicorn --daemon myapp.wsgi:application
    - cwd: /var/www/myapp
    - watch:
      - file: settings