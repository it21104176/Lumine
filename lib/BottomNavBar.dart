import 'package:flutter/material.dart';
import 'package:lumine/CartPage.dart';
import 'package:lumine/CategoryPage.dart';
import 'package:lumine/HomePage.dart';
import 'package:lumine/ProfilePage.dart';

import 'Cart.dart';
import 'ProductPage.dart'; // Import the ProfilePage class

class BottomNavBar extends StatelessWidget {
  final String userEmail; // Pass the user's email to BottomNavBar
  final Cart cart; // Pass the cart to BottomNavBar

  BottomNavBar({required this.userEmail, required this.cart});

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: 0, // Set the initial index to 0 (Home page)
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
            MaterialPageRoute(builder: (context) => HomePage(cart: cart)),
          );
        } else if (index == 1) {
          // Navigate to CategoryPage with cart
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => CategoryPage(cart: cart)),
          );
        } else if (index == 2) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => CartPage(cart: cart)),
          );
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
