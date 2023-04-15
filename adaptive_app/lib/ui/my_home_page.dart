import 'package:adaptive_app/data/data_service.dart';
import 'package:adaptive_app/data/user.dart';
import 'package:adaptive_app/ui/view/narrow_view.dart';
import 'package:adaptive_app/ui/view/wide_view.dart';
import 'package:flutter/material.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  DataService service = DataService();
  List<User> _usersList = [];

  @override
  void initState() {
    fetchData();
    super.initState();
  }

  void fetchData() async {
    final userList = await service.fetchFileFromAssets('assets/data.json');
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
