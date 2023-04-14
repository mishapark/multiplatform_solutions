import 'dart:convert';

import 'package:adaptive_app/model/user.dart';
import 'package:adaptive_app/view/narrow_view.dart';
import 'package:adaptive_app/view/wide_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Adaptive App'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<User> _usersList = [];

  @override
  void initState() {
    fetchFileFromAssets('assets/data.json');
    super.initState();
  }

  void fetchFileFromAssets(String assetsPath) async {
    final decodedJson = await rootBundle
        .loadString(assetsPath)
        .then((jsonStr) => jsonDecode(jsonStr));
    final userList =
        decodedJson.map<User>((user) => User.fromJson(user)).toList();
    setState(() {
      _usersList = userList;
    });
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: screenWidth > 720
          ? null
          : AppBar(
              title: Text(widget.title),
            ),
      body: LayoutBuilder(builder: (context, constraints) {
        return constraints.maxWidth > 720
            ? WideView(usersList: _usersList)
            : NarrowView(usersList: _usersList);
      }),
    );
  }
}
