
abstract class HTTPClient {
  Future<Map> request({String url, String method, Map body});
}