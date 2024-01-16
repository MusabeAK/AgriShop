import 'package:agri_shop/cards/product_card.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

class Animals extends StatelessWidget {
  const Animals({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: AnimalsWidget(),
    );
  }
}

class AnimalsWidget extends StatefulWidget {
  const AnimalsWidget({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _AnimalsWidgetState createState() => _AnimalsWidgetState();
}

class _AnimalsWidgetState extends State<AnimalsWidget> {
  late Stream<QuerySnapshot> _stream;

  @override
  void initState() {
    super.initState();
    fetchImageUrls();
    _stream = FirebaseFirestore.instance.collection('animals').snapshots();
  }

  List<String> imageUrls = []; // List to store image URLs

  Future<void> fetchImageUrls() async {
    try {
      QuerySnapshot querySnapshot =
          await FirebaseFirestore.instance.collection("animals").get();

      for (QueryDocumentSnapshot doc in querySnapshot.docs) {
        String imagePath =
            doc['imageUrl']; // Replace with your actual field name
        Reference ref = FirebaseStorage.instance.ref().child(imagePath);
        String url = await ref.getDownloadURL();
        setState(() {
          imageUrls.add(url);
        });
      }
    } catch (e) {
      print('Error fetching image URLs: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: StreamBuilder<QuerySnapshot>(
          stream: _stream,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return const Padding(
                padding: EdgeInsets.all(15.0),
                child: Center(
                    child: Text(
                  'Error fetching data!',
                  style: TextStyle(
                    color: Colors.red,
                    fontSize: 20,
                  ),
                )),
              );
            } else if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
              return Padding(
                padding: const EdgeInsets.all(15.0),
                child: Center(
                    child: Text(
                  'No items available',
                  style: TextStyle(
                      color: Colors.green.withOpacity(9), fontSize: 20),
                )),
              );
            }

            if (snapshot.connectionState == ConnectionState.waiting ||
                imageUrls.isEmpty) {
              return const Center(
                  child: CircularProgressIndicator(
                color: Colors.green,
              ));
            }

            return Column(
              children: [
                Wrap(
                  spacing: 5.0, // horizontal spacing between items
                  runSpacing: 5.0, // vertical spacing between lines
                  children: List.generate(
                    snapshot.data!.docs.length,
                    (index) {
                      final Map<String, dynamic> data =
                          snapshot.data!.docs[index].data()
                              as Map<String, dynamic>;
                      return ProductCard(
                        indexTrack: index,
                        imageUrl: imageUrls[index],
                        itemPrice: data['price'],
                        itemName: data['name'],
                        description: data['description'],
                      );
                    },
                  ),
                )
              ],
            );
          }),
    );
  }
}
