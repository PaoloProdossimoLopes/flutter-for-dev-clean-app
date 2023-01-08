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

  PostExpectation mock_request() => when(client.request(url: anyNamed('url'), method: anyNamed('method'), body: anyNamed('body')));
  
  mock_request_with_data(Map json) {
    mock_request().thenAnswer((realInvocation) async => json);
  }

  mock_request_with_error(HTTPError error) {
    mock_request().thenThrow(error);
  }


  setUp(() {
    client = HTTPClientSpy();
    url = faker.internet.httpUrl();
    sut = RemoteAuthentication(client: client, url: url);
    params =  AuthParams(email: faker.internet.email(), secret: faker.internet.password());
  });

  test('should call http client with correct values', () async {
    mock_request_with_data({ 'accessToken': faker.guid.guid() });
    const method = 'POST';
    final body = { 'email': params. email, 'password': params.secret };

    await sut.auth(params);
    
    verify(client.request(url: url, method: method, body: body));
  });

  test('should throws unexpected error if HTTPClient returns 400 status code', () {
    mock_request_with_error(HTTPError.bad);

    final future = sut.auth(params);

    expect(future, throwsA(DomainError.unexpected));
  });

  test('should throw unexpected error if HTTPClient returns 404 status code ', () {
    mock_request_with_error(HTTPError.not_found);

    final future = sut.auth(params);

    expect(future, throwsA(DomainError.unexpected));
  });

  test('should throws an unexpected error when HTTPClient returns 500 status code', () {
    mock_request_with_error(HTTPError.internal_server);

    final future = sut.auth(params);

    expect(future, throwsA(DomainError.unexpected));
  });

  test('auth method when client returns unauthorized error delievers invalid credentials domain erorr', () {
    mock_request_with_error(HTTPError.unauthorized);

    final future = sut.auth(params);

    expect(future, throwsA(DomainError.invalid_credentials));
  });

  test('auth method when returns succeded data delievers account model with correct token', () async {
    final token = faker.guid.guid();
     mock_request_with_data({ 'accessToken': token });

    final account = await sut.auth(params);

    expect(account.token, token);
  });

  test('auth method on client respond with invalid json content should deliever unexpected error', () {
    mock_request_with_data({ 'invalid_key': 'invalid_value' });
    final future = sut.auth(params);
    expect(future, throwsA(DomainError.unexpected));
  });
}

class HTTPClientSpy extends Mock implements HTTPClient { }