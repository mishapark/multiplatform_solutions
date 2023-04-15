import 'package:http/http.dart' as http;

class WebData {
  Future<http.Response> getWebData(String url) async {
    http.Response result;
    try {
      result = await http.get(Uri.parse(url));
    } catch (e) {
      result = await http.get(Uri.parse('https://flutter.dev'));
    }
    return result;
  }
}
