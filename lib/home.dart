import 'package:flutter/material.dart';

class MyHome extends StatelessWidget {
  const MyHome({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: DefaultTabController(
        length: 3, // Number of tabs
        child: Scaffold(
          appBar: AppBar(
            title: const Text('My App'),
            bottom: const TabBar(
              tabs: [
                Tab(text: 'Tab 1'),
                Tab(text: 'Tab 2'),
                Tab(text: 'Tab 3'),
              ],
            ),
          ),
          body: const TabBarView(
            children: [
              // Content of Tab 1
              Center(child: Text('Tab 1 Content')),

              // Content of Tab 2
              Center(child: Text('Tab 2 Content')),

              // Content of Tab 3
              Center(child: Text('Tab 3 Content')),
            ],
          ),
        ),
      ),
    );
  }
}