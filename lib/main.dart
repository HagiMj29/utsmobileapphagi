import 'package:flutter/material.dart';
import 'package:mobileuts/auth/loginpage.dart';
import 'package:mobileuts/auth/registerpage.dart';
import 'package:mobileuts/galeripage.dart';
import 'package:mobileuts/listsejarawan.dart';
import 'package:mobileuts/splashscreen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      debugShowCheckedModeBanner: false,
      home:SplashScreen(),
    );
  }
}


