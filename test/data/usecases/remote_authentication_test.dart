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
}

class HTTPClientSpy extends Mock implements HTTPClient { }