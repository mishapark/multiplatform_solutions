import 'package:webview_app/data/model.dart';
import 'package:webview_app/data/web_service.dart';

import 'webview/nonweb_webview.dart'
    if (dart.library.html) 'webview/web_webview.dart';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'dart:io';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late TextEditingController controller;
  late WebService service;
  WebModel model = WebModel(title: 'Title', cors: "CORS", html: 'Empty');
  bool isLoading = false;
  bool isValid = false;

  @override
  void initState() {
    super.initState();
    controller = TextEditingController();
    service = WebService();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  void _loadHtmlPage() async {
    setState(() {
      isLoading = true;
    });

    model = await service.getData(controller.text);
    isValid = await service.validateLink(controller.text);
    setState(() {
      isLoading = false;
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
              model.title,
              style: const TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 20, bottom: 20, right: 20),
            child: Text(
              model.cors,
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
                //     child: Text(model.html),
                //   ),
                isValid
                    ? WebView(link: controller.text)
                    : const Center(
                        child: Text('Wrong Site'),
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
                            controller: controller,
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
