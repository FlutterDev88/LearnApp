import 'package:http/http.dart' as http;

Map<String, String> baseHeaders = {'Content-Type': 'application/json'};

class HttpService {
  static Future<http.Response> get(
      String url,
      ) async {
    final response = await http.get(Uri.parse(url));
    return httpResponse(response);
  }

  static dynamic httpResponse(http.Response response) {
    switch (response.statusCode) {
      case 200:
        return response;
      default:
        return null;
    }
  }
}
