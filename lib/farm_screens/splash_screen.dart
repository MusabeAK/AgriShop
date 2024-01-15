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
    return const Scaffold(
      backgroundColor: Color(0xFFE7FCE7), // Customize background color
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.local_florist,
              size: 40,
            ), // Your app logo or any other widget
            SizedBox(height: 20),
            CircularProgressIndicator(), // Loading indicator
            SizedBox(height: 20),
            Text(
              'Farm Connect',
              style: TextStyle(
                fontSize: 24,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
