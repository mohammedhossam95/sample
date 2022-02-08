abstract class ApiConsumer {
  Future<dynamic> get(String url, {Map<String, String> headers});

  Future<dynamic> post(String url, {body, Map<String, String> headers});
}
