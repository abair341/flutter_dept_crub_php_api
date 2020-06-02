import 'package:crud_dept_project/model_classes/all_dept_lists_class.dart';
import 'package:crud_dept_project/screens/all_dept_insert.dart';
import 'package:flutter/material.dart';

class MultiForm extends StatefulWidget {
  @override
  _MultiFormState createState() => _MultiFormState();
}

class _MultiFormState extends State<MultiForm> {
  List<alldeptinsert> forms = [];

  @override
  Widget build(BuildContext context) {
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
    if (forms.length > 0) {
      var isAllValid = true;
      forms.forEach((form) {
        if (!form.isValid()) {
          isAllValid = false;
        }

        if (isAllValid) {
          var data = forms.map((form) => form.user).toList();

          print(data);
        }
      });
    }
  }
}
