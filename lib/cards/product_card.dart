import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../product.dart';
import 'package:get/get.dart';
import 'package:agri_shop/crops.dart';

class ProductCard extends StatefulWidget {
  int indexTrack = 0;
  String imageUrl;
  String itemName;
  String itemPrice;
  ProductCard({
    super.key,
    required this.indexTrack,
    required this.imageUrl,
    required this.itemName,
    required this.itemPrice,
  });

  @override
  State<ProductCard> createState() {
    // indexTrack++;
    return _ProductCardState();
  }
}

class _ProductCardState extends State<ProductCard> {
  bool isHovered = false;

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

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
              Image.network(
                widget.imageUrl,
                width: 0.4 * screenWidth,
                height: 0.2 * screenHeight,
                fit: BoxFit.contain,
              ),
              const SizedBox(
                height: 15,
              ),
              Row(
                children: [
                  Expanded(
                    child: Column(
                      children: [
                        Text(
                          widget.itemName,
                          style: const TextStyle(
                            color: Colors.black87,
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.left,
                        ),
                        Text(
                          "\$${widget.itemPrice}",
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
                      onPressed: () {},
                      heroTag: "hero tag ${widget.indexTrack}",
                      tooltip: 'Add to cart',
                      hoverColor: Colors.black26,
                      foregroundColor: Colors.white,
                      backgroundColor: Colors.green,
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(15.0)),
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
