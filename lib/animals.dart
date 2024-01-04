import 'package:flutter/material.dart';
import 'product.dart';
import 'package:get/get.dart';

class Animals extends StatelessWidget {
  const Animals({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Animals Here"),
      ),
      body: const AnimalsWidget(),
    );
  }
}

class AnimalsWidget extends StatefulWidget {
  const AnimalsWidget({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _CropsWidgetState createState() => _CropsWidgetState();
}

class _CropsWidgetState extends State<AnimalsWidget> {
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return SingleChildScrollView(
      child: Column(
        children: [
          Wrap(
            spacing: 5.0, // horizontal spacing between items
            runSpacing: 5.0, // vertical spacing between lines
            children: List.generate(
              10,
              (index) => Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: const Color(0xFFEEF0EE),
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
                              Get.to(() => const Product());
                            },
                            heroTag: "hero tag $index",
                            tooltip: 'Add to cart',
                            hoverColor: Colors.black26,
                            foregroundColor: Colors.white,
                            backgroundColor: Colors.green,
                            shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.all(Radius.circular(
                                  15.0)), // Set the border radius
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
          ),
        ],
      ),
    );
  }
}
