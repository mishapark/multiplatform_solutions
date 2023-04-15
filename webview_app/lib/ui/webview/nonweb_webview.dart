import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebView extends StatelessWidget {
  final String link;
  final controller = WebViewController();

  WebView({super.key, required this.link});

  @override
  Widget build(BuildContext context) {
    controller.setJavaScriptMode(JavaScriptMode.unrestricted);
    controller.loadRequest(Uri.parse(link));

    return WebViewWidget(
      controller: controller,
    );
  }
}
