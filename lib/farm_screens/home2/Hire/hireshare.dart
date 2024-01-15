import 'package:agri_shop/farm_screens/home2/Hire/hire_screen.dart';
import 'package:agri_shop/farm_screens/home2/Hire/share_screen.dart';
import 'package:flutter/material.dart';

class SilverBar extends StatefulWidget {
  const SilverBar({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _SilverBarState createState() => _SilverBarState();
}

class _SilverBarState extends State<SilverBar> {
  final PageController _pageController = PageController(initialPage: 1);
  int _currentIndex = 1;

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(70.0), // Adjust the height here
        child: AppBar(
          backgroundColor: const Color(0xFFE7FCE7),
          automaticallyImplyLeading: false,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              GestureDetector(
                onTap: () {
                  _pageController.animateToPage(
                    1,
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.easeInOut,
                  );
                },
                child: Column(
                  children: [
                    const Icon(Icons.cloud, size: 24), // Reduce icon size here
                    const Text('Hire',
                        style:
                            TextStyle(fontSize: 14)), // Reduce font size here
                    Container(
                      height: 2,
                      width: 30, // Adjust the width of the underline
                      color: _currentIndex == 1
                          ? Colors.black87
                          : Colors.transparent,
                    ),
                  ],
                ),
              ),
              GestureDetector(
                onTap: () {
                  _pageController.animateToPage(
                    2,
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.easeInOut,
                  );
                },
                child: Column(
                  children: [
                    const Icon(Icons.share, size: 24), // Reduce icon size here
                    const Text('Share',
                        style:
                            TextStyle(fontSize: 14)), // Reduce font size here
                    Container(
                      height: 2,
                      width: 30, // Adjust the width of the underline
                      color: _currentIndex == 2
                          ? Colors.black87
                          : Colors.transparent,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      body: PageView(
        controller: _pageController,
        onPageChanged: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        children: [
          const Center(child: Text('')), // Your main screen
          HireScreen(), // Your HireScreen
          ShareScreen(), // Your ShareScreen
        ],
      ),
    );
  }
}
