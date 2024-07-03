import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider/provider.dart';

class RestaurantList extends StatefulWidget {
  const RestaurantList({super.key});

  @override
  State<RestaurantList> createState() => _RestaurantListState();
}

class _RestaurantListState extends State<RestaurantList> {
  @override
  Widget build(BuildContext context) {
    final restaurants = Provider.of<QuerySnapshot>(context);
    print(restaurants);

    return const Placeholder();
  }
}
