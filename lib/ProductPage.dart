import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:lumine/ProductDetailPage.dart';
import 'BottomNavBar.dart';
import 'Cart.dart';
import 'HomePage.dart';

// Define the Product class
class Product {
  final String name;
  final String imageUrl;
  final String size;
  final double price;

  Product({required this.name, required this.imageUrl, required this.size, required this.price});
}


class CartPage extends StatelessWidget {
  final Cart cart;

  CartPage({required this.cart});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My Cart'),
        backgroundColor: Colors.black,
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: cart.itemCount,
              itemBuilder: (context, index) {
                final product = cart.items[index];
                return Card(
                  margin: EdgeInsets.all(8.0),
                  child: ListTile(
                    title: Text(product.name),
                    subtitle: Text('RS: ${product.price.toStringAsFixed(2)}'),
                    leading: SizedBox(
                      width: 80.0,
                      height: 80.0,
                      child: Image.network(
                        product.imageUrl,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => HomePage(cart: cart)),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.black,
              minimumSize: Size(300, 50),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            child: Text('Buy Now',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          SizedBox(height: 40),
        ],
      ),
      bottomNavigationBar: BottomNavBar(userEmail: 'user1@gmail.com', cart: cart),
    );
  }
}


class ProductPage extends StatelessWidget {
  final String subCategoryName;
  final Color backgroundColor;
  final String subCategoryImage;
  final Cart cart; // Add cart parameter

  ProductPage({required this.subCategoryName, required this.backgroundColor, required this.subCategoryImage, required this.cart});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(''),
        backgroundColor: Colors.black,
      ),
      body: Container(
        color: backgroundColor,
        child: Column(
          children: [
            SizedBox(height: 40.0),
            Container(
              decoration: BoxDecoration(
                color: Color(0xFFFFD9D9),
                border: Border.all(color: Colors.grey),
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: EdgeInsets.all(10.0),
                    child: Text(
                      subCategoryName,
                      style: TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Expanded(
                    child: Image.asset(
                      subCategoryImage,
                      height: 150.0,
                      width: 300.0,
                      fit: BoxFit.cover,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 40.0),
            Expanded(
              child: StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance.collection('products').where('category', isEqualTo: subCategoryName).snapshots(),
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

                  final List<Product> products = snapshot.data!.docs.map((doc) {
                    return Product(
                      name: doc['productName'],
                      imageUrl: doc['imageUrl'],
                      size: doc['size'],
                      price: doc['price'].toDouble(),
                    );
                  }).toList();

                  return GridView.count(
                    crossAxisCount: 2,
                    children: List.generate(
                      products.length,
                          (index) => GestureDetector(
                        onTap: () {
                          // Navigate to ProductDetailPage with the corresponding product and background color
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ProductDetailPage(product: products[index], backgroundColor: backgroundColor, cart: cart), // Pass the cart instance
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
      ),
      bottomNavigationBar: BottomNavBar(userEmail: 'user1@gmail.com', cart: cart),
    );
  }
}

class ProductBox extends StatelessWidget {
  final Product product;

  ProductBox({required this.product});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        color: Colors.white,
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
