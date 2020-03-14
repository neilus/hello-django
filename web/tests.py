# -*- coding: utf-8 -*-
from __future__ import unicode_literals

from django.test import TestCase
from django.utils import timezone
from django.test import Client
from django.http import HttpResponse

from .models import Question

class GetHelloWorldTests(TestCase):

    def test_hello(self):
        client = Client()
        response = client.get('/')

        self.assertContains(response, "Hello", status_code=200)

