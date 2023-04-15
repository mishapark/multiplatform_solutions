import 'package:http/http.dart' as http;
import 'package:webview_app/data/model.dart';

class WebService {
  Future<WebModel> getData(String url) async {
    String title;
    String cors;
    String html;

    try {
      if (url.trim() == '' || !url.trim().startsWith('https://')) {
        throw Exception('Wrong website');
      }

      final result = await http.get(Uri.parse(url));

      int titleIndex = result.body.indexOf('<title>');
      if (titleIndex < 0) {
        title = '';
      } else {
        title = result.body
            .substring(titleIndex + 7, result.body.indexOf('</title>'))
            .trim();
      }
      cors = result.headers['access-control-allow-origin'] ?? 'None';
      html = result.body;
      return WebModel(title: title, cors: cors, html: html);
    } catch (e) {
      return WebModel(
          title: e.toString(), cors: e.toString(), html: 'Wrong Site');
    }
  }

  Future<bool> validateLink(String link) async {
    try {
      if (link.trim() == '' || !link.trim().startsWith('https://')) {
        throw Exception('Wrong website');
      }
      await http.get(Uri.parse(link));
      return true;
    } catch (e) {
      return false;
    }
  }
}
