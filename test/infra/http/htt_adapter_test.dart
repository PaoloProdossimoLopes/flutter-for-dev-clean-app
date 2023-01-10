import 'dart:convert';

import 'package:ForDev/domain/helpers/domain_error.dart';
import 'package:ForDev/infra/http/http_adapter.dart';
import 'package:faker/faker.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart';
import 'package:mockito/mockito.dart';

class ClientSpy extends Mock implements Client {}

void main() {
  ClientSpy client;
  HTTPAdapter sut;
  String url;

  setUp(() {
    client = ClientSpy();
    sut = HTTPAdapter(client);
    url = faker.internet.httpUrl();
  });

  mock_post_with(int statusCode, String response) {
    when(client.post(url, headers: anyNamed('headers'), body: anyNamed('body')))
        .thenAnswer((_) async => Response(response, statusCode));
  }

  group('POST', () {
    test('should call post with correct values', () async {
      mock_post_with(200, '{"any_key":"any_value"}');

      sut.request(url: url, method: "POST");

      verify(client.post(url, headers: {
        'content-type': 'application/json',
        'accept': 'application/json'
      }));
    });

    test('should call post with no body', () async {
      mock_post_with(200, '{"any_key":"any_value"}');

      sut.request(url: url, method: "POST");

      verify(client.post(url,
          headers: {
            'content-type': 'application/json',
            'accept': 'application/json'
          },
          body: null));
    });

    test('should call post with body', () async {
      mock_post_with(200, '{"any_key":"any_value"}');

      sut.request(url: url, method: "POST", body: {"any_key": "any_value"});

      verify(client.post(url,
          headers: {
            'content-type': 'application/json',
            'accept': 'application/json'
          },
          body: '{"any_key":"any_value"}'));
    });

    test('request return data if post returns 200', () async {
      mock_post_with(200, '{"any_key":"any_value"}');

      final response = await sut.request(url: url, method: 'POST');

      expect(response, {"any_key": "any_value"});
    });

    test('request deleivers no resposne with 204 with no datas', () async {
      mock_post_with(204, '');

      final response = await sut.request(url: url, method: 'POST');

      expect(response, null);
    });

    test('request deleivers no resposnes with status code with 204 with data',
        () async {
      mock_post_with(204, '{"any_key":"any_value"}');

      final response = await sut.request(url: url, method: 'POST');

      expect(response, null);
    });

    test('request returns `BadRequest` error if client delievers 400 statusCode with body', () async {
      mock_post_with(400, '{"any_key":"any_value"}');
      final failure = sut.request(url: url, method: 'POST');
      expect(failure, throwsA(DomainError.bad_request));
    });

    test('request returns `BadRequest` error if client delievers 400 statusCode withut body', () async {
      mock_post_with(400, '');
      final failure = sut.request(url: url, method: 'POST');
      expect(failure, throwsA(DomainError.bad_request));
    });
  });
}
