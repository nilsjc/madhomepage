from django.shortcuts import render
from django.http import HttpResponse
from django.template import loader

def members(request):
    return HttpResponse("Welcome to the members page!")

def main(request):
  template = loader.get_template('main.html')
  return HttpResponse(template.render())


def testing(request):
  template = loader.get_template('template.html')
  context = {
    'fruits': ['Apple', 'Banana', 'Cherry'],   
  }
  return HttpResponse(template.render(context, request))