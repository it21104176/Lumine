import 'package:flutter/material.dart';
import 'package:lumine/CategoryPage.dart';
import 'package:lumine/HomePage.dart';
import 'package:lumine/ProfilePage.dart'; // Import the ProfilePage class

class BottomNavBar extends StatelessWidget {
  final String userEmail; // Pass the user's email to BottomNavBar

  BottomNavBar({required this.userEmail});

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: 3, // Profile page index
      type: BottomNavigationBarType.fixed,
      backgroundColor: Colors.black,
      selectedItemColor: Colors.white,
      unselectedItemColor: Colors.white,
      onTap: (index) {
        // Handle navigation to different pages
        if (index == 0) {
          // Navigate to Home page
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => HomePage()),
          );
        } else if (index == 1) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => CategoryPage()),
          );
        } else if (index == 2) {
          // Navigate to Cart Page
        } else if (index == 3) {
          // Navigate to Profile Page with the user's email
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => ProfilePage(email: userEmail)),
          );
        }
      },
      items: [
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: '',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.apps),
          label: '',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.shopping_cart),
          label: '',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.person),
          label: '',
        ),
      ],
    );
  }
}
