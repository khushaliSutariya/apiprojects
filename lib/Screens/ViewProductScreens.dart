import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'UpdateProductScreens.dart';

class ViewProductScreens extends StatefulWidget {
  const ViewProductScreens({Key? key}) : super(key: key);

  @override
  State<ViewProductScreens> createState() => _ViewProductScreensState();
}

class _ViewProductScreensState extends State<ViewProductScreens> {
  Future<List>? allproducts;
  Future<List> getdata() async {
    Uri url = Uri.parse("http://picsyapps.com/studentapi/getProducts.php");
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
          title: Text("View Products"),
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
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Name:-" +
                                          snapshot.data![index]["pname"]
                                              .toString(),
                                      style: TextStyle(fontSize: 20.0),
                                    ),
                                    Row(
                                      children: [
                                        Text("Rs." +
                                            snapshot.data![index]["price"]
                                                .toString()),
                                        SizedBox(
                                          width: 20.0,
                                        ),
                                        Text("qty:-" +
                                            snapshot.data![index]["qty"]
                                                .toString()),
                                      ],
                                    ),
                                  ],
                                ),
                                Text("Date:-" +
                                    snapshot.data![index]["added_datetime"]
                                        .toString()),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                ElevatedButton(
                                    onPressed: () {
                                      var id = snapshot.data![index]["pid"]
                                          .toString();
                                      Navigator.of(context)
                                          .push(MaterialPageRoute(
                                        builder: (context) =>
                                            UpdateProductScreens(updateid: id),
                                      ));
                                    },
                                    child: Text("Update")),
                                SizedBox(
                                  width: 10.0,
                                ),
                                ElevatedButton(
                                    onPressed: () {}, child: Text("Delete")),
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
