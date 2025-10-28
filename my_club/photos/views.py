from django.shortcuts import render
from django.http import HttpResponse
from django.template import loader

def photos(request):
    template = loader.get_template('photosmain.html')
    return HttpResponse(template.render())