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
    await client.request(url: url, method: "POST", body: params.to_json());
  }
}

