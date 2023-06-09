import 'dart:convert';

import 'package:apiprojects/Screens/FakeTodosList.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class FakeProductsList extends StatefulWidget {
  const FakeProductsList({Key? key}) : super(key: key);

  @override
  State<FakeProductsList> createState() => _FakeProductsListState();
}

class _FakeProductsListState extends State<FakeProductsList> {
  Future<List>? alldata;
  Future<List> getdata() async {
    Uri url = Uri.parse("https://api.escuelajs.co/api/v1/products");
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
        title: Text("Fake Products"),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => FakeTodosList(),
                ));
              },
              icon: Icon(Icons.add)),
        ],
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
                  return ListTile(
                    leading: Image.network(
                        snapshot.data![index]["images"][0].toString()),
                    title: Text(snapshot.data![index]["title"].toString()),
                    subtitle:
                        Text("Rs." + snapshot.data![index]["price"].toString()),
                    trailing: Text(
                        snapshot.data![index]["category"]["name"].toString()),
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
