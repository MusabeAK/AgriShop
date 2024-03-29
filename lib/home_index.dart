import 'package:agri_shop/all_products.dart';
import 'package:flutter/material.dart';
import 'crops.dart'; //
import 'animals.dart';

class HomeIndex extends StatefulWidget {
  const HomeIndex({super.key});

  @override
  State<HomeIndex> createState() => _HomeIndexState();
}

class _HomeIndexState extends State<HomeIndex> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: const Color(0xFFE7FCE7),
            leading: const Icon(Icons.local_florist),
            title: RichText(
              text: const TextSpan(
                text: 'Agri',
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 25.0,
                ),
                children: [
                  TextSpan(
                    text: 'Shop',
                    style: TextStyle(
                      color: Colors.green,
                      fontWeight: FontWeight.bold,
                      fontSize: 25.0,
                    ),
                  ),
                ],
              ),
            ),
            actions: [
              IconButton(
                icon: const Icon(Icons.person),
                onPressed: () {},
              ),
            ],
            bottom: const TabBar(
              indicatorColor: Colors.green,
              indicatorSize: TabBarIndicatorSize.tab,
              indicatorWeight: 4.0,
              labelStyle: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.black,
                // fontSize: 15,
              ),
              tabs: [
                // Tab(text: 'All'),
                Tab(text: 'Crops'),
                Tab(text: 'Animals'),
              ],
            ),
          ),
          body: const TabBarView(
            children: [
              // AllProducts(),
              Crops(),
              Animals(),
            ],
          ),
        ),
      ),
    );
  }
}
