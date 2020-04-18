import pytest


@pytest.mark.django_db
def test_return_status_ok(client):
    resp = client.get('/')

    assert "Hello" in resp.content.__str__()


def test_response_contains_hello(client):
    resp = client.get('/')

    assert resp.status_code == 200
