import 'package:cloud_firestore/cloud_firestore.dart';

Future<List<String>> fetchDataFromFirestore() async {
  CollectionReference products =
      FirebaseFirestore.instance.collection('product');
  QuerySnapshot querySnapshot = await products.get();

  List<String> items = [];
  for (var doc in querySnapshot.docs) {
    items.add(doc['name'] as String);
    items.add(doc['unit_price'] as String);
    items.add(doc['unit_quantity'] as String);
  }
  return items;
}


/*
void addData() async {
  CollectionReference users = FirebaseFirestore.instance.collection('users');
  await users.add({'name': 'John Doe', 'age': 25});
}
*/