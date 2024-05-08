import "package:flutter/cupertino.dart";
import "package:flutter/material.dart";
import "package:mobileuts/auth/loginpage.dart";
import "package:mobileuts/mainmenu.dart";
import 'package:google_fonts/google_fonts.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    _goHome();
    super.initState();
  }

  _goHome() async {
    await Future.delayed(const Duration(milliseconds: 7000), () {});
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => LoginPage()));
  }

  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 150,),
            Image.asset(
              'images/logo.png',
              scale: 18,
            ),
            Text(
              'Minang Eductinfo',
              style: GoogleFonts.imFellDwPicaSc(
                fontSize: 40,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              'Apps talks about Minang Kabau Tribe',
              style: GoogleFonts.imFellDwPicaSc(
                fontSize: 15,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(
              height: 200,
            ),
            Text(
              'V1.0',
              style: GoogleFonts.imFellDwPicaSc(
                fontSize: 15,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
