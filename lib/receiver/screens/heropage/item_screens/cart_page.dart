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
      final userCart = restaurant.cart;

      return Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.white,
          leading: BackButton(
            color: Colors.black,
          ),
          title: Text(
            "My Cart",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          actions: [
            IconButton(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: Text("Are you sure you want to clear the cart?"),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.pop(context),
                        child: Text("Cancel"),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                          restaurant.clearCart();
                        },
                        child: Text("Yes"),
                      ),
                    ],
                  ),
                );
              },
              icon: Icon(
                Icons.delete,
                color: Colors.black,
              ),
            ),
          ],
        ),
        body: Column(
          children: [
            Expanded(
              child: Column(
                children: [
                  userCart.isEmpty
                      ? Expanded(
                    child: Center(
                      child: Text(
                        "Your cart is empty.",
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.grey[400],
                        ),
                      ),
                    ),
                  )
                      : Expanded(
                    child: ListView.builder(
                      itemCount: userCart.length,
                      itemBuilder: (context, index) {
                        final cartItem = userCart[index];
                        return MyCartTile(cartItem: cartItem);
                      },
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Container(
                height: 60,
                width: 225,
                child: ElevatedButton(
                  onPressed: () async {
                    LatLng sourceLocation =
                    const LatLng(43.664191714479635, -79.39623146137073);
                    LatLng destination =
                    const LatLng(43.668910354936365, -79.39777641370725);
                    await DatabaseService().addItems(userCart);
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => OrderTrackingPage(
                                sourceLocation: sourceLocation,
                                destination: destination)));
                  },
                  child: Text("Proceed to Checkout"),
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.pink,
                      foregroundColor: Colors.white,
                  ),
                ),
              ),
            ),
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
          margin: const EdgeInsets.only(left: 16, right: 16, top: 8),
          child: Card(
            elevation: 2,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            child: ListTile(
              contentPadding: const EdgeInsets.all(16),
              leading: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.asset(
                  cartItem.food.imagePath,
                  height: 60,
                  width: 60,
                  fit: BoxFit.cover,
                ),
              ),
              title: Text(
                cartItem.food.name,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(fontSize: 14),
              ),
              subtitle: Text("\$" + cartItem.food.price.toString(), style: TextStyle(fontSize: 12)),
              trailing: QuantitySelector(
                quantity: cartItem.quantity,
                food: cartItem.food,
                onIncrement: () {
                  restaurant.addToCart(cartItem.food);
                },
                onDecrement: () {
                  restaurant.removeFromCart(cartItem);
                },
              ),
            ),
          ),
        ));
  }
}