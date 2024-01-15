//import 'package:farm_conn/farm_screens/signin_screen.dart';
import 'package:agri_shop/farm_screens/bottom_navigation.dart';
import 'package:agri_shop/farm_screens/splash_screen.dart';
import 'package:agri_shop/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: const Color(0xFFF4FAF4),
        useMaterial3: true,
      ),
      home: const SplashScreen(),
    );
  }
}
