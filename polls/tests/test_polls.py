from django.test import TestCase
from django.utils import timezone
from django.test import Client
from django.http import HttpResponse


class GetPollsIndexHelloWorldTests(TestCase):

    def test_hello(self):
        client = Client()
        response = client.get('/polls/')

        self.assertContains(
            response,
            "Hello, world. You're at the polls index.",
            status_code=200)
