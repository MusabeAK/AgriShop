import 'package:flutter/material.dart';
import 'crops.dart';
import 'package:get/get.dart';

class Product extends StatelessWidget {
  const Product({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      extendBody: true,
      body: ProductWidget(),
    );
  }
}

class ProductWidget extends StatefulWidget {
  const ProductWidget({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _CropsWidgetState createState() => _CropsWidgetState();
}

class _CropsWidgetState extends State<ProductWidget> {
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return SingleChildScrollView(
      child: Container(
        margin: const EdgeInsets.only(
          top: 30,
          bottom: 10,
          left: 0,
          right: 0,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Stack(
              children: [
                ClipPath(
                  clipper: BottomCurveClipper(),
                  child: Image(
                    fit: BoxFit.fill,
                    image: const AssetImage(
                        'assets/images/crops_ui.jpg'), // Adjust the path accordingly
                    width: screenWidth, // Set the width as needed
                    height: 0.4 * screenHeight, // Set the height as needed
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 15, top: 0),
                  child: AppBar(
                    leading: SizedBox(
                      // height: 40,
                      // width: 40,
                      child: FloatingActionButton(
                        heroTag: "back",
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        backgroundColor: Colors.white,
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(30),
                          ),
                        ),
                        child: const Icon(
                          Icons.arrow_back,
                          color: Colors.black54,
                          size: 30,
                        ),
                      ),
                    ),
                    backgroundColor: Colors
                        .transparent, // Set background color to transparent
                    elevation: 0,
                    primary: true,
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Container(
              margin: const EdgeInsets.only(
                left: 20,
                right: 20,
              ),
              child: Row(
                children: [
                  const Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Green Pepper",
                          style: TextStyle(
                            color: Colors.black87,
                            fontWeight: FontWeight.bold,
                            fontSize: 25,
                          ),
                          textAlign: TextAlign.left,
                        ),
                        Text(
                          "\$12.00",
                          style: TextStyle(
                            color: Colors.red,
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          ),
                          textAlign: TextAlign.start,
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
                      heroTag: "cart",
                      onPressed: () {},
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
            ),
            const Padding(
              padding: EdgeInsets.only(left: 20.0, right: 20),
              child: Text(
                """adipisicing elit. Aliquam qui alias reprehenderit sint aliquid, itaque porro sapiente rem reiciendis facere? Ducimus provident minima quibusdam, ipsa expedita minus?""",
                style: TextStyle(
                  color: Colors.black54,
                ),
                textAlign: TextAlign.left,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Wrap(
              spacing: 5.0, // horizontal spacing between items
              runSpacing: 5.0, // vertical spacing between lines
              children: List.generate(
                4,
                (index) => Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: const Color(0xFFEEF0EE),
                  ),
                  width: 0.4 * screenWidth,
                  height: 0.1 * screenHeight,
                  padding: const EdgeInsets.all(10),
                  margin: const EdgeInsets.only(
                    left: 10,
                    top: 10,
                    right: 10,
                    bottom: 10,
                  ),
                  child: const Row(
                    children: [
                      Icon(
                        Icons.star_rate_outlined,
                        size: 35,
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Column(
                        children: [
                          Text("MTN"),
                          SizedBox(
                            height: 10,
                          ),
                          Text("MoMo Pay"),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Container(
              margin: const EdgeInsets.only(
                left: 20,
                right: 20,
              ),
              child: SizedBox(
                width: double.infinity,
                child: FloatingActionButton(
                  heroTag: "cart_prod",
                  onPressed: () {},
                  tooltip: 'Add to cart',
                  hoverColor: Colors.black26,
                  foregroundColor: Colors.white,
                  backgroundColor: Colors.green,
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(
                        Radius.circular(30.0)), // Set the border radius
                  ),
                  child: const Text(
                    'Add to Cart',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class BottomCurveClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    double curveHeight = 40.0;
    Path path = Path()
      ..moveTo(0.0, 0.0) // Top-left corner
      ..lineTo(size.width, 0.0) // Top-right corner
      ..lineTo(size.width, size.height - curveHeight) // Bottom-right corner
      ..quadraticBezierTo(
          size.width / 2, size.height, 0.0, size.height - curveHeight) // Curve
      ..close(); // Connects the last point with the starting point to form a closed shape
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return false;
  }
}
