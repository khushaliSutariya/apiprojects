import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'EmployeeModel.dart';
class EmployeewithModelScreens extends StatefulWidget {
  const EmployeewithModelScreens({Key? key}) : super(key: key);

  @override
  State<EmployeewithModelScreens> createState() => _EmployeewithModelScreensState();
}

class _EmployeewithModelScreensState extends State<EmployeewithModelScreens> {
  List<Employee>? allemployeedata;
  getemployee() async{
    Uri Url = Uri.parse("http://picsyapps.com/studentapi/getEmployee.php");
    var response = await http.get(Url);
    if(response.statusCode==200){
      var json = jsonDecode(response.body.toString());
      setState(() {
        allemployeedata = json["data"].map<Employee>((obj)=>Employee.fromJson(obj)).toList();
      });
    }
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getemployee();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("EmployeewithModel"),
      ),
      body: ListView.builder(
        itemBuilder: (context, index) {
          return Card(
            child: Column(
              children: [
                Text(allemployeedata![index].ename.toString()),
                Text(allemployeedata![index].salary.toString()),

              ],
            ),
          );
        
      },),
    );
  }
}
