import 'package:flutter/material.dart';

class Alldeptlistclass {
  String deptId;
  String deptName;

  Alldeptlistclass({this.deptId, this.deptName});

  Alldeptlistclass.fromJson(Map<String, dynamic> json) {
    deptId = json['dept_id'];
    deptName = json['dept_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['dept_id'] = this.deptId;
    data['dept_name'] = this.deptName;
    return data;
  }
}