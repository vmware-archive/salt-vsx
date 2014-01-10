from myapp import settings
from myapp.models import InstallDetails
from django.http import HttpResponse
from datetime import datetime


def home(request):
    installed_dates = InstallDetails.objects.all()
    if not installed_dates:
        install_date = InstallDetails(installed_date=datetime.now())
        install_date.save()
        install_date = install_date.installed_date
    else:
        install_date = installed_dates[0].installed_date
    return HttpResponse('<pre>Welcome to the VMware Salt Stack demo server!\
    \n\nYou are connected to the following DB: {0}\n\nInstalled date: {1}</pre>'.format(
        settings.DATABASES['default']['NAME'], install_date))