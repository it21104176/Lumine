import 'package:flutter/material.dart';
import 'package:lumine/ProductPage.dart';

import 'BottomNavBar.dart';
import 'Cart.dart';

class CategoryPage extends StatelessWidget {
  final Cart cart; // Add cart parameter

  CategoryPage({required this.cart}); // Constructor to accept the cart parameter

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Category'),
        backgroundColor: Colors.black,
        automaticallyImplyLeading: false, // Remove back button
      ),
      body: ListView(
        children: [
          buildCategoryItem(
            context,
            'Women',
            'assets/women_main.jpeg',
            ['Tshirt and Crop tops', 'Dressers   ', 'Skirts and Pants'],
            ['assets/Women1.png', 'assets/Women2.png', 'assets/Women3.png'], // Images for Women subcategories
            Color(0xFFDEBEE3), // Background color for Women category
          ),
          buildCategoryItem(
            context,
            'Men',
            'assets/men_main.jpeg',
            ['Shirt and Tshirts', 'Denim and Pants'],
            ['assets/Men1.png', 'assets/Men2.png'], // Images for Men subcategories
            Color(0xFFA0C1FF), // Background color for Men category
          ),
        ],
      ),
      bottomNavigationBar: BottomNavBar(userEmail: 'user1@gmail.com', cart: cart),
    );
  }

  Widget buildCategoryItem(BuildContext context, String categoryName, String imagePath, List<String> subCategories, List<String> subCategoryImages, Color backgroundColor) {
    return GestureDetector(
      onTap: () {
        // Navigate to ProductPage with the tapped category's background color and subcategory image
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ProductPage(subCategoryName: subCategories.first, backgroundColor: backgroundColor, subCategoryImage: subCategoryImages.first, cart: cart), // Pass cart to ProductPage
          ),
        );
      },
      child: Container(
        color: backgroundColor, // Set background color
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              categoryName,
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.black, // Text color
              ),
            ),
            SizedBox(height: 10),
            Image.asset(
              imagePath,
              height: 200,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
            SizedBox(height: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: subCategories.asMap().entries.map((entry) {
                final int index = entry.key;
                final String subCategory = entry.value;
                final String subCategoryImage = subCategoryImages[index];
                return GestureDetector(
                  onTap: () {
                    // Navigate to ProductPage with the tapped subcategory and background color
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ProductPage(subCategoryName: subCategory, backgroundColor: backgroundColor, subCategoryImage: subCategoryImage, cart: cart), // Pass cart to ProductPage
                      ),
                    );
                  },
                  child: Row(
                    children: [
                      Icon(Icons.arrow_forward_ios), // Arrow icon
                      Text(
                        subCategory,
                        style: TextStyle(
                          fontSize: 18,
                        ),
                      ),
                      SizedBox(height: 20,),
                    ],
                  ),
                );
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }
}
