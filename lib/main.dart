import 'package:blood/pages/home.dart';
import 'package:blood/pages/landing.dart';
import 'package:blood/theme/theme.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      home: HomePage(),
      // Uncomment the line below to use the LandingPage instead of HomePage
      // LandingPage(),
    );
  }
}
