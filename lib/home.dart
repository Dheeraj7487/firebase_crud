import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_crud/writeData.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class myHome extends StatefulWidget {

  late String item, description, price;

  @override
  _myHomeState createState() => _myHomeState();
}

class _myHomeState extends State<myHome> {

  var itemController = TextEditingController();
  var desController = TextEditingController();
  var priceController = TextEditingController();
  late int itemId;


  @override
  Widget build(BuildContext context) {

    final CollectionReference _mainCollection = FirebaseFirestore.instance.collection('items');

    Future<void> addItem({required String item, required String description, required String price,}) async {
      DocumentReference documentReferencer = _mainCollection.doc(itemController.text);

      Map<String, dynamic> data = <String, dynamic>{
        "item": item.toString(),
        "description": description.toString(),
        "price": price.toString(),
      };
      await documentReferencer
          .set(data)
          .whenComplete(() => print("item added"))
          .catchError((e) => print(e));
      itemController.clear();
      priceController.clear();
      desController.clear();
    }

    final _formKey = GlobalKey<FormState>();

    return Scaffold(
      appBar: AppBar(
        title: Text("Home"),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Center(
                child: Container(
                  padding: EdgeInsets.only(top: 100,bottom: 50),
                  child: Text("Product Data",style: TextStyle(fontSize: 25,),),
                ),
              ),
              Container(
                padding: EdgeInsets.only(left: 20,right: 20,bottom: 30),
                child: TextFormField(
                  controller: itemController,
                  keyboardType: TextInputType.text,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'This field is required';
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    labelText: "Enter Item",
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                  ),
                ),
              ),

              Container(
                padding: EdgeInsets.only(left: 20,right: 20,bottom: 30),
                child: TextFormField(
                  controller: desController,
                  keyboardType: TextInputType.text,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'This field is required';
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    labelText: "Enter Description",
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                  ),
                ),
              ),

              Container(
                padding: EdgeInsets.only(left: 20,right: 20,bottom: 30),
                child: TextFormField(
                  controller: priceController,
                  maxLength: 5,
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'This field is required';
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    labelText: "Enter Price",
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                  ),
                ),
              ),

              RaisedButton(
                child: Text("Insert"),
                onPressed: (){
                  if(_formKey.currentState!.validate()) {
                    String item = itemController.text;
                    String description = desController.text;
                    String price = priceController.text;
                    addItem(item: item, description: description, price: price);
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => writeData()));
                  }
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
