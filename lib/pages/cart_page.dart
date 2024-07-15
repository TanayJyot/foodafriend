import "package:buildspace_s5/screens/order_tracking.dart";
import "package:flutter/material.dart";
import "package:buildspace_s5/components/my_button.dart";
import "package:buildspace_s5/components/my_cart_tile.dart";
import "package:google_maps_flutter/google_maps_flutter.dart";
import "../models/restaurant.dart";
import "package:provider/provider.dart";

class CartPage extends StatelessWidget {
  const CartPage({super.key});

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
                onTap: () {
                  LatLng sourceLocation =
                      LatLng(43.664191714479635, -79.39623146137073);
                  LatLng destination =
                      LatLng(43.668910354936365, -79.39777641370725);
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
