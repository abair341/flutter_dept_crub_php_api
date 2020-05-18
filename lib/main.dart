import 'package:crud_dept_project/screens/all_dept_lists.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Department Crud',
      theme: ThemeData(      
        primarySwatch: Colors.red,
      ),
      home: alldeptlists(),
      routes: {},
    );
  }
}

