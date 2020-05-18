import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:crud_dept_project/configss/logger.dart';
import 'package:logger/logger.dart';

class alldeptinsert extends StatefulWidget {
  @override
  _alldeptinsertState createState() => _alldeptinsertState();
}

class _alldeptinsertState extends State<alldeptinsert> {
  Logger log = getLogger("alldeptinsert");
  TextEditingController deptnameController = TextEditingController();

  Future _insertDeptAll() async {
    /*String insert_user = 
                 urlEncode.encode("dept_name", "UTF-8") + "=" + urlEncode.encode( deptnameController.text , "UTF-8") +
           "&" + urlEncode.encode("ACTION", "UTF-8") + "=" + urlEncode.encode("db_dept_entry_json", "UTF-8") 
                            ; 
                            */

    /*var loginObj = new Map<String, dynamic>();
    loginObj['ACTION'] = "db_dpt_entry_json";
    loginObj['php_deptname'] =
        '[{"dept_id":"7","dept_name":"1"},{"dept_id":"8","dept_name":"2"}]';
        */

    /*Map<String, dynamic> body = {'ACTION': 'db_dpt_entry_json', 
    'php_deptname':  '[{"dept_id":"7","dept_name":"1"},{"dept_id":"8","dept_name":"2"}]'};
      */

    final response = await http.post(
        "https://unlabelled-argument.000webhostapp.com/db_dept_entry_json.php",
        body: 
         {
          'ACTION': 'db_dpt_entry_json',
          'php_deptname' : '[{"dept_id":"7","dept_name":"1"},{"dept_id":"8","dept_name":"2"}]'
          }
        );
    log.i(response.statusCode);
    log.i(response.body);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.teal,
      appBar: AppBar(
        title: Text("Department Entry"),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              TextFormField(
                controller: deptnameController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                  fillColor: Colors.white,
                  filled: true,
                  labelText: 'Department Name',
                  labelStyle: TextStyle(
                    color: Colors.green,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(
                height: 3.0,
              ),
              Row(
                children: <Widget>[
                  Expanded(
                    child: RaisedButton(
                      shape: StadiumBorder(),
                      onPressed: () => _insertDeptAll(),
                      child: Text(
                        'Save',
                        style: TextStyle(
                          color: Color(0xff800000),
                          fontWeight: FontWeight.bold,
                          fontSize: 20.0,
                        ),
                      ),
                      elevation: 3,
                      color: Colors.white,
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
