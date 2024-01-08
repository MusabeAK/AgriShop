import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../product.dart';
import 'package:get/get.dart';
import 'package:agri_shop/crops.dart';

class ProductCard extends StatefulWidget {
  const ProductCard(int counter, {super.key});
  @override
  State<ProductCard> createState() => _ProductCardState();
}

class _ProductCardState extends State<ProductCard> {
  bool isHovered = false;

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    var counter = 1;
    return GestureDetector(
      onTap: () {
        Get.to(() => const Product());
      },
      child: MouseRegion(
        onEnter: (_) {
          setState(() {
            isHovered = true;
          });
        },
        onExit: (_) {
          setState(() {
            isHovered = false;
          });
        },
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            color:
                isHovered ? const Color(0xFFE7FCE7) : const Color(0xFFEEF0EE),
          ),
          width: 0.4 * screenWidth,
          height: 0.3 * screenHeight,
          padding: const EdgeInsets.all(10),
          margin: const EdgeInsets.only(
            left: 20,
            top: 20,
            right: 10,
            bottom: 10,
          ),
          child: Column(
            children: [
              Image(
                image: const AssetImage(
                    'assets/images/crops_ui.jpg'), // Adjust the path accordingly
                width: 0.4 * screenWidth, // Set the width as needed
                height: 0.2 * screenHeight,
                fit: BoxFit.contain,
              ),
              const SizedBox(
                height: 15,
              ),
              Row(
                children: [
                  const Expanded(
                    child: Column(
                      children: [
                        Text(
                          "Green Pepper",
                          style: TextStyle(
                            color: Colors.black87,
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.left,
                        ),
                        Text(
                          "\$12.00",
                          style: TextStyle(
                            color: Colors.red,
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.left,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  SizedBox(
                    height: 30,
                    width: 30,
                    child: FloatingActionButton(
                      onPressed: () {
                        Get.to(() => const Crops());
                      },
                      heroTag: "hero tag $counter",
                      tooltip: 'Add to cart',
                      hoverColor: Colors.black26,
                      foregroundColor: Colors.white,
                      backgroundColor: Colors.green,
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(
                            Radius.circular(15.0)), // Set the border radius
                      ),
                      child: const Icon(
                        Icons.add,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
