
abstract class HTTPClient {
  Future<void> request({String url, String method, Map body});
}