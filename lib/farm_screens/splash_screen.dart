import 'dart:async';
import 'package:agri_shop/farm_screens/bottom_navigation.dart';
import 'package:flutter/material.dart';
import 'package:agri_shop/farm_screens/signin_screen.dart'; // Import your sign-in screen file
// import 'package:agri_shop/farm_screens/home_screen.dart'; // Import your home screen file
import 'package:firebase_auth/firebase_auth.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 5), () {
      navigateToScreen();
    });
  }

  void navigateToScreen() async {
    FirebaseAuth auth = FirebaseAuth.instance;
    User? user = auth.currentUser;

    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (context) {
        return user == null ? const SignInScreen() : const BottomNavigation();
      }),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFE7FCE7), // Customize background color
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.local_florist,
              size: 80,
            ), // Your app logo or any other widget
            const SizedBox(height: 20),
            const CircularProgressIndicator(
              color: Colors.green,
            ), // Loading indicator
            const SizedBox(height: 20),
            Container(
              padding: const EdgeInsets.all(10),
              child: RichText(
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
            ),
          ],
        ),
      ),
    );
  }
}
