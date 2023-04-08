import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
class AddEmployeeScreen extends StatefulWidget {
  const AddEmployeeScreen({Key? key}) : super(key: key);

  @override
  State<AddEmployeeScreen> createState() => _AddEmployeeScreenState();
}

class _AddEmployeeScreenState extends State<AddEmployeeScreen> {
  TextEditingController _ename = TextEditingController();
  TextEditingController _esalary = TextEditingController();
  var group = "M";
  var selected = "Sals";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add Employee"),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                "Employee Name",
                style: TextStyle(fontSize: 20.0),
              ),
              TextField(
                controller: _ename,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.text,
              ),
              SizedBox(
                height: 10.0,
              ),
              Text(
                "Employee Salary",
                style: TextStyle(fontSize: 20.0),
              ),
              TextField(
                controller: _esalary,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.name,
              ),
              SizedBox(
                height: 10.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text("Male",style: TextStyle(fontSize: 15.0),),
                  Radio(value: "M", groupValue: group, onChanged: (value) {
                    setState(() {
                      group=value!;
                    });
                  },),
                  Text("Female",style: TextStyle(fontSize: 15.0),),
                  Radio(value: "F", groupValue: group, onChanged: (value) {
                    setState(() {
                      group=value!;
                    });
                  },),
                ],
              ),
              Row(
                children: [
                  Text("Category: ",style: TextStyle(fontSize: 15.0),),
                  SizedBox(width: 10.0,),
                  DropdownButton(
                    value: selected,
                    items: [
                      DropdownMenuItem(
                        child: Text("Sals"),
                        value: "Sals",
                      ),
                      DropdownMenuItem(
                        child: Text("Account"),
                        value: "Account",
                      ),
                      DropdownMenuItem(
                        child: Text("Hr"),
                        value: "Hr",
                      ),
                      DropdownMenuItem(
                        child: Text("marketing"),
                        value: "marketing",
                      ),
                    ], onChanged: (value) {
                    setState(() {
                      selected=value!;
                    });
                  },)
                ],
              ),
              Center(
                child: ElevatedButton(onPressed: () async {


                  var name = _ename.text.toString();
                  var salary = _esalary.text.toString();
                  var type = group;
                  var category = selected;

                  Uri Url = Uri.parse("http://picsyapps.com/studentapi/insertEmployeeNormal.php");
                   var  params = {
                     "ename":name,
                     "salary":salary,
                     "department":category,
                     "gender":type,
                   };
                   var response = await http.post(Url,body: params);
                   if(response.statusCode==200){
                     var json = jsonDecode(response.body.toString());
                     if(json["status"]=="true"){
                       print("record Inserted");
                       _ename.text="";
                       _esalary.text="";
                       selected="";
                       group="";
                     }
                     else{
                       print("error");
                     }
                   }




                  }, child: Text("Add")),
              )
            ],
          ),
        ),
      ),
    );
  }
}
