import "package:buildspace_s5/screens/order_tracking.dart";
import "package:firebase_auth/firebase_auth.dart";
import "package:flutter/material.dart";
import "package:buildspace_s5/components/my_button.dart";
import "package:buildspace_s5/components/my_cart_tile.dart";
import "package:google_maps_flutter/google_maps_flutter.dart";
import "../models/restaurant.dart";
import "package:provider/provider.dart";
import 'package:cloud_firestore/cloud_firestore.dart';

class CartPage extends StatelessWidget {
  const CartPage({super.key});

  Future<void> _addItems(itemList) async {

    List<Map<String, dynamic>> listOfItems= [];
    for (final item in itemList){
      listOfItems.add({
        "name": item.food.name,
        "price": item.food.price,
        "quantity": item.quantity
      });
    }
    try {
      final user = FirebaseAuth.instance.currentUser;
      final uid = user?.uid;

      // Create a new item document in the restaurant's items subcollection
      await FirebaseFirestore.instance.collection('Order Queue').add({
        'itemList': listOfItems,
        'timestamp': Timestamp.now(),  // Optional: Add a timestamp for order
        'user_id': uid
      });
    } catch (e) {
      print('Error adding items to Firestore: $e');
      // Optionally, you can show a snackbar or dialog to inform the user of the error
    }
  }



  @override
  Widget build(BuildContext context) {
    return Consumer<Restaurant>(builder: (context, restaurant, child) {
      // cart

      final userCart = restaurant.cart;

      // scaffold UI
      return Scaffold(
        appBar: AppBar(
          title: const Text("Cart"),
          backgroundColor: Colors.transparent,
          foregroundColor: Theme.of(context).colorScheme.inversePrimary,
          actions: [
            // clear all cart
            IconButton(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    title:
                        const Text("Are you sure you want to clear the cart?"),
                    actions: [
                      // cancel button
                      TextButton(
                        onPressed: () => Navigator.pop(context),
                        child: const Text("Cancel"),
                      ),

                      // yes button
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                          restaurant.clearCart();
                        },
                        child: const Text("Yes"),
                      ),
                    ],
                  ),
                );
              },
              icon: const Icon(Icons.delete),
            ),
          ],
        ),
        body: Column(
          children: [
            // list of cart
            Expanded(
              child: Column(
                children: [
                  userCart.isEmpty
                      ? const Expanded(
                          child: Center(child: Text("Cart is EMPTY ...")))
                      : Expanded(
                          child: ListView.builder(
                            itemCount: userCart.length,
                            itemBuilder: (context, index) {
                              // get individual cart item
                              final cartItem = userCart[index];

                              // return cart tile UI
                              return MyCartTile(cartItem: cartItem);
                            },
                          ),
                        ),
                ],
              ),
            ),
            // button to checkout

            MyButton(
                text: "Checkout",
                onTap: () async {
                  LatLng sourceLocation =
                      const LatLng(43.664191714479635, -79.39623146137073);
                  LatLng destination =
                      const LatLng(43.668910354936365, -79.39777641370725);
                  await _addItems(userCart);


                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => OrderTrackingPage(
                              sourceLocation: sourceLocation,
                              destination: destination)));
                }),

            const SizedBox(
              height: 25,
            )
          ],
        ),
      );
    });
  }
}
