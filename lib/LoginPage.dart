import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:lumine/SignupPage.dart';
import 'Home.dart';
import 'ProfilePage.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool _isPasswordVisible = false;
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
        backgroundColor: Colors.black,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              padding: EdgeInsets.symmetric(vertical: 20),
              child: Center(
                child: Text(
                  'LOGIN',
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 24,
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextField(
                    controller: emailController,
                    decoration: InputDecoration(
                      labelText: 'Email',
                    ),
                  ),
                  SizedBox(height: 20),
                  TextField(
                    controller: passwordController,
                    obscureText: !_isPasswordVisible,
                    decoration: InputDecoration(
                      labelText: 'Password',
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
                  Row(
                    children: [
                      Checkbox(
                        value: false, // You can manage the state of this checkbox as needed
                        onChanged: (bool? value) {
                          // Handle checkbox value change
                        },
                      ),
                      Text('Remember Me'),
                    ],
                  ),
                  SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      // Perform login action
                      login(context);
                    },
                    style: ElevatedButton.styleFrom(
                      primary: Colors.black, // Change button color here
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10), // Set border radius here
                        side: BorderSide(color: Colors.white), // Set border color here
                      ),
                      minimumSize: Size(double.infinity, 50), // Set button size here
                    ),
                    child: Text(
                      'Login',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 24,
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Don't have an account?"),
                      TextButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => SignupPage(),
                            ),
                          );
                        },
                        child: Text('SignUp'),
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                  OutlinedButton(
                    onPressed: () {
                      // Perform Google login action
                    },
                    style: OutlinedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10), // Set border radius here
                      ),
                      minimumSize: Size(double.infinity, 50), // Set button size here
                    ),
                    child: Text('Login with Google'),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void login(BuildContext context) async {
    // Retrieve email and password from text controllers
    String email = emailController.text.trim();
    String password = passwordController.text;

    // Query Firestore for user with the provided email
    QuerySnapshot<Map<String, dynamic>> users = await FirebaseFirestore.instance
        .collection('customer')
        .where('email', isEqualTo: email)
        .get();

    // Check if a user with the provided email exists
    if (users.docs.isNotEmpty) {
      // Check if the password matches the stored password
      if (users.docs.first.data()['password'] == password) {
        // Navigate to profile page with user's email passed as argument
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => ProfilePage(email: email)),
        );
      } else {
        // Show toast message if password is incorrect
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Incorrect password'),
          ),
        );
      }
    } else {
      // Show toast message if user with provided email doesn't exist
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('User with provided email does not exist'),
        ),
      );
    }
  }

}
