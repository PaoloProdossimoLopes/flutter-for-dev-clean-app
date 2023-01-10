import 'dart:convert';

import 'package:ForDev/data/http/http_error.dart';
import 'package:ForDev/domain/helpers/domain_error.dart';
import 'package:ForDev/infra/http/status_code.dart';
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
    final status = StatusCodeHelper.statusCode(response.statusCode);

    switch (status) {
        case StatusCode.ok: 
            return jsonDecode(response.body);
        case StatusCode.noContentError:
            return null;
        case StatusCode.badRequestError:
            throw HTTPError.bad;
        case StatusCode.unauthorizedError:
            throw HTTPError.unauthorized;
        case StatusCode.forbidenError:
            throw HTTPError.forbiden;
        case StatusCode.notFoundError:
            throw HTTPError.not_found;
        default:
            throw HTTPError.internal_server;
    }
  }
}
