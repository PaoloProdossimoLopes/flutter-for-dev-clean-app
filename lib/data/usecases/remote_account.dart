import 'package:ForDev/data/http/http_error.dart';
import 'package:ForDev/domain/entities/account.dart';
import 'package:flutter/cupertino.dart';

class RemoteAccount {
  final String accessToken;

  RemoteAccount(@required this.accessToken);

  factory RemoteAccount.from_json(Map json) {
    const token_key = 'accessToken';
    if (!json.containsKey(token_key)) {
      throw HTTPError.invalid_data;
    }
    return RemoteAccount(json[token_key]);
  }

  Account to_domain_account() => Account(accessToken);
}