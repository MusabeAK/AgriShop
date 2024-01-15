import 'package:agri_shop/home_index.dart';
import 'package:curved_labeled_navigation_bar/curved_navigation_bar.dart';
import 'package:curved_labeled_navigation_bar/curved_navigation_bar_item.dart';
import 'package:flutter/material.dart';
import 'package:agri_shop/farm_screens/home2/Groups/group_screen.dart';
import 'package:agri_shop/farm_screens/home2/Sales/sales_screen.dart';
import 'package:agri_shop/farm_screens/home2/Weather/weather_screen.dart';
import 'package:agri_shop/farm_screens/home2/Hire/hireshare.dart';
import 'package:get/get.dart';

class BottomNavigation extends StatefulWidget {
  const BottomNavigation({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _BottomNavigationState createState() => _BottomNavigationState();
}

class _BottomNavigationState extends State<BottomNavigation> {
  int _currentIndex = 0;

  // Define your pages/screens here
  final List<Widget> _pages = [
    const HomeIndex(),
    const SilverBar(),
    const WeatherScreen(),
    const GroupScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        // backgroundColor: Colors.transparent,
        body: _pages[_currentIndex],
        bottomNavigationBar: CurvedNavigationBar(
          height: 50.0,
          index: _currentIndex,
          color: const Color(0xFFE7FCE7),
          buttonBackgroundColor: Colors.green,
          backgroundColor: Colors.white,
          onTap: (index) {
            setState(() {
              _currentIndex = index;
            });
          },
          items: [
            CurvedNavigationBarItem(
              child: Icon(
                Icons.home,
                color: _currentIndex == 0 ? Colors.white : Colors.green,
                size: 20,
              ),
            ),
            CurvedNavigationBarItem(
              child: Icon(
                Icons.newspaper,
                color: _currentIndex == 1 ? Colors.white : Colors.green,
                size: 20,
              ),
            ),
            CurvedNavigationBarItem(
              child: Icon(
                Icons.cloud,
                color: _currentIndex == 2 ? Colors.white : Colors.green,
                size: 20,
              ),
            ),
            CurvedNavigationBarItem(
              child: Icon(
                Icons.groups,
                color: _currentIndex == 3 ? Colors.white : Colors.green,
                size: 20,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
