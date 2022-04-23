import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

import 'fire_crud.dart';

class writeData extends StatefulWidget {

  @override
  _writeDataState createState() => _writeDataState();
}

class _writeDataState extends State<writeData> {


  @override
  void initState() {
    super.initState();
    refresList();
    // firebaseData.deleteData(proItem);
  }

  refresList(){
    setState(() {
      getData();
    });
  }
  var proItem;
  var priceController = TextEditingController();
  var desController = TextEditingController();

  List<dynamic> itemData = [];
    getData(){
     setState(() {
       dataFetch = true;
     });
    FirebaseFirestore.instance.collection("items").get().then((querySnapshot) {
      querySnapshot.docs.forEach((result) {
        print(result.data());
        setState(() {
          itemData.add(result.data());
        });
      });
      // print(itemData[1]['item']);
    });
     setState(() {
       dataFetch = false;
     });
  }

  // Future<void> deleteItem({
  //   required String docId,
  // }) async {
  //   DocumentReference documentReferencer = FirebaseFirestore.instance.collection('items').doc(docId);
  //
  //   await documentReferencer
  //       .delete()
  //       .whenComplete(() => print('item deleted'))
  //       .catchError((e) => print(e));
  // }

  FirebaseData firebaseData = FirebaseData();
  bool dataFetch = false;

  // deleteData(proItem) async{
  //   await FirebaseFirestore.instance.collection('items').doc(proItem).delete();
  // }

  @override
  Widget build(BuildContext context) {


    // if(dataFetch == itemData.isEmpty){
    //   return CircularProgressIndicator();
    // }
    // else{
    //  return getData();
    // }
    //
    // // deleteData(docId) {
    // //   FirebaseFirestore.instance
    // //       .collection('items')
    // //       .doc(docId)
    // //       .delete()
    // //       .catchError((e) {
    // //     print(e);
    // //   });
    // // }

    return Scaffold(
      appBar : AppBar(
        title: Text("Display Data"),
      ),
      body: SingleChildScrollView(
        child:
        dataFetch == true ?
            Center(child: CircularProgressIndicator(),)
            :
        Column(
          children: [
            Row(
              children: [
                Container(
                  padding: EdgeInsets.only(right: 10,bottom: 20),
                  child: Text("sr no.", style: TextStyle(fontSize: 20),),
                ),
                Container(
                  padding: EdgeInsets.only(right: 50,left: 20,bottom: 20),
                  child: Center(child: Text("Product Data", style: TextStyle(fontSize: 20),)),
                ),
                Container(
                  padding: EdgeInsets.only(right: 40,bottom: 20),
                  child: Text("Edit", style: TextStyle(fontSize: 20),),
                ),
                Container(
                  padding: EdgeInsets.only(bottom: 20),
                  child: Text("Delete", style: TextStyle(fontSize: 20),),
                ),
              ],
            ),

            itemData.isEmpty ? Padding(
              padding: const EdgeInsets.symmetric(horizontal: 150.0,vertical: 300),
                child: Text("No Data"),
            ) :
            ListView.builder(
                itemCount: itemData.length,
                shrinkWrap: true,
                scrollDirection : Axis.vertical,
                itemBuilder:(BuildContext context,int index){
                  return Card(
                    child: Column(
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            //for(int i=0;i<itemData.length;i++)
                              Container(
                                padding: EdgeInsets.only(left: 20,right: 50),
                                child: Center(child: Text('${index +1}')),
                              ),
                            Center(
                              child:  Container(
                                width: 140,
                                padding: EdgeInsets.only(right: 30,top: 10),
                                child:    Text("${itemData[index]["item"]} \n ${itemData[index]["description"]} \n ${itemData[index]["price"]}"),
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.only(left: 10,top: 10),
                              child: IconButton(onPressed: (){
                                var item,description,price;
                                item = itemData[index]["item"];
                                description = itemData[index]["description"];
                                price = itemData[index]["price"];
                                updateform(item, description, price);

                                // Navigator.push(context, MaterialPageRoute(builder: (context)=>update()));

                              }, icon: Icon(Icons.edit),),
                            ),
                            Container(
                              padding: EdgeInsets.only(left: 30,top: 10),
                              child: IconButton(onPressed: () async {
                                proItem = itemData[index]["item"];
                                firebaseData.deleteData(proItem);

                                setState(() {
                                  itemData.clear();
                                  refresList();
                                });
                                // deleteData(proItem);
                                // var proItem = "66GyHFCOc5tTxFYwjo4N";
                                // deleteItem(docId: proItem);
                              }, icon: Icon(Icons.delete),),
                            ),
                          ],
                        ),
                      ],
                    ),
                  );
                }),
    //         FutureBuilder(
    //           // future:  FirebaseDatabase.instance.reference().child("items").once(),
    //           //future: getData(),
    //           builder: (BuildContext context , snapshot){
    //             if(snapshot.connectionState == ConnectionState.done){
    //               return Text("data");
    //              // final itemData = snapshot.data.value;
    //              //  return ListView.builder(
    //              //    // children: snapshot.data.docs.map((doc) {
    //              //    //   return Card(
    //              //    //     child: ListTile(
    //              //    //       title: Text(doc.data()['items']),
    //              //    //     ),
    //              //    //   );
    //              //    // }).toList(),
    //              //
    //              //    itemCount: itemData.length,
    //              //    itemBuilder: (BuildContext context, index)=>
    //              //        Container(
    //              //          child:  Column(
    //              //            children: [
    //              //              // Text(itemData.children.toList()[index].child('price').value),
    //              //              Container(child: Text("${itemData[index]['item']}")),
    //              //               Container(child: Text(itemData[index]['price']))
    //              //
    //              //            ],
    //              //          ),
    //              //        ),
    //              //  );
    //             }
    //             else{
    //               return CircularProgressIndicator();
    //               //return const Center(child: Text('did not found data'),);
    //         }
    //
    //       },
    // ),
      ]
    ),
    )
    );
  }

  updateform(itemName,description,price){
    print("item= ${itemName}");
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: new Text("Update Item Data"),
          actions: <Widget>[
            TextFormField(
              controller: desController,
              keyboardType: TextInputType.text,
              decoration: InputDecoration(labelText: "Description"),
            ),
            TextFormField(
              maxLength: 15,
              controller: priceController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(labelText: "Price"),
            ),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  padding: EdgeInsets.only(left: 20,right: 20),
                  child: new RaisedButton(
                    child: new Text("OK"),
                    onPressed: () {
                      updateItem(itemName);
                      itemData.clear();
                      Navigator.of(context).pop();
                      setState(() {
                        refresList();
                      });
                    },
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(left: 20,right: 20),
                  child: new RaisedButton(
                    child: new Text("Cancel"),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                )
              ],
            ),
          ],
        );
      },
    );
  }

  Future<dynamic> updateItem(itemNameID) async {
    String productId = itemNameID;
      final CollectionReference _mainCollection = FirebaseFirestore.instance.collection('items');
      DocumentReference documentReferencer = _mainCollection.doc(productId);

      Map<String, dynamic> data = <String, dynamic>{
        "item": productId,
        "description": desController.text,
        "price" : priceController.text,
      };
      print(priceController.text);

      await documentReferencer
          .update(data)
          .whenComplete(() => print("item updated"))
          .catchError((e) => print(e));
    }
  }