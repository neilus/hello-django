import pytest
from greeter.greeter import greet


def test_greeting_hello_world():
    assert "Hello World!" == greet()
