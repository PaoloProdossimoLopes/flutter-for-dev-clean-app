import 'dart:io';

import 'package:ForDev/domain/entities/account.dart';
import 'package:ForDev/domain/usecases/authentication.dart';
import 'package:faker/faker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';


class RemoteAuthentication {
  final HTTPClient client;
  final String url;

  RemoteAuthentication({
    @required this.client,
    @required this.url
  });
  
  Future<void> auth(AuthParams params) async {
    final body = {
      'email': params.email,
      'password': params.secret
    };
    await client.request(url: url, method: "POST", body: body);
  }
}

abstract class HTTPClient {
  Future<void> request({String url, String method, Map body});
}

void main() {
  
  String url;
  HTTPClientSpy client;
  RemoteAuthentication sut;

  setUp(() {
    client = HTTPClientSpy();
    url = faker.internet.httpUrl();
    sut = RemoteAuthentication(client: client, url: url);
  });

  test('should call http client with correct values (url and method)', () async {
    const method = 'POST';
    final params = AuthParams(email: faker.internet.email(), secret: faker.internet.password());
    await sut.auth(params);
    verify(client.request(
      url: url, 
      method: method, 
      body: {
      'email':params. email,
      'password': params.secret 
      }));
  });
}

class HTTPClientSpy extends Mock implements HTTPClient {

}