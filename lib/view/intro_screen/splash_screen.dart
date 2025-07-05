  import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_crud_prac/view/intro_screen/signin_screen.dart';
  import 'package:firebase_crud_prac/view/intro_screen/signup_screen.dart';
  import 'package:flutter/material.dart';
  import '../buttom_navigation_bar/bottom_navigation_bar_screen.dart';
import '../buttom_navigation_bar/hive_screen.dart';

  class SplashScreen extends StatefulWidget {
    const SplashScreen({super.key});

    @override
    State<SplashScreen> createState() => _SplashScreenState();
  }

  class _SplashScreenState extends State<SplashScreen> {
    @override
    void initState() {
      super.initState();
      Future.delayed(Duration(seconds: 3), () {
        final user = FirebaseAuth.instance.currentUser;

        if (user != null) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => BottomNavigationBarScreen()),
          );
        } else {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => SignInScreen()),
          );
        }
      });
    }

    @override
    Widget build(BuildContext context) {
      return Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.person_2_outlined, size: 60, color: Colors.blueAccent),
              SizedBox(height: 20),
              Text(
                'Splash Screen',
                style: TextStyle(color: Colors.blueAccent, fontSize: 30),
              ),
            ],
          ),
        ),
      );
    }
  }
