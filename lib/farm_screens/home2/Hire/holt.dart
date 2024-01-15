import 'package:flutter/material.dart';

class ItemDetailsScreen extends StatelessWidget {
  final Map<String, dynamic> itemData;
  final String imageUrl;

  const ItemDetailsScreen({
    required this.itemData,
    required this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black),
        title: Text(
          itemData['itemName'],
          style: const TextStyle(
            color: Colors.black,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Hero image with zoom animation
            Hero(
              tag: imageUrl,
              child: Image.network(
                imageUrl,
                fit: BoxFit.cover,
                width: double.infinity,
                height: 250,
              ),
            ),
            // Item details section
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Item name with larger font
                  Text(
                    itemData['itemName'],
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  // Description with spacing
                  const SizedBox(height: 10),
                  /*  Text(
                    itemData['description'] ?? '',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey[600],
                    ),
                  ),*/
                  // Key features with icons
                  const SizedBox(height: 15),
                  Row(
                    children: [
                      const SizedBox(width: 5),
                      Text(
                        itemData['description'],
                        style: const TextStyle(fontSize: 14),
                      ),
                    ],
                  ),
                  const SizedBox(height: 15),
                  // Price with bold accent
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '\$${itemData['hirePrice'].toStringAsFixed(2)}',
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      // Hire now button with prominent color
                      ElevatedButton(
                        onPressed: () {
                          // Implement hire functionality here
                          print('Hire button pressed!');
                        },
                        child: Text(
                          'Hire Now',
                          style: const TextStyle(
                            color: Colors.white,
                          ),
                        ),
                        style: ElevatedButton.styleFrom(
                          primary: Colors.green[500],
                          padding: const EdgeInsets.symmetric(
                            horizontal: 20,
                            vertical: 12,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
