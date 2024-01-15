import 'package:agri_shop/farm_screens/home2/Hire/catload.dart';
import 'package:flutter/material.dart';

class HireScreen extends StatelessWidget {
  final List<Map<String, dynamic>> categories = [
    {
      'name': 'Machines',
      'imagePath': 'assets/images/land.png',
      'category': 'machines', // Firestore collection name for land items
    },

    // Add more categories with their names, image paths, and Firestore collection names
  ];

  HireScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF4FAF4),
      body: GridView.builder(
        itemCount: categories.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 10.0,
          mainAxisSpacing: 10.0,
        ),
        itemBuilder: (BuildContext context, int index) {
          return Padding(
            padding: const EdgeInsets.only(
              top: 8.0,
            ),
            child: GestureDetector(
              onTap: () {
                // Navigate to a screen displaying items from the selected category
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => CategoryItemsScreen(
                      category: categories[index]['category'],
                    ),
                  ),
                );
              },
              child: Card(
                elevation: 5,
                shadowColor: Colors.green,
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(15),
                    topRight: Radius.circular(15),
                  ),
                ),
                child: Stack(
                  alignment: Alignment.bottomLeft,
                  children: <Widget>[
                    ClipRRect(
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(15),
                        topRight: Radius.circular(15),
                      ),
                      child: Image.asset(
                        categories[index]['imagePath'],
                        height: double.infinity,
                        width: double.infinity,
                        fit: BoxFit.fill,
                      ),
                    ),
                    Container(
                      width: double.infinity,
                      height: 50,
                      decoration: BoxDecoration(
                        color: Colors.grey.withOpacity(0.7),

                        // boxShadow: [
                        //   BoxShadow(
                        //     color: Colors.black.withOpacity(0.3), // Shadow color
                        //     spreadRadius: 2, // Shadow spread radius
                        //     blurRadius: 4, // Shadow blur radius
                        //     offset: Offset(0, -4), // Shadow offset)
                        //   ),
                        // ],
                        // borderRadius: const BorderRadius.only(
                        //   bottomLeft: Radius.circular(30),
                        //   bottomRight: Radius.circular(30),
                        // ),
                      ),
                    ),
                    Positioned(
                      bottom: 10,
                      left: 10,
                      child: Text(
                        categories[index]['name'],
                        style: const TextStyle(
                          color: Colors.black87,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
