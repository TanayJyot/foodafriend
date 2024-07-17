import "package:flutter/material.dart";
import 'package:buildspace_s5/receiver/screens/heropage/item_screens/items_screen_components/my_button.dart';
import "package:buildspace_s5/models/food.dart";
import "package:buildspace_s5/models/restaurant.dart";
import "package:provider/provider.dart";

class FoodPage extends StatefulWidget {
  final Food food;
  const FoodPage({super.key, required this.food});

  @override
  State<FoodPage> createState() => _FoodPageState();
}

class _FoodPageState extends State<FoodPage> {
  // method to add to cart

  void addToCart(Food food) {
    // close current page to go to home

    Navigator.pop(context);

    context.read<Restaurant>().addToCart(food);
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // scaffold UI

        Scaffold(
          body: Column(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(50),
                child: Image.asset(
                  widget.food.imagePath,
                  height: 500,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(25.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // food name
                    Text(
                      widget.food.name,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),

                    // food price
                    Text(
                      '\$${widget.food.price}',
                      style: TextStyle(
                          fontSize: 16,
                          color: Theme.of(context).colorScheme.primary),
                    ),
                    const SizedBox(
                      height: 10,
                    ),

                    // food description
                    Text(
                      widget.food.description,
                      style: const TextStyle(
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                  ],
                ),
              ),
              // add to cart button
              MyButton(
                text: "Add To Cart",
                onTap: () => addToCart(widget.food),
              ),

              const SizedBox(
                height: 25,
              )
            ],
          ),
        ),

        // back button UI
        SafeArea(
          child: Opacity(
            opacity: 0.6,
            child: Container(
              margin: const EdgeInsets.only(
                left: 25,
              ),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.secondary,
                shape: BoxShape.circle,
              ),
              child: IconButton(
                icon: const Icon(Icons.arrow_back_ios_new_rounded),
                onPressed: () => Navigator.pop(context),
              ),
            ),
          ),
        )
      ],
    );
  }
}
