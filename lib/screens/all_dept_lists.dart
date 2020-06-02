import 'dart:convert';

import 'package:crud_dept_project/configss/logger.dart';
import 'package:crud_dept_project/model_classes/all_dept_lists_class.dart';
import 'package:crud_dept_project/screens/multiform.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:logger/logger.dart';

import 'all_dept_insert.dart';

class alldeptlists extends StatefulWidget {
  @override
  _alldeptlistsState createState() {
    return _alldeptlistsState();
  }
}

class _alldeptlistsState extends State<alldeptlists> {
  Logger log = getLogger("alldeptlists");

  Future<List<Alldeptlistclass>> _getDeptListAll() async {
    final response = await http
        .get("http://abair-com.preview-domain.com/db_dept_info_all.php");

    if (response.statusCode == 200) {
      List parsed = jsonDecode(response.body);

      log.i(parsed.length);

      return parsed.map((emp) => Alldeptlistclass.fromJson(emp)).toList();
    }
  }

  @override
  void initState() {
    _getDeptListAll();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => MultiForm()),
          );
        },
        child: Icon(Icons.add),
      ),
      backgroundColor: Colors.teal,
      appBar: AppBar(
        title: Text("Department Crud"),
        actions: <Widget>[
          Padding(
            padding: const EdgeInsets.only(right: 10.0),
            child: IconButton(
              icon: Icon(
                Icons.refresh,
                color: Colors.white,
                size: 40.0,
              ),
              onPressed: () {
               setState(() {
                _getDeptListAll(); 
               }); 
              },
            ),
          )
        ],
      ),
      body: SafeArea(
        child: Column(
          children: <Widget>[
            Expanded(
                flex: 1,
                child: Container(
                  color: Color(0xffC0C0C0),
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        child: Text(
                          "Department Info",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontStyle: FontStyle.italic,
                            fontSize: 20.0,
                            color: Color(0xff800000),
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ],
                  ),
                )),
            Expanded(
              flex: 8,
              child: Container(
                child: FutureBuilder(
                  future: _getDeptListAll(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return ListView.builder(
                        itemCount: snapshot.data.length,
                        itemBuilder: (context, index) {
                          return Card(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                children: <Widget>[
                                  Expanded(
                                    child: Text(
                                      "${snapshot.data[index].deptName}",
                                      style: TextStyle(
                                        fontSize: 18.0,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                  IconButton(
                                      icon: Icon(Icons.edit), onPressed: () {}),
                                  IconButton(
                                    icon: Icon(Icons.delete),
                                    onPressed: () {},
                                    color: Color(0xff800000),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      );
                    } else {
                      return Center(child: CircularProgressIndicator());
                    }
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
