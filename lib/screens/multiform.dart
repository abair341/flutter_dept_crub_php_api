import 'dart:convert';

import 'package:crud_dept_project/model_classes/all_dept_lists_class.dart';
import 'package:crud_dept_project/screens/all_dept_insert.dart';
import 'package:flutter/material.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:http/http.dart' as http;

class MultiForm extends StatefulWidget {
  @override
  _MultiFormState createState() => _MultiFormState();
}

class _MultiFormState extends State<MultiForm> {
  List<alldeptinsert> forms = [];
  ProgressDialog _progressDialog;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    onAddForm();
  }

  @override
  Widget build(BuildContext context) {
    _progressDialog = new ProgressDialog(context);
    

    return Scaffold(
      appBar: AppBar(
        title: Text("Multiple Form"),
        actions: <Widget>[
          FlatButton(
            child: Text('Save'),
            textColor: Colors.white,
            onPressed: onSaveFormList,
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: onAddForm,
        foregroundColor: Colors.white,
      ),
      body: ListView.builder(
          addAutomaticKeepAlives: true,
          itemCount: forms.length,
          itemBuilder: (context, index) {
            return forms[index];
          }),
    );
  }

  void onAddForm() {
    setState(() {
      var _user = Alldeptlistclass();

      forms.add(alldeptinsert(
        onDelete: () => onDelete(_user),
        user: _user,
      ));
    });
  }

  void onDelete(Alldeptlistclass _user) {
    setState(() {
      var find = forms.firstWhere(
        (element) => element.user == _user,
        orElse: () => null,
      );

      if (find != null) {
        forms.removeAt(forms.indexOf(find));
      }
    });
  }

  void onSaveFormList() {
    _progressDialog.show();

    if (forms.length > 0) {
      var isAllValid = true;
      forms.forEach((form) {
        if (!form.isValid()) {
          print('3');
          isAllValid = false;
        }

        if (isAllValid) {
          var data = forms.map((form) => form.user).toList();

          print(data);

          insertDeptListAll(data);
        }
      });
    }
    setState(() {
      Future.delayed(Duration(seconds: 3), () {
        _progressDialog.hide();
      });
    });
  }

  insertDeptListAll(List<Alldeptlistclass> deptList) async {
    final response = await http.post(
        "http://abair-net.preview-domain.com/db_dept_entry_json_c.php",
        body: {
          "action": 'db_dpt_entry_json',
          "php_deptname": jsonEncode(deptList)
        });

    if (response.statusCode == 200 && response.body != 'fail') {
      print('ok done');
      print(response.body);
    } else {
      print('Error Occurr');
      print(response.body);
    }
  }
}
