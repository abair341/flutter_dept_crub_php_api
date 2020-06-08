import 'dart:convert';

import 'package:crud_dept_project/configss/dilaogs.dart';
import 'package:crud_dept_project/configss/logger.dart';
import 'package:crud_dept_project/model_classes/all_dept_lists_class.dart';
import 'package:crud_dept_project/screens/multiform.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:logger/logger.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'all_dept_insert.dart';

class alldeptlists extends StatefulWidget {
  @override
  _alldeptlistsState createState() {
    return _alldeptlistsState();
  }
}

class _alldeptlistsState extends State<alldeptlists> {
  Logger log = getLogger("alldeptlists");

  GlobalKey<RefreshIndicatorState> refershKey;

  Future<List<Alldeptlistclass>> _getDeptListAll() async {
    final response = await http
        .get("http://abair.gq/db_dept_info_all.php");

    if (response.statusCode == 200) {
      List parsed = jsonDecode(response.body);

      log.i(parsed.length);

      return parsed.map((emp) => Alldeptlistclass.fromJson(emp)).toList();
    }
  }

  refershListNew() {
    setState(() {
      _getDeptListAll();
    });
  }

  Future<Null> refershList() async {
    await Future.delayed(Duration(seconds: 1));
    refershListNew();
    return null;
  }

  @override
  void initState() {
    _getDeptListAll();
    refershKey = GlobalKey<RefreshIndicatorState>();
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
                child: RefreshIndicator(
                  key: refershKey,
                  onRefresh: () async{
                      await refershList();
                  },
                  child: FutureBuilder(
                    future: _getDeptListAll(),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        return ListView.builder(
                          itemCount: snapshot.data.length,
                          itemBuilder: (context, index) {
                            return row(
                                context,
                                index,
                                "snapshot.data[index]",
                                snapshot.data[index].deptName,
                                snapshot.data[index].deptId);
                          },
                        );
                      } else {
                        return Center(child: CircularProgressIndicator());
                      }
                    },
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget row(
      context, index, String listName, String deptNameNew, String deptIdNew) {
    return Dismissible(
      background: Container(color: Colors.red),
      key: Key(listName),
      confirmDismiss: (DismissDirection direction) async {
        final action = await Dilaogs.yesAbortDialog(
            context, "Delete Alert", "You want to delete?");
        print(action);
        if (action == DialogAction.yes) {
          _deleteDept(deptIdNew, deptNameNew);
         
        } else {
          setState(() {
            _getDeptListAll();
          });
        }
      },
      // onDismissed: (direction) async {
      //   final action = await Dilaogs.yesAbortDialog(
      //       context, "Delete Alert", "You want to delete?");
      //   print(action);
      // },
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: <Widget>[
              Expanded(
                child: Text(
                  deptNameNew,
                  style: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              IconButton(icon: Icon(Icons.edit), onPressed: () {}),
              IconButton(
                icon: Icon(Icons.delete),
                onPressed: () async {
                  final action = await Dilaogs.yesAbortDialog(
                      context, "Delete Alert", "You want to delete?");
                  print(action);
                },
                color: Color(0xff800000),
              ),
            ],
          ),
        ),
      ),
    );
  }

  _deleteDept(String passDeptNo, String passDeptName) async {
    print(passDeptNo);
    print(passDeptName);

    final response = await http
        .post("http://abair.gq/db_dept_delete.php", body: {
      "action": 'db_dpt_delete',
      "php_deptname": passDeptName,
      "php_deptid": passDeptNo
    });

    if (response.statusCode == 200 && response.body != 'fail') {
      print(response.body);
       setState(() {
            _getDeptListAll();
          });
    } else {
      print('Error Occurr');
      print(response.body);
    }
  }
}
