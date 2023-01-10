import 'dart:convert';

import 'package:ForDev/domain/helpers/domain_error.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart';

class HTTPAdapter {
  final Client client;

  HTTPAdapter(this.client);

  Future<Map> request({@required String url, @required String method, Map body}) async {

    const headers = {
      'content-type': 'application/json',
      'accept': 'application/json'
    };

    final bodyIfNedded = body != null ? jsonEncode(body) : null;
    final response = await client.post(url, headers: headers, body: bodyIfNedded);

    if (response.statusCode == 400) {
        throw DomainError.bad_request;
    }

    return _handle_response(response);
  }

  Map _handle_response(Response response) {
    if (response.statusCode == 204 || response.body.isEmpty) {
      return null;
    }

    return jsonDecode(response.body);
  }
}
