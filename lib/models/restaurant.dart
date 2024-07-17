import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:buildspace_s5/models/cart_item.dart';

import 'food.dart';

class Restaurant extends ChangeNotifier {
  // list of food menu
  final List<Food> _menu = [
    // burgers
    Food(
        name: "Cheese Burger",
        description: "A beef burger with melted cheddar cheese",
        imagePath: "assets/item_images/burgers/burger1.jpeg",
        price: 2.99,
        category: FoodCategory.burgers),

    Food(
        name: "Chicken Burger",
        description: "A chicken burger with cheddar cheese, lettuce and tomato",
        imagePath: "assets/item_images/burgers/burger2.jpeg",
        price: 1.99,
        category: FoodCategory.burgers),

    Food(
        name: "Veggie Burger",
        description: "A veggie patty burger with tomato and pickles",
        imagePath: "assets/item_images/burgers/burger3.jpeg",
        price: 0.99,
        category: FoodCategory.burgers),

    Food(
        name: "Special Burger",
        description: "A special 5 cheese burger with seasoned beef patty",
        imagePath: "assets/item_images/burgers/burger4.jpeg",
        price: 4.99,
        category: FoodCategory.burgers),

    Food(
        name: "Normie Burger",
        description: "A normie",
        imagePath: "assets/item_images/burgers/burger5.jpeg",
        price: 1.99,
        category: FoodCategory.burgers),

  ];

  /*

  G E T T E R S

  */

  List<Food> get menu => _menu;
  List<CartItem> get cart => _cart;

  /*

  O P E R A T I O N S

  */

  // user cart

  final List<CartItem> _cart = [];

  // add to cart

  void addToCart(Food food) {
    CartItem? cartItem = _cart.firstWhereOrNull((item) {
      // check if the food items are same

      bool isSameFood = item.food == food;

      return isSameFood;
    });

    // if item exists increase quantity
    if (cartItem != null) {
      cartItem.quantity++;
    }

    // otherwise add new item

    else {
      _cart.add(CartItem(
        food: food,
      ));
    }
    notifyListeners();
  }

  // remove from cart

  void removeFromCart(CartItem cartItem) {
    int cartIndex = _cart.indexOf(cartItem);

    if (cartIndex != -1) {
      if (_cart[cartIndex].quantity > 1) {
        _cart[cartIndex].quantity--;
      } else {
        _cart.removeAt(cartIndex);
      }
    }

    notifyListeners();
  }

  // get total price of cart

  double getTotalPrice() {
    double total = 0.0;

    for (CartItem cartItem in _cart) {
      double itemTotal = cartItem.food.price;

      total += itemTotal * cartItem.quantity;
    }

    return total;
  }

  // get total number of items in cart
  int getTotalItemCount() {
    int totalItemCount = 0;

    for (CartItem cartItem in _cart) {
      totalItemCount += cartItem.quantity;
    }

    return totalItemCount;
  }

  // clear cart
  void clearCart() {
    _cart.clear();
    notifyListeners();
  }
  /*

  H E L P E R S

  // generate receipt

  // format double value into money

  */
}
