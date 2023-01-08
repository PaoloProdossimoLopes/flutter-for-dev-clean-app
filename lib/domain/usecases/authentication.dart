import 'package:flutter/cupertino.dart';

import '../entities/entities.dart';

class AuthParams {
  final String email;
  final String secret;

  AuthParams({
    @required this.email,
    @required this.secret
  });

  Map to_json() => {
    'email': email,
    'password': secret
  };
}

abstract class Authentication {
  Future<Account> auth(AuthParams params);
}