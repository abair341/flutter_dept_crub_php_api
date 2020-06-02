import 'dart:convert';

import 'package:crud_dept_project/model_classes/all_dept_lists_class.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:crud_dept_project/configss/logger.dart';
import 'package:logger/logger.dart';
import 'package:fluttertoast/fluttertoast.dart';

class alldeptinsert extends StatefulWidget {

  final Alldeptlistclass user;
  final state = _alldeptinsertState();
  final Function onDelete;

  alldeptinsert({Key key, this.user, this.onDelete}) : super(key: key);

  @override
  _alldeptinsertState createState() => state;


  bool isValid() => state.validate();
}

class _alldeptinsertState extends State<alldeptinsert> {
  Logger log = getLogger("alldeptinsert");
  final form = GlobalKey<FormState>();


  TextEditingController _deptController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(16.0),
      child: Material(
        elevation: 1,
        borderRadius: BorderRadius.circular(8),
        clipBehavior: Clip.antiAlias,
        child: Form(
          key: form,
          child: Column(
            children: <Widget>[
              AppBar(
                leading: Icon(Icons.verified_user),
                title: Text("Department Info"),
                actions: <Widget>[
                  IconButton(
                    icon: Icon(Icons.delete),
                    onPressed:  widget.onDelete,
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Enter Department Name',
                    hintText: 'Enter Department Name',
                    icon: Icon(Icons.text_fields),
                    isDense: true,
                  ),
                  controller: _deptController,
                   onSaved: (val) {
                      widget.user.deptName = val;
                    },
                  validator: (val) =>
                        val.length > 3 ? null : 'Department name is invalid',
                        maxLength: 100,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
  bool validate() {
    var valid = form.currentState.validate();
    if (valid) form.currentState.save();
    return valid;
  }
}
