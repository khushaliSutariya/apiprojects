import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'ProductsModel.dart';
class ProdectwithModelScreens extends StatefulWidget {
  const ProdectwithModelScreens({Key? key}) : super(key: key);

  @override
  State<ProdectwithModelScreens> createState() => _ProdectwithModelScreensState();
}

class _ProdectwithModelScreensState extends State<ProdectwithModelScreens> {
  List<Products>? allproducts;
  bool isloding = false;
  getproduct() async{
    setState(() {
      isloding = true;
    });
    Uri Url  = Uri.parse("http://picsyapps.com/studentapi/getProducts.php");
    var response = await http.get(Url);
    if(response.statusCode==200){
      var json = jsonDecode(response.body.toString());
      setState(() {
        allproducts = json["data"].map<Products>((obj)=>Products.fromJson(obj)).toList();
        isloding = false;
      });
    }
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getproduct();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("ProdectwithModel"),
      ),
       body: (isloding)?Center(child: CircularProgressIndicator(),):ListView.builder(
         itemCount: allproducts!.length,
         itemBuilder: (context, index) {
           return Card(
             child: Column(
               children: [
                 Text(allproducts![index].pname.toString()),
                 Text(allproducts![index].price.toString()),

               ],
             ),
           );

       },),
    );
  }
}
