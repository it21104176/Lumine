import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'BottomNavBar.dart';
import 'Cart.dart';
import 'CategoryPage.dart';
import 'ProductPage.dart';

class Products {
  final String name;
  final String imageUrl;

  Products({required this.name, required this.imageUrl});
}

class HomePage extends StatelessWidget {
  final Cart cart; // Add cart parameter

  HomePage({required this.cart}); // Constructor to accept the cart parameter

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(''),
        backgroundColor: Colors.black,
        automaticallyImplyLeading: false, // Remove back button
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SizedBox(height: 40),
          Container(
            height: 200,
            color: Colors.grey[200],
            child: Row(
              children: [
                const Expanded(
                  child: Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Center(
                          child: Text(
                            'New Offers!!',
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        SizedBox(height: 10),
                        Text(
                          'Our new special offers here. you can find matching dress',
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(height: 20),
                        Center(
                          // Center widget added
                          child: Text(
                            '20%',
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Image.asset(
                  'assets/Home_image.jpg', // Image path
                  height: double.infinity,
                  width: 220, // Adjust the width as needed
                  fit: BoxFit.cover,
                ),
              ],
            ),
          ),
          SizedBox(height: 60),
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance.collection('products').snapshots(),
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return Center(
                    child: Text('Error: ${snapshot.error}'),
                  );
                }

                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }

                final List<Products> products = snapshot.data!.docs.map((doc) {
                  return Products(
                    name: doc['productName'],
                    imageUrl: doc['imageUrl'],
                  );
                }).toList();

                return GridView.count(
                  crossAxisCount: 2,
                  children: List.generate(
                    products.length,
                        (index) => GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => CategoryPage(cart: cart), // Pass cart to CategoryPage
                          ),
                        );
                      },
                      child: ProductBox(product: products[index]),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavBar(userEmail: 'user1@gmail.com', cart: cart),
    );
  }
}

class ProductBox extends StatelessWidget {
  final Products product;

  ProductBox({required this.product});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: ClipRRect(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(8.0),
                topRight: Radius.circular(8.0),
              ),
              child: Image.network(
                product.imageUrl,
                fit: BoxFit.cover,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(8.0),
            child: Text(
              product.name,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
