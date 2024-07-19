import "package:buildspace_s5/receiver/screens/order_tracking.dart";
import "package:flutter/material.dart";
import 'package:buildspace_s5/receiver/screens/heropage/item_screens/items_screen_components/my_button.dart';
import "package:google_maps_flutter/google_maps_flutter.dart";
import "../../../../../models/cart_item.dart";
import "../../../../../models/restaurant.dart";
import "package:provider/provider.dart";
import 'package:buildspace_s5/services/database.dart';

import "package:buildspace_s5/receiver/screens/heropage/item_screens/items_screen_components/my_quantity_selector.dart";

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
                onTap: () async {
                  LatLng sourceLocation =
                      const LatLng(43.664191714479635, -79.39623146137073);
                  LatLng destination =
                      const LatLng(43.668910354936365, -79.39777641370725);
                  await await DatabaseService().addItems(userCart);
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


class MyCartTile extends StatelessWidget {
  final CartItem cartItem;

  const MyCartTile({
    super.key,
    required this.cartItem,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer<Restaurant>(
        builder: (context, restaurant, child) => Container(
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.secondary,
                borderRadius: BorderRadius.circular(8),
              ),
              margin: const EdgeInsets.symmetric(horizontal: 25, vertical: 10),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // food image
                        ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: Image.asset(
                            cartItem.food.imagePath,
                            height: 100,
                            width: 100,
                          ),
                        ),

                        const SizedBox(
                          width: 10,
                        ),

                        // name & price
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            //food name
                            Text(
                              cartItem.food.name,
                              style: const TextStyle(fontWeight: FontWeight.bold),
                            ),

                            // food price
                            Text('\$${cartItem.food.price}'),
                          ],
                        ),

                        const Spacer(),

                        // quantity bar
                        QuantitySelector(
                          quantity: cartItem.quantity,
                          food: cartItem.food,
                          onIncrement: () {
                            restaurant.addToCart(cartItem.food);
                          },
                          onDecrement: () {
                            restaurant.removeFromCart(cartItem);
                          },
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ));
  }
}
