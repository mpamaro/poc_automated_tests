import 'package:http/http.dart' as http;

abstract class HttpRequest {
  static Future<bool> head(String url, [http.Client? client]) async {
    final localClient = client ?? http.Client();

    final response = await localClient.head(Uri.parse(url));

    return response.statusCode == 200;
  }
}
