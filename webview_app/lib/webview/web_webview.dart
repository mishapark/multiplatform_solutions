import 'dart:html';
import 'dart:math';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';

Widget webView(String link) => WebWebview(link: link);

class WebWebview extends StatelessWidget {
  final String link;

  const WebWebview({super.key, required this.link});

  @override
  Widget build(BuildContext context) {
    final id = Random().nextInt.toString();
    ui.platformViewRegistry.registerViewFactory(
        id,
        (int viewId) => IFrameElement()
          ..src = link
          ..style.width = '100%'
          ..style.height = '100%');

    return HtmlElementView(viewType: id);
  }
}
