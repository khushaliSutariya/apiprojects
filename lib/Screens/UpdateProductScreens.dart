import 'dart:convert';

import 'package:apiprojects/Screens/ViewProductScreens.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;


class UpdateProductScreens extends StatefulWidget {
  var updateid = "";
  UpdateProductScreens({required this.updateid});
  @override
  State<UpdateProductScreens> createState() => _UpdateProductScreensState();
}

class _UpdateProductScreensState extends State<UpdateProductScreens> {
  TextEditingController _pname = TextEditingController();
  TextEditingController _pquntity = TextEditingController();
  TextEditingController _pprise = TextEditingController();


  getsinglerecord() async
  {
    Uri url= Uri.parse("http://picsyapps.com/studentapi/getSingleProduct.php");
    var params = {
      "pid":widget.updateid
    };
    var response = await http.post(url,body: params);
    if(response.statusCode==200)
      {
        var json = jsonDecode(response.body.toString());
        if(json["status"]=="true")
          {
            _pname.text = json["data"]["pname"].toString();
            _pquntity.text = json["data"]["qty"].toString();
            _pprise.text = json["data"]["price"].toString();
          }
      }
  }


  @override
  void initState() {
    super.initState();
    getsinglerecord();
  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
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
                    
                    Uri url= Uri.parse("http://picsyapps.com/studentapi/updateProductNormal.php");
                    var params = {
                      "pname":name,
                      "qty":qty,
                      "price":price,
                      "pid":widget.updateid
                    };
                    var response = await http.post(url,body: params);
                    if(response.statusCode==200)
                    {
                      var json = jsonDecode(response.body.toString());
                      if(json["status"]=="true")
                      {
                          Navigator.of(context).pop(); //update
                          Navigator.of(context).pop(); //view
                          Navigator.of(context).push(
                            MaterialPageRoute(builder: (context)=> ViewProductScreens())
                          );
                      }
                    }


                  }, child: Text("Update")),
                )
              ],
            ),
          ),
        ),

      ),
    );
  }
}
