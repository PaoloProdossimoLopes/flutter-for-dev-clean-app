import 'package:ForDev/data/http/http_client.dart';
import 'package:ForDev/domain/usecases/authentication.dart';
import 'package:flutter/cupertino.dart';

class RemoteAuthentication {
  final HTTPClient client;
  final String url;

  RemoteAuthentication({
    @required this.client,
    @required this.url
  });
  
  Future<void> auth(AuthParams params) async {
    final body = RemoteAuthParams.from_domain(params).to_json();
    await client.request(url: url, method: "POST", body: body);
  }
}

class RemoteAuthParams {
  final String email;
  final String passwod;

  RemoteAuthParams(
    @required this.email,
    @required this.passwod
  );

  factory RemoteAuthParams.from_domain(AuthParams params) {
    return RemoteAuthParams(params.email, params.secret);
  }

   Map to_json() => {
    'email': email,
    'password': passwod
  };
}