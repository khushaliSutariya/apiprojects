import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ViewEmployeeScreens extends StatefulWidget {
  const ViewEmployeeScreens({Key? key}) : super(key: key);

  @override
  State<ViewEmployeeScreens> createState() => _ViewEmployeeScreensState();
}

class _ViewEmployeeScreensState extends State<ViewEmployeeScreens> {
  Future<List>? allproducts;
  Future<List> getdata() async {
    Uri url = Uri.parse("http://picsyapps.com/studentapi/getEmployee.php");
    var response = await http.get(url);
    if (response.statusCode == 200) {
      var body = response.body.toString();
      var json = jsonDecode(body);
      return json["data"];
    } else {
      print("Error");
      return [];
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {
      allproducts = getdata();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("View Employee"),
        ),
        body: FutureBuilder(
          future: allproducts,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              if (snapshot.data!.length == 0) {
                return Center(
                  child: Text("No Data Found"),
                );
              } else {
                return ListView.builder(
                  itemCount: snapshot.data!.length,
                  itemBuilder: (context, index) {
                    return Card(
                      color: Colors.lightGreen.shade100,
                      child: Container(
                        padding: EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Name:-" +
                                          snapshot.data![index]["ename"]
                                              .toString(),
                                      style: TextStyle(fontSize: 20.0),
                                    ),
                                    Text("Gender:-" +
                                        snapshot.data![index]["gender"]
                                            .toString()),
                                    Row(
                                      children: [
                                        Text("Salary." +
                                            snapshot.data![index]["salary"]
                                                .toString()),
                                        SizedBox(
                                          width: 20.0,
                                        ),
                                        Text("Department:-" +
                                            snapshot.data![index]["department"]
                                                .toString()),
                                      ],
                                    ),
                                  ],
                                ),
                                SizedBox(width: MediaQuery.of(context).size.width*0.1,),
                                Text("Date:-" +
                                    snapshot.data![index]["added_datetime"]
                                        .toString()),
                              ],
                            ),

                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                ElevatedButton(
                                    onPressed: () {}, child: Text("Update")),
                                SizedBox(
                                  width: 10.0,
                                ),
                                ElevatedButton(
                                    onPressed: () {
                                      showDialog(
                                          context: context,
                                          builder: (BuildContext context) {
                                        return AlertDialog(
                                          title: Text("View Products"),
                                          content: Text("Are you shore whant to delete"),
                                          actions: <Widget>[
                                            ElevatedButton(
                                              child: Text("Delete"),
                                              onPressed: ()  async{

                                                var eid = snapshot.data![index]["eid"].toString();


                                                Uri url = Uri.parse("http://picsyapps.com/studentapi/deleteEmployeeNormal.php");
                                                var params ={
                                                  "eid":eid
                                                };

                                                var response = await http.post(url,body: params);

                                                if(response.statusCode==200)
                                                  {
                                                    var json = jsonDecode(response.body.toString());
                                                    if(json["status"]=="true")
                                                      {
                                                        setState(() {
                                                          allproducts = getdata();
                                                        });
                                                      }
                                                    else
                                                      {
                                                        print("Not Deleted");
                                                      }
                                                  }
                                              },
                                            ),
                                            ElevatedButton(
                                              child: Text("Close"),
                                              onPressed: () {
                                                Navigator.of(context).pop();
                                              },
                                            ),
                                          ],
                                        );
                                      });
                                    }, child: Text("Delete")),
                              ],
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                );
              }
            } else {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
          },
        ));
  }
}
