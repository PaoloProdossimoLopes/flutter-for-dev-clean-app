import 'package:faker/faker.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart';
import 'package:mockito/mockito.dart';

class ClientSpy extends Mock implements Client { }

class HTTPAdapter {

  final Client client;

  HTTPAdapter(this.client);

  Future<void> request({
    String url,
    String method
  }) async {
    client.post(url,  headers: {
        'content-type': 'application/json',
        'accept': 'application/json'
        });
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
  });
}