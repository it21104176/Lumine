import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ProductListPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('List of Products'),
        backgroundColor: Colors.black,
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection('products').snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(), // Display loading indicator
            );
          }
          if (snapshot.hasError) {
            return Center(
              child: Text('Error: ${snapshot.error}'), // Display error if any
            );
          }
          final products = snapshot.data!.docs;
          return SingleChildScrollView(
            scrollDirection: Axis.horizontal, // Scroll horizontally
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical, // Scroll vertically
              child: DataTable(
                columnSpacing: 20, // Add spacing between columns
                dataRowHeight: 50, // Adjust row height as needed
                columns: [
                  DataColumn(label: Text('Product Name')),
                  DataColumn(label: Text('Qty')),
                  DataColumn(label: Text('Category')),
                  DataColumn(label: Text('Price')),
                  DataColumn(label: Text('Action')),
                ],
                rows: products.map((product) {
                  final data = product.data() as Map<String, dynamic>;
                  return DataRow(cells: [
                    DataCell(Text(data['productName'])),
                    DataCell(Text(data['quantity'].toString())),
                    DataCell(Text('\$${data['price']}')),
                    DataCell(Text(data['category'])),
                    DataCell(Row(
                      children: [
                        IconButton(
                          icon: Icon(Icons.delete),
                          onPressed: () {
                            // Action when delete button is pressed
                            FirebaseFirestore.instance
                                .collection('products')
                                .doc(product.id)
                                .delete()
                                .then((_) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text('Product deleted successfully'),
                                  backgroundColor: Colors.green,
                                ),
                              );
                            }).catchError((error) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text('Failed to delete product'),
                                  backgroundColor: Colors.red,
                                ),
                              );
                            });
                          },
                        ),
                      ],
                    )),
                  ]);
                }).toList(),
              ),
            ),
          );
        },
      ),
    );
  }
}
