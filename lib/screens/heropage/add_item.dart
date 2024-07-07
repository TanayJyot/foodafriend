import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:buildspace_s5/services/auth.dart';

class AddItem extends StatefulWidget {

  final String restaurantId;


  AddItem({super.key, required this.restaurantId});

  @override
  State<AddItem> createState() => _AddItemState();
}

class _AddItemState extends State<AddItem> {
  final AuthService _auth = AuthService();

  final TextEditingController _itemNameController = TextEditingController();
  final TextEditingController _itemDescriptionController = TextEditingController();
  final TextEditingController _itemPriceController = TextEditingController();

  void _addItem() async {
    // Get input values
    String itemName = _itemNameController.text;
    String itemDescription = _itemDescriptionController.text;
    String itemPrice = _itemPriceController.text;

    // Create a new item document in the restaurant's items subcollection
    await FirebaseFirestore.instance
        .collection('Restaurants')
        .doc(widget.restaurantId)
        .collection('items')
        .add({
      'name': itemName,
      'description': itemDescription,
      'price': itemPrice,
    });

    // Clear the text fields
    _itemNameController.clear();
    _itemDescriptionController.clear();
    _itemPriceController.clear();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
    title: const Text('Food a friend'),
    backgroundColor: Colors.brown[400],
    elevation: 0.0,
    actions: <Widget>[
    TextButton.icon(
    icon: const Icon(Icons.person),
    onPressed: () async {
    await _auth.signOut();
    },
    label: const Text('logout'),
    )
    ],
    ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(controller: _itemNameController, decoration: InputDecoration(labelText: 'Item Name')),
            TextField(controller: _itemDescriptionController, decoration: InputDecoration(labelText: 'Item Description')),
            TextField(controller: _itemPriceController, decoration: InputDecoration(labelText: 'Item Price')),
            SizedBox(height: 20),
            ElevatedButton(onPressed: _addItem, child: Text('Add Item')),
          ],
        ),
      ),
    );
  }
}
