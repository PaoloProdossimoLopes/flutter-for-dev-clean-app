import 'dart:convert';

import 'package:faker/faker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart';
import 'package:mockito/mockito.dart';

class ClientSpy extends Mock implements Client { }

class HTTPAdapter {

  final Client client;

  HTTPAdapter(this.client);

  Future<void> request({
    @required String url,
    @required String method,
    Map body
  }) async {
    client.post(url,  headers: {
        'content-type': 'application/json',
        'accept': 'application/json'
        }, body: body != null ? jsonEncode(body) : null);
  }
}

void main() {
  ClientSpy client;
  HTTPAdapter sut;
  String url;

  setUp(() {
    client = ClientSpy();
    sut = HTTPAdapter(client);
    url = faker.internet.httpUrl();
  });

  group('POST', () {
    test('should call post with correct values', () async {
      sut.request(url: url, method: "POST");

      verify(client.post(url, headers: {
        'content-type': 'application/json',
        'accept': 'application/json'
        }));
    });

     test('should call post with no body', () async {
      sut.request(url: url, method: "POST");

      verify(client.post(url, headers: {
        'content-type': 'application/json',
        'accept': 'application/json'
        }, body: null));
    });

    test('should call post with body', () async {
      sut.request(url: url, method: "POST", body: { "any_key": "any_value" });

      verify(client.post(url, headers: {
        'content-type': 'application/json',
        'accept': 'application/json'
        }, body: '{"any_key":"any_value"}'));
    });
  });
}