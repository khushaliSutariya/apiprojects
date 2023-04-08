import 'package:flutter/material.dart';

import '../Model/EmployeewithModelScreens.dart';
import '../Model/ProdectwithModelScreens.dart';
import 'AddEmployeeScreens.dart';
import 'AppprodectScreen.dart';
import 'FakeProductsList.dart';
import 'ViewEmployeeScreens.dart';
import 'ViewProductScreens.dart';

class Homepage extends StatefulWidget {
  const Homepage({Key? key}) : super(key: key);

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Api Calling"),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [Center(child: Text("No Data Found"))]
      ),
      drawer: Drawer(
        child: ListView(
          padding:  EdgeInsets.only(top: 35.0, left: 20.0),
          children: [
            ListTile(
              title:  Text('Add Product'),
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => AppprodectScreen(),
                ));
              },
            ),
            ListTile(
              title:  Text('View Product'),
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => ViewProductScreens(),
                ));
              },
            ),
            ListTile(
              title:  Text('Add Employee'),
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => AddEmployeeScreen(),
                ));
              },
            ),
            ListTile(
              title:  Text('View Employee'),
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => ViewEmployeeScreens(),
                ));
              },
            ),
            ListTile(
              title:  Text('Fake Products'),
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => FakeProductsList(),
                ));
              },
            ),
            ListTile(
              title:  Text('Fake Products With Model Class'),
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => ProdectwithModelScreens(),
                ));
              },
            ),
            ListTile(
              title:  Text('Fake Employee With Model Class'),
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => EmployeewithModelScreens(),
                ));
              },
            ),

          ],
        ),
      ),
    );
  }
}
