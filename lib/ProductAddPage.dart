import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ProductAddPage extends StatefulWidget {
  @override
  _ProductAddPageState createState() => _ProductAddPageState();
}

class _ProductAddPageState extends State<ProductAddPage> {
  String? _imageUrl;
  String _productName = '';
  String _quantity = '';
  String _price = '';
  String _selectedSize = ''; // Changed to hold only one selected size
  String _selectedCategory = '';

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final pickedImage = await picker.pickImage(source: ImageSource.gallery);

    if (pickedImage != null) {
      final imageFile = File(pickedImage.path);

      final imageUploadTask = FirebaseStorage.instance
          .ref()
          .child('product_images')
          .child('image_${DateTime.now()}.jpg')
          .putFile(imageFile);

      final imageUrl = await (await imageUploadTask).ref.getDownloadURL();

      setState(() {
        _imageUrl = imageUrl;
      });
    }
  }

  void _submitProduct() async {
    if (_imageUrl == null ||
        _productName.isEmpty ||
        _quantity.isEmpty ||
        _price.isEmpty ||
        _selectedSize.isEmpty || // Check for selected size
        _selectedCategory.isEmpty) {
      // Show an error message or alert dialog for incomplete fields
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please fill in all fields...'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    try {
      await _firestore.collection('products').add({
        'imageUrl': _imageUrl!,
        'productName': _productName,
        'quantity': int.parse(_quantity),
        'price': double.parse(_price),
        'size': _selectedSize, // Store the selected size
        'category': _selectedCategory,
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Product deleted successfully'),
          backgroundColor: Colors.green,
        ),
      );

      // Clear form fields after submission
      setState(() {
        _imageUrl = null;
        _productName = '';
        _quantity = '';
        _price = '';
        _selectedSize = ''; // Clear selected size
        _selectedCategory = '';
      });

      // Show a success message or navigate to a different page
    } catch (error) {
      // Handle error
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('An error occurred. Please try again later.'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Product'),
        backgroundColor: Colors.black, // Change app bar color here
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              ElevatedButton(
                onPressed: _pickImage,
                child: Text('Pick Image'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green, // Change button color here
                ),
              ),
              SizedBox(height: 20),
              if (_imageUrl != null)
                Image.network(
                  _imageUrl!,
                  fit: BoxFit.cover,
                  height: 200,
                ),
              SizedBox(height: 20),
              TextFormField(
                decoration: InputDecoration(labelText: 'Product Name'),
                onChanged: (value) {
                  _productName = value;
                },
              ),
              SizedBox(height: 20),
              TextFormField(
                decoration: InputDecoration(labelText: 'Quantity'),
                keyboardType: TextInputType.number,
                onChanged: (value) {
                  _quantity = value;
                },
              ),
              SizedBox(height: 20),
              TextFormField(
                decoration: InputDecoration(labelText: 'Price'),
                keyboardType:
                TextInputType.numberWithOptions(decimal: true),
                onChanged: (value) {
                  _price = value;
                },
              ),
              SizedBox(height: 20),
              Row(
                children: [
                  Text('Size: '),
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
              SizedBox(height: 20),
              DropdownButtonFormField<String>(
                value:
                _selectedCategory.isNotEmpty ? _selectedCategory : null,
                items: ['Tshirt and Crop tops', 'Dressers', 'Skirts and Pants', 'Shirt and Tshirts', 'Denim and Pants']
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
              ElevatedButton(
                onPressed: _submitProduct,
                child: Text('Add Product',
                  style: TextStyle(
                    fontSize: 20, // Change text size here
                    fontWeight: FontWeight.bold, // Make text bold
                  ),),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.black, // Change button color here
                  minimumSize: Size(10, 50), // Set minimum size for button
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10), // Set border radius here
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
