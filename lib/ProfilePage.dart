import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:lumine/Home.dart';

import 'LoginPage.dart';
import 'SignupPage.dart';

class ProfilePage extends StatefulWidget {
  final String email;

  ProfilePage({required this.email});

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  late String _username;
  late String _password;
  bool _isPasswordVisible = false;

  @override
  void initState() {
    super.initState();
    // Call a function to fetch user details when the widget is initialized
    getUserDetails();
  }

  void getUserDetails() async {
    // Query Firestore for user with the provided email
    QuerySnapshot<Map<String, dynamic>> users = await FirebaseFirestore.instance
        .collection('customer')
        .where('email', isEqualTo: widget.email)
        .get();

    // If user with provided email exists, get user details
    if (users.docs.isNotEmpty) {
      setState(() {
        _username = users.docs.first.data()['username'];
        _password = users.docs.first.data()['password'];
        // You can add more fields as needed
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile'),
        backgroundColor: Colors.black,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(height: 20),
            Center(
              child: CircleAvatar(
                radius: 50,
                backgroundImage: AssetImage('assets/profile_pic.jpg'), // Replace with your profile picture
              ),
            ),
            SizedBox(height: 20),
            Center(
              child: Column(
                children: [
                  Text(
                    _username ?? 'Loading...', // Display username or loading message
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    widget.email, // Display user's email passed from login page
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    'Email',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 10),
                  TextField(
                    readOnly: true,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: widget.email, // Display user's email passed from login page
                    ),
                  ),
                  SizedBox(height: 20),
                  Text(
                    'Password',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 10),
                  TextField(
                    obscureText: !_isPasswordVisible,
                    readOnly: true,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: _password, // Display user's password
                      suffixIcon: GestureDetector(
                        onTap: () {
                          setState(() {
                            _isPasswordVisible = !_isPasswordVisible;
                          });
                        },
                        child: Icon(
                          _isPasswordVisible ? Icons.visibility : Icons.visibility_off,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      // Navigate to edit profile page
                    },
                    child: Text('Edit Profile'),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
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
              MaterialPageRoute(builder: (context) => Home()),
            );
          } else if (index == 1) {
            // Navigate to LoginPage
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => LoginPage()),
            );
          } else if (index == 2) {
            // Navigate to SignupPage
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => SignupPage()),
            );
          } else if (index == 3) {
            // Stay on Profile page
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
      ),
    );
  }
}