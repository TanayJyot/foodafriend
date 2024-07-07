import 'package:buildspace_s5/screens/authenticate/register_restaurant.dart';
import 'package:buildspace_s5/screens/authenticate/sign_in_restaurant.dart';
import 'package:flutter/material.dart';

class AuthenticateRestaurant extends StatefulWidget {
  const AuthenticateRestaurant({super.key});

  @override
  _AuthenticateRestaurantState createState() => _AuthenticateRestaurantState();
}

class _AuthenticateRestaurantState extends State<AuthenticateRestaurant> {

  bool showSignIn = true;

  toggleView() {setState(() => showSignIn = !showSignIn);   }

  @override
  Widget build(BuildContext context) {
    if (showSignIn) {
      return SignInRestaurant(toggleView: toggleView);
    } else {
      return RegisterRestaurant(toggleView: toggleView);
    }
  }
}



