import 'package:ForDev/data/http/http_client.dart';
import 'package:ForDev/data/http/http_error.dart';
import 'package:ForDev/data/usecases/remote_authentication.dart';
import 'package:ForDev/domain/helpers/domain_error.dart';
import 'package:ForDev/domain/usecases/authentication.dart';
import 'package:faker/faker.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

void main() {
  
  String url;
  HTTPClientSpy client;
  RemoteAuthentication sut;
  AuthParams params;

  setUp(() {
    client = HTTPClientSpy();
    url = faker.internet.httpUrl();
    sut = RemoteAuthentication(client: client, url: url);
    params =  AuthParams(email: faker.internet.email(), secret: faker.internet.password());
  });

  test('should call http client with correct values', () async {
    when(client.request(url: anyNamed('url'), method: anyNamed('method'), body: anyNamed('body')))
    .thenAnswer((_) async => { 'accessToken': faker.guid.guid() });
    const method = 'POST';
    final body = {
      'email': params. email,
      'password': params.secret 
    };
    await sut.auth(params);
    verify(client.request(
      url: url, 
      method: method, 
      body: body
      ));
  });

  test('should throws unexpected error if HTTPClient returns 400 status code', () {
    when(
      client.request(
        url: anyNamed('url'), 
        method: anyNamed('method'), 
        body: anyNamed('body')
      )
    ).thenThrow(HTTPError.bad);

    final future = sut.auth(params);

    expect(future, throwsA(DomainError.unexpected));
  });

  test('should throw unexpected error if HTTPClient returns 404 status code ', () {
    when(
      client.request(
        url: anyNamed('url'), 
        method: anyNamed('method'), 
        body: anyNamed('body')
      )
    ).thenThrow(HTTPError.not_found);

    final future = sut.auth(params);

    expect(future, throwsA(DomainError.unexpected));
  });

  test('should throws an unexpected error when HTTPClient returns 500 status code', () {
    when(client.request(url: anyNamed('url'), method: anyNamed('method'), body: anyNamed('body')))
    .thenThrow(HTTPError.internal_server);

    final future = sut.auth(params);

    expect(future, throwsA(DomainError.unexpected));
  });

  test('auth method when client returns unauthorized error delievers invalid credentials domain erorr', () {
    when(client.request(url: anyNamed('url'), method: anyNamed('method'), body: anyNamed('body'))).thenThrow(HTTPError.unauthorized);

    final future = sut.auth(params);

    expect(future, throwsA(DomainError.invalid_credentials));
  });

  test('auth method when returns succeded data delievers account model with correct token', () async {
    final token = faker.guid.guid();
    when(client.request(url: anyNamed('url'), method: anyNamed('method'), body: anyNamed('body')))
    .thenAnswer((_) async => { 'accessToken': token });

    final account = await sut.auth(params);

    expect(account.token, token);
  });
}

class HTTPClientSpy extends Mock implements HTTPClient { }