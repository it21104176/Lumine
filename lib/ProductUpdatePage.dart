import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ProductUpdatePage extends StatefulWidget {
  final String productId;

  ProductUpdatePage({required this.productId});

  @override
  _ProductUpdatePageState createState() => _ProductUpdatePageState();
}

class _ProductUpdatePageState extends State<ProductUpdatePage> {
  late TextEditingController _productNameController;
  late TextEditingController _quantityController;
  late TextEditingController _priceController;
  late String _selectedSize;
  late String _selectedCategory;

  @override
  void initState() {
    super.initState();
    _productNameController = TextEditingController();
    _quantityController = TextEditingController();
    _priceController = TextEditingController();
    _selectedSize = '';
    _selectedCategory = 'Category A'; // Set a valid initial value here
    fetchProductDetails();
  }

  @override
  void dispose() {
    _productNameController.dispose();
    _quantityController.dispose();
    _priceController.dispose();
    super.dispose();
  }

  void fetchProductDetails() {
    FirebaseFirestore.instance
        .collection('products')
        .doc(widget.productId)
        .get()
        .then((DocumentSnapshot documentSnapshot) {
      if (documentSnapshot.exists) {
        setState(() {
          _productNameController.text = documentSnapshot['productName'];
          _quantityController.text = documentSnapshot['quantity'].toString();
          _priceController.text = documentSnapshot['price'].toString();

          // Fetch sizes
          List<dynamic> sizes = documentSnapshot['sizes'];
          if (sizes.isNotEmpty) {
            _selectedSize = sizes[0]; // Set initial selected size
          }

          // Fetch category
          _selectedCategory = documentSnapshot['category']; // Assuming 'category' is a String field in Firestore representing category
        });
      } else {
        print('Document does not exist on the database');
      }
    });
  }

  void updateProduct() {
    // Get the updated values from the controllers
    String updatedProductName = _productNameController.text;
    int updatedQuantity = int.parse(_quantityController.text);
    double updatedPrice = double.parse(_priceController.text);

    // Construct the updated data object
    Map<String, dynamic> updatedData = {
      'productName': updatedProductName,
      'quantity': updatedQuantity,
      'price': updatedPrice,
      'sizes': [_selectedSize], // Assuming sizes is stored as a list
      'category': _selectedCategory,
    };

    // Update the product in Firestore
    FirebaseFirestore.instance
        .collection('products')
        .doc(widget.productId)
        .update(updatedData)
        .then((value) {
      // Show a success message
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Product updated successfully'),
          duration: Duration(seconds: 2),
        ),
      );

      // Navigate back to the product list page
      Navigator.pop(context);

    }).catchError((error) {
      // Show an error message if update fails
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Failed to update product: $error'),
          duration: Duration(seconds: 2),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Update Product'),
        backgroundColor: Colors.black,
      ),
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height, // Set container height to screen height
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextField(
                controller: _productNameController,
                decoration: InputDecoration(labelText: 'Product Name'),
              ),
              SizedBox(height: 8),
              TextField(
                controller: _quantityController,
                decoration: InputDecoration(labelText: 'Quantity'),
                keyboardType: TextInputType.number,
              ),
              SizedBox(height: 8),
              TextField(
                controller: _priceController,
                decoration: InputDecoration(labelText: 'Price'),
                keyboardType: TextInputType.number,
              ),
              SizedBox(height: 8),
              Text('Size:', style: TextStyle(fontSize: 16)),
              SizedBox(height: 4),
              Row(
                children: [
                  Radio(
                    value: 'S',
                    groupValue: _selectedSize,
                    onChanged: (value) {
                      setState(() {
                        _selectedSize = value.toString();
                      });
                    },
                  ),
                  Text('S'),
                  Radio(
                    value: 'M',
                    groupValue: _selectedSize,
                    onChanged: (value) {
                      setState(() {
                        _selectedSize = value.toString();
                      });
                    },
                  ),
                  Text('M'),
                  Radio(
                    value: 'L',
                    groupValue: _selectedSize,
                    onChanged: (value) {
                      setState(() {
                        _selectedSize = value.toString();
                      });
                    },
                  ),
                  Text('L'),
                  Radio(
                    value: 'XL',
                    groupValue: _selectedSize,
                    onChanged: (value) {
                      setState(() {
                        _selectedSize = value.toString();
                      });
                    },
                  ),
                  Text('XL'),
                  Radio(
                    value: 'XXL',
                    groupValue: _selectedSize,
                    onChanged: (value) {
                      setState(() {
                        _selectedSize = value.toString();
                      });
                    },
                  ),
                  Text('XXL'),
                ],
              ),
              SizedBox(height: 8),
              DropdownButtonFormField<String>(
                value: _selectedCategory,
                items: ['Category A', 'Category B', 'Category C', 'Category D']
                    .map((category) {
                  return DropdownMenuItem<String>(
                    value: category,
                    child: Text(category),
                  );
                }).toList(),
                hint: Text('Select Category'),
                onChanged: (value) {
                  setState(() {
                    _selectedCategory = value!;
                  });
                },
              ),
              SizedBox(height: 60),
              Center(
                child: SizedBox(
                  width: 300,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: () {
                      updateProduct();
                    },
                    child: Text(
                      'Update Product',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.black,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ProductUpdateListPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Product List '),
        backgroundColor: Colors.black,
      ),
      body: SingleChildScrollView(
      scrollDirection: Axis.horizontal, // Scroll horizontally
      child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: StreamBuilder(
          stream: FirebaseFirestore.instance.collection('products').snapshots(),
          builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
            if (snapshot.hasError) {
              return Center(
                child: Text('Error: ${snapshot.error}'),
              );
            }
            final products = snapshot.data!.docs;
            return DataTable(
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
                  DataCell(Text(data['category'])),
                  DataCell(Text('\$${data['price']}')),
                  DataCell(Row(
                    children: [
                      IconButton(
                        icon: Icon(Icons.edit),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ProductUpdatePage(productId: product.id),
                            ),
                          );
                        },
                      ),
                    ],
                  )),
                ]);
              }).toList(),
            );
          },
        ),
      ),
      ),
    );
  }
}
