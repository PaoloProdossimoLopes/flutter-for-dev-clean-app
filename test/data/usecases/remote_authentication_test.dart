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
  
  Future<void> auth() async {
    await client.request(url: url, method: "POST");
  }
}

abstract class HTTPClient {
  Future<void> request({String url, String method});
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
    await sut.auth();
    verify(client.request(url: url, method: method));
  });
}

class HTTPClientSpy extends Mock implements HTTPClient {

}