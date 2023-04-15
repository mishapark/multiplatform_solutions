import 'dart:html';
import 'dart:math';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';

class WebView extends StatelessWidget {
  final String link;

  const WebView({
    super.key,
    required this.link,
  });

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
