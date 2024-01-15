import 'package:agri_shop/farm_screens/home2/Hire/holt.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:scroll_snap_list/scroll_snap_list.dart'; // Import the ScrollSnapList package

class CategoryItemsScreen extends StatefulWidget {
  final String category;

  const CategoryItemsScreen({Key? key, required this.category})
      : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _CategoryItemsScreenState createState() => _CategoryItemsScreenState();
}

class _CategoryItemsScreenState extends State<CategoryItemsScreen> {
  late Stream<QuerySnapshot> _stream;

  @override
  void initState() {
    super.initState();
    fetchImageUrls();
    _stream =
        FirebaseFirestore.instance.collection(widget.category).snapshots();
  }

  List<String> imageUrls = []; // List to store image URLs

  Future<void> fetchImageUrls() async {
    try {
      QuerySnapshot querySnapshot =
          await FirebaseFirestore.instance.collection(widget.category).get();

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
    return Scaffold(
      backgroundColor: const Color(0xFFF4FAF4),
      appBar: AppBar(
        title: Text(
          'Items in ${widget.category}',
          style: const TextStyle(
            color: Colors.black87,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: const Color(0xFFE7FCE7),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: _stream,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return const Center(child: Text('Error fetching data'));
          } else if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return const Center(child: Text('No items available'));
          }

          if (snapshot.connectionState == ConnectionState.waiting ||
              imageUrls.isEmpty) {
            return const Center(child: CircularProgressIndicator());
          }

          return ScrollSnapList(
            itemBuilder: (context, index) {
              final Map<String, dynamic> data =
                  snapshot.data!.docs[index].data() as Map<String, dynamic>;

              return GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ItemDetailsScreen(
                        itemData: {
                          'itemName': data['itemName'], // Add itemName
                          'hirePrice': data['hirePrice'], // Add hirePrice
                          'description': data['description'],
                        },
                        imageUrl: imageUrls[index],
                      ),
                    ),
                  );
                },
                child: _buildSnappingListItem(
                  imageUrl: imageUrls[index],
                  itemName: data['itemName'] ?? '',
                  hirePrice: (data['hirePrice'] ?? 0).toDouble(),
                ),
              );
            },
            itemCount: snapshot.data!.docs.length,
            itemSize: 300, // Adjust item size as needed
            onItemFocus: (index) {}, // Handle item focus if desired
            dynamicItemSize: true, // Allow for dynamic item sizes
            scrollDirection: Axis.vertical,
            background: const Color(0xFFE7FCE7),
            margin: const EdgeInsets.only(top: 0),
          );
        },
      ),
    );
  }

  Widget _buildSnappingListItem({
    required String imageUrl,
    required String itemName,
    required double hirePrice,
    // required VoidCallback onPressed,
  }) {
    return SizedBox(
      width: 150, // Adjust item width as needed
      height: 300,
      child: Card(
        margin: const EdgeInsets.only(left: 20, right: 20),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(30)),
        ),
        elevation: 12,
        child: ClipRRect(
          borderRadius: const BorderRadius.all(Radius.circular(30)),
          child: Stack(
            alignment: AlignmentDirectional.bottomCenter,
            children: [
              Image.network(
                imageUrl,
                fit: BoxFit.fill,
                width: double.infinity,
                height: double.infinity,
              ),
              Container(
                height: 100,
                width: double.infinity,
                color: const Color(0xFFE7FCE7).withOpacity(0.8),
              ),
              Positioned(
                bottom: 50,
                left: 30,
                child: Text(
                  itemName,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    color: Colors.black87,
                  ),
                ),
              ),
              Positioned(
                right: 30,
                bottom: 20,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '\$${hirePrice.toStringAsFixed(2)}', // Display price with 2 decimal places
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.red,
                          fontSize: 20,
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
