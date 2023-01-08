import 'package:ForDev/data/http/http_client.dart';
import 'package:ForDev/data/usecases/remote_authentication.dart';
import 'package:ForDev/domain/usecases/authentication.dart';
import 'package:faker/faker.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

void main() {
  
  String url;
  HTTPClientSpy client;
  RemoteAuthentication sut;

  setUp(() {
    client = HTTPClientSpy();
    url = faker.internet.httpUrl();
    sut = RemoteAuthentication(client: client, url: url);
  });

  test('should call http client with correct values', () async {
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

class HTTPClientSpy extends Mock implements HTTPClient { }