import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
class AppprodectScreen extends StatefulWidget {
  const AppprodectScreen({Key? key}) : super(key: key);

  @override
  State<AppprodectScreen> createState() => _AppprodectScreenState();
}

class _AppprodectScreenState extends State<AppprodectScreen> {
  TextEditingController _pname = TextEditingController();
  TextEditingController _pquntity = TextEditingController();
  TextEditingController _pprise = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Appprodect"),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                "Product Name",
                style: TextStyle(fontSize: 20.0),
              ),
              TextField(
                controller: _pname,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.text,
              ),
              SizedBox(
                height: 10.0,
              ),
              Text(
                "Product Quntity",
                style: TextStyle(fontSize: 20.0),
              ),
              TextField(
                controller: _pquntity,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.name,
              ),
              SizedBox(
                height: 10.0,
              ),
              Text(
                "Product Prise",
                style: TextStyle(fontSize: 20.0),
              ),
              TextField(
                controller: _pprise,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.name,
              ),
              SizedBox(
                height: 10.0,
              ),
              Center(
                child: ElevatedButton(onPressed: () async {


                  var name = _pname.text.toString();
                  var qty = _pquntity.text.toString();
                  var price = _pprise.text.toString();

                  Uri url = Uri.parse("http://picsyapps.com/studentapi/insertProductNormal.php");

                  var params={
                    "pname":name,
                    "qty":qty,
                    "price":price
                  };

                  var response =  await http.post(url,body: params);
                  if(response.statusCode==200)
                    {
                      var json = jsonDecode(response.body.toString());
                      if(json["status"]=="true")
                        {
                          print("Record Inserted");
                          _pname.text="";
                          _pquntity.text="";
                          _pprise.text="";
                        }
                      else
                        {
                          print("Error");
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
