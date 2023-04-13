import 'webview/mock_webview.dart'
    if (dart.library.io) 'webview/nonweb_webview.dart'
    if (dart.library.html) 'webview/web_webview.dart';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:io';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final TextEditingController urlFieldController = TextEditingController();
  bool isLoading = false;
  bool isEntered = false;
  String _htmlTitle = 'Site Title';
  String _htmlCors = 'CORS Header:';
  String _htmlText = '';

  void _loadHtmlPage() async {
    setState(() {
      isLoading = true;
    });

    try {
      final result = await http.get(Uri.parse(urlFieldController.text));

      int titleIndex = result.body.indexOf('<title>');
      if (titleIndex < 0) {
        _htmlTitle = '';
      } else {
        _htmlTitle = result.body
            .substring(titleIndex + 7, result.body.indexOf('</title>'))
            .trim();
      }
      _htmlCors = result.headers['access-control-allow-origin'] ?? "None";
      _htmlText = result.body;
    } catch (e) {
      _htmlTitle = 'Site Title';
      _htmlCors = 'CORS Header:';
      _htmlText = 'Wrong website';
    }

    setState(() {
      isLoading = false;
      isEntered = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(20),
            child: Text(
              _htmlTitle,
              style: const TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 20, bottom: 20, right: 20),
            child: Text(
              _htmlCors,
              style: const TextStyle(
                color: Colors.red,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Expanded(
            child: isLoading
                ? const Center(child: CircularProgressIndicator())
                :
                // SingleChildScrollView(
                //     scrollDirection: Axis.vertical,
                //     child: Text(_htmlText),
                //   ),
                Container(
                    child: isEntered ? webView(urlFieldController.text) : null,
                  ),
          ),
          Container(
            decoration: const BoxDecoration(
              border: Border(
                top: BorderSide(width: 1),
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Center(
                child: Column(
                  children: [
                    Row(
                      children: [
                        Expanded(
                          flex: 1,
                          child: TextField(
                            controller: urlFieldController,
                            decoration: const InputDecoration(
                              contentPadding: EdgeInsets.symmetric(
                                vertical: 10,
                                horizontal: 10,
                              ),
                              border: OutlineInputBorder(),
                              labelText: 'URL',
                              hintText: 'Enter URL',
                            ),
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.only(left: 15),
                          child: OutlinedButton(
                            style: OutlinedButton.styleFrom(
                                backgroundColor: Colors.blue,
                                foregroundColor: Colors.white,
                                fixedSize: const Size(80, 47)),
                            onPressed: _loadHtmlPage,
                            child: const Text('LOAD'),
                          ),
                        ),
                      ],
                    ),
                    Container(
                      margin: const EdgeInsets.only(top: 15),
                      child: Text(
                        kIsWeb
                            ? 'Application running on: web'.toUpperCase()
                            : 'Application running on: ${Platform.operatingSystem}'
                                .toUpperCase(),
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
