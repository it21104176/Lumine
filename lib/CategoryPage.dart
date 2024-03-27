import 'package:flutter/material.dart';

class CategoryPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Select Category'),
        backgroundColor: Colors.black,
      ),
      body: ListView(
        children: [
          buildCategoryItem(
            context,
            'Women',
            'assets/women_main.jpeg',
            ['Skirts', 'Dresses', 'Frocks'],
          ),
          buildCategoryItem(
            context,
            'Men',
            'assets/men_main.jpeg',
            ['Pants', 'Shirts'],
          ),
        ],
      ),
    );
  }

  Widget buildCategoryItem(BuildContext context, String categoryName, String imagePath, List<String> subCategories) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        GestureDetector(
          onTap: () {
            // Navigate to relevant category page when tapped
            // You can navigate to different pages based on the selected category
          },
          child: Container(
            padding: EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  categoryName,
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
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
                  children: subCategories.map((subCategory) {
                    return Row(
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
                    );
                  }).toList(),
                ),
              ],
            ),
          ),
        ),
        Divider(), // Add a divider below each category
      ],
    );
  }

}