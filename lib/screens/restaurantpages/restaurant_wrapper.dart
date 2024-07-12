import 'package:buildspace_s5/models/user.dart';
import 'package:buildspace_s5/screens/authenticate/authenticate_restaurant.dart';
import 'package:buildspace_s5/screens/heropage/add_item.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RestaurantWrapper extends StatelessWidget {
  const RestaurantWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    final restaurant = Provider.of<MyUser?>(context);
    print(restaurant);

    // check if there is some user logged in
    if (restaurant == null){
      return const AuthenticateRestaurant();
    } else {
      return AddItem(restaurantId: restaurant.uid!);
    }

  }
}
