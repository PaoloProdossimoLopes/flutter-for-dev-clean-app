import 'package:ForDev/data/http/http_client.dart';
import 'package:ForDev/data/http/http_error.dart';
import 'package:ForDev/data/usecases/remote_account.dart';
import 'package:ForDev/domain/entities/account.dart';
import 'package:ForDev/domain/helpers/domain_error.dart';
import 'package:ForDev/domain/usecases/authentication.dart';
import 'package:flutter/cupertino.dart';

class RemoteAuthentication {
  final HTTPClient client;
  final String url;

  RemoteAuthentication({
    @required this.client,
    @required this.url
  });
  
  Future<Account> auth(AuthParams params) async {
    final body = RemoteAuthParams.from_domain(params).to_json();
    try {
      final response = await client.request(url: url, method: "POST", body: body);
      return RemoteAccount.from_json(response).to_domain_account();
    } on HTTPError catch(error) {
      final failure = (error == HTTPError.unauthorized) 
        ? DomainError.invalid_credentials 
        : DomainError.unexpected;
      throw failure;
    }
  }
}

class RemoteAuthParams {
  final String email;
  final String passwod;

  RemoteAuthParams(
    this.email,
    this.passwod
  );

  factory RemoteAuthParams.from_domain(AuthParams params) {
    return RemoteAuthParams(params.email, params.secret);
  }

   Map to_json() => {
    'email': email,
    'password': passwod
  };
}