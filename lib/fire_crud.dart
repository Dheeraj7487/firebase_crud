import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

class FirebaseData{
  var desController = TextEditingController();
  var priceController = TextEditingController();


  Future deleteData(proItem) async{
    await FirebaseFirestore.instance.collection('items').doc(proItem).delete();
  }

  // Future<dynamic> updateItem(itemNameID) async {
  //   String productId = itemNameID;
  //   final CollectionReference _mainCollection = FirebaseFirestore.instance.collection('items');
  //   DocumentReference documentReferencer = _mainCollection.doc(productId);
  //
  //   Map<String, dynamic> data = <String, dynamic>{
  //     "item": productId,
  //     "description": desController.text,
  //     "price" : priceController.text,
  //   };
  //   print(priceController.text);
  //
  //   await documentReferencer
  //       .update(data)
  //       .whenComplete(() => print("item updated"))
  //       .catchError((e) => print(e));
  // }
}


