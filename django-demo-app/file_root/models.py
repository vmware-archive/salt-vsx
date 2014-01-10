from django.db import models

class InstallDetails(models.Model):
    installed_date = models.DateTimeField(auto_now_add=True)