import "package:flutter/material.dart";
import "package:buildspace_s5/components/my_quantity_selector.dart";
import "package:buildspace_s5/models/cart_item.dart";
import "package:buildspace_s5/models/restaurant.dart";
import "package:provider/provider.dart";

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

                        // quantitiy bar
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
