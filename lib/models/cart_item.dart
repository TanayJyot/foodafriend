
import 'package:buildspace_s5/models/food.dart';

class CartItem {
  Food food;
  int quantity;

  CartItem({
    required this.food,
    this.quantity = 1,
  });

  double get totalPrice {
    return (food.price * quantity);
  }
}
