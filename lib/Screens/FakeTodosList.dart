import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;


class FakeTodosList extends StatefulWidget {
  const FakeTodosList({Key? key}) : super(key: key);

  @override
  State<FakeTodosList> createState() => _FakeTodosListState();
}

class _FakeTodosListState extends State<FakeTodosList> {
  Future<List>? alldata;
  Future<List> getdata() async {
    Uri url = Uri.parse("https://jsonplaceholder.typicode.com/todos/");
    var response = await http.get(url);
    //200 ok
    //400 not found
    //500 server error
    if (response.statusCode == 200) {
      // var body = response.body.toString(); -->
      // var json = jsonDecode(body); --> a 2 or 1 |
      var json = jsonDecode(response.body.toString());
      return json;
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
      alldata = getdata();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Fake Todos"),
      ),
      body: FutureBuilder(
        future: alldata,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            if (snapshot.data!.length == 0) {
              return Center(
                child: Text("No Data"),
              );
            } else {
              return ListView.builder(
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) {
                  return (snapshot.data![index]["completed"].toString() ==
                          "false")
                      ? Card(
                          color: Colors.red,
                          child: ListTile(
                              title: Text(
                                  snapshot.data![index]["title"].toString(),
                                  style: TextStyle(
                                      fontSize: 15, color: Colors.white)),
                              subtitle: Text(
                                  snapshot.data![index]["completed"].toString(),
                                  style: TextStyle(
                                      fontSize: 15, color: Colors.white))),
                        )
                      : Card(
                          color: Colors.green,
                          child: ListTile(
                              title: Text(
                                  snapshot.data![index]["title"].toString(),
                                  style: TextStyle(
                                      fontSize: 15, color: Colors.white)),
                              subtitle: Text(
                                  snapshot.data![index]["completed"].toString(),
                                  style: TextStyle(
                                      fontSize: 15, color: Colors.white))),
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
      ),
    );
  }
}
