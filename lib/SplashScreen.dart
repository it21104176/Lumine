import 'package:flutter/material.dart';
import 'package:lumine/CategoryPage.dart';
import 'package:lumine/LoginPage.dart';

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          Positioned(
            top: 100,
            left: 0,
            right: 0,
            child: Align(
              alignment: Alignment.topCenter,
              child: Text(
                'Welcome to',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
            ),
          ),
          Positioned(
            top: 200,
            left: 0,
            right: 0,
            child: Align(
              alignment: Alignment.topCenter,
              child: Image.asset(
                'assets/logo.png', // Replace 'assets/logo.png' with your logo image path
                width: 150,
                height: 150,
              ),
            ),
          ),
          Positioned(
            top: 400,
            left: 0,
            right: 0,
            child: Align(
              alignment: Alignment.topCenter,
              child: Text(
                'Your Personal clothing search',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                ),
              ),
            ),
          ),
          Positioned(
            top: 500,
            left: 0,
            right: 0,
            child: Align(
              alignment: Alignment.topCenter,
              child: Text(
                'Sign up to get started',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                ),
              ),
            ),
          ),
          Positioned(
            top: 550,
            left: 0,
            right: 0,
            child: Align(
              alignment: Alignment.topCenter,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => CategoryPage(),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  primary: Colors.black, // Change button color here
                  minimumSize: Size(200, 50), // Set minimum size for button
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10), // Set border radius here
                    side: BorderSide(color: Colors.white), // Set border color here
                  ),
                ),
                child: Text('Get Started',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            top: 630,
            left: 0,
            right: 0,
            child: Align(
              alignment: Alignment.topCenter,
              child: GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => LoginPage(),
                    ),
                  );
                },
                child: Text(
                  'Already have an account? Log in',
                  style: TextStyle(
                    color: Colors.blue, // Set link color
                    decoration: TextDecoration.underline,
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 50,
            left: 180,
            child: Row(
              children: [
                Icon(
                  Icons.more_horiz,
                  color: Colors.white,
                  size: 30,
                ),
                SizedBox(width: 10),
                Icon(
                  Icons.arrow_forward_ios,
                  color: Colors.white,
                  size: 30,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
