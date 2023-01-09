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

  Future<Map> request({
    @required String url,
    @required String method,
    Map body
  }) async {
    const headers =  {
      'content-type': 'application/json',
      'accept': 'application/json'
    };
    final bodyIfNedded = body != null ? jsonEncode(body) : null;
    final response = await client.post(url, headers: headers, body: bodyIfNedded);
    return jsonDecode(response.body);
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

  mock_post_with_data() {
    when(client.post(url, headers: anyNamed('headers'), body: anyNamed('body')))
          .thenAnswer((_) async => Response('{"any_key":"any_value"}', 200));
  }

  group('POST', () {
    test('should call post with correct values', () async {
      mock_post_with_data();
      
      sut.request(url: url, method: "POST");

      verify(client.post(url, headers: {
        'content-type': 'application/json',
        'accept': 'application/json'
        }));
    });

    test('should call post with no body', () async {
      mock_post_with_data();
      
      sut.request(url: url, method: "POST");

      verify(client.post(url, headers: {
        'content-type': 'application/json',
        'accept': 'application/json'
        }, body: null));
    });

    test('should call post with body', () async {
      mock_post_with_data();

      sut.request(url: url, method: "POST", body: { "any_key": "any_value" });

      verify(client.post(url, headers: {
        'content-type': 'application/json',
        'accept': 'application/json'
      }, body: '{"any_key":"any_value"}'));
    });

    test('request return data if post returns 200', () async {
      mock_post_with_data();
      
      final response = await sut.request(url: url, method: 'POST');

      expect(response, { "any_key": "any_value" });
    });
  });
}