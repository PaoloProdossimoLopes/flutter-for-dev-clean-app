import 'package:ForDev/domain/entities/account.dart';
import 'package:flutter/cupertino.dart';

class RemoteAccount {
  final String accessToken;

  RemoteAccount(@required this.accessToken);

  factory RemoteAccount.from_json(Map json) => RemoteAccount(json['accessToken']);

  Account to_domain_account() => Account(accessToken);
}