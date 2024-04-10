// import 'package:flutter/material.dart';
// import 'package:lumine/Cart.dart'; // Import the Cart class
// import 'package:lumine/ProductPage.dart'; // Import the Product class
//
// class CartPage extends StatelessWidget {
//   final Cart cart;
//
//   CartPage({required this.cart});
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Cart'),
//       ),
//       body: ListView.builder(
//         itemCount: cart.itemCount,
//         itemBuilder: (context, index) {
//           final product = cart.items[index];
//           return ListTile(
//             title: Text(product.name),
//             subtitle: Text('RS: ${product.price.toStringAsFixed(2)}'),
//           );
//         },
//       ),
//     );
//   }
// }
