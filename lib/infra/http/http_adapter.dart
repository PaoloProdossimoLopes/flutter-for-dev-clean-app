import 'dart:convert';

import 'package:ForDev/data/http/http_error.dart';
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
    if (method == 'POST') {
        try {
            final response = await client.post(url, headers: headers, body: bodyIfNedded);
            return _handle_response(response);
        } on Exception {
            throw HTTPError.internal_server;
        }
    } else {
        throw HTTPError.internal_server;
    }
  }

  Map _handle_response(Response response) {
    if (response.statusCode == 204) {
      return null;
    } else if (response.statusCode == 400) {
        throw HTTPError.bad;
    } else if (response.statusCode == 401) {
        throw HTTPError.unauthorized;
    } else if (response.statusCode == 403) {
        throw HTTPError.forbiden;
    } else if (response.statusCode == 404) {
        throw HTTPError.not_found;
    } else if (response.statusCode == 500) {
        throw HTTPError.internal_server;
    }

    return jsonDecode(response.body);
  }
}
