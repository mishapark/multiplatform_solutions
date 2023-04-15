import 'package:webview_app/business/model.dart';
import 'package:webview_app/data/web_data.dart';

class WebService {
  final data = WebData();

  WebService();

  Future<WebModel> getData(String url) async {
    String title;
    String cors;
    String html;

    final result = await data.getWebData(url);

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
  }
}
