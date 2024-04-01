import 'package:flutter/material.dart';
import 'package:lumine/ProductAddPage.dart';
import 'package:lumine/ProductUpdatePage.dart';

import 'ProductListPage.dart';


class AdminhomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: Text('LUMINE'),
          backgroundColor: Colors.black,
        ),
        body: Align(
          alignment: Alignment.topCenter,
          child: Padding(            padding: EdgeInsets.only(top: 50.0), // Add padding to position buttons below the app bar
            child: Column(
              children: <Widget>[
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ProductAddPage(),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    primary: Colors.black, // Change button color here
                    minimumSize: Size(300, 50), // Set minimum size for button
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10), // Set border radius here
                    ),
                  ),
                  child: Text(
                      'Add Product',
                      style: TextStyle(
                        fontSize: 16, // Change text size here
                        fontWeight: FontWeight.bold, // Make text bold
                  ),
                  ),
                ),
                SizedBox(height: 30), // Adding space between buttons
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ProductUpdateListPage(),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    primary: Colors.black, // Change button color here
                    minimumSize: Size(300, 50), // Set minimum size for button
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10), // Set border radius here
                    ),
                  ),
                  child: Text('Update Product',
                    style: TextStyle(
                      fontSize: 16, // Change text size here
                      fontWeight: FontWeight.bold, // Make text bold
                    ),
                  ),
                ),
                SizedBox(height: 30), // Adding space between buttons
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ProductListPage(),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    primary: Colors.black, // Change button color here
                    minimumSize: Size(300, 50), // Set minimum size for button
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10), // Set border radius here
                    ),
                  ),
                  child: Text('List of Products',
                    style: TextStyle(
                      fontSize: 16, // Change text size here
                      fontWeight: FontWeight.bold, // Make text bold
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
