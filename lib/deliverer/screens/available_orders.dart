import 'package:buildspace_s5/deliverer/screens/order_tracking.dart';
import 'package:buildspace_s5/services/database.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../models/queue_model.dart';

class AvailableOrders extends StatefulWidget {
  final String location;
  const AvailableOrders({super.key, required this.location});

  @override
  State<AvailableOrders> createState() => _AvailableOrdersState();
}

class _AvailableOrdersState extends State<AvailableOrders> {
  static const LatLng sourceLocation = LatLng(37.33500926, -122.03272188);
  static const LatLng destination = LatLng(37.33429383, -122.06600055);

  Future<Iterable<OrderQueue>> _fetchOrderQueue() async {
    QuerySnapshot snapshot = await FirebaseFirestore.instance
        .collection('Order Queue')
        .get();
    return await DatabaseService().orderQueueFromSnapshot(snapshot);
  }

  void _deleteOrder(String documentId) async {
    try {
      await FirebaseFirestore.instance.collection('Order Queue')
          .doc(documentId)
          .delete();
    } catch (e) {
      print(e);
    }
  }


  Widget orderCard(
      {required String name,
      required String item,
      required String restaurant,
      required String distance,
      required String address,
      required String eta,
      required String documentId,
      }) {
    return Column(
      children: [
        GestureDetector(
          onTap: () {
            Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => OrderTrackingPage(sourceLocation: sourceLocation, destination: destination, name: name, item: item,),
            ));
            _deleteOrder(documentId);

          },
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Row(
              children: [
                // text food details
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(restaurant),
                      Text(
                        '$distance, ETA: $eta',
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.primary,
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        "$name would like a $item from $restaurant on $address",
                        style: TextStyle(
                            color:
                                Theme.of(context).colorScheme.inversePrimary),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  width: 15,
                ),

                // // food image
                // ClipRRect(
                //   borderRadius: BorderRadius.circular(18),
                //   child: Image.asset(
                //     "food.imagePath",
                //     height: 120,
                //   ),
                // ),
              ],
            ),
          ),
        ),

        // divider line
        Divider(
          color: Theme.of(context).colorScheme.primary,
          endIndent: 25,
          indent: 25,
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Available Orders"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Text(
                "Would you like to pick up any of these orders on your way to ${widget.location}?",
                style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                    color: Theme.of(context).colorScheme.inversePrimary),
              ),
            ),
            Divider(
              color: Theme.of(context).colorScheme.primary,
              endIndent: 25,
              indent: 25,
            ),

        FutureBuilder<Iterable<OrderQueue>>(
        future: _fetchOrderQueue(),
    builder: (context, snapshot) {
      if (snapshot.connectionState == ConnectionState.waiting) {
        return const CircularProgressIndicator();
      } else if (snapshot.hasError) {
        return Text('Error: ${snapshot.error}');
      } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
        return const Text('No orders available');
      } else {
        return Column(
          children: snapshot.data!.map((order) {
            return orderCard(
              name: order.name ?? "Default",
              item: order.item ?? "Default",
              restaurant: "Tim Hortons",
              // Adjust this as needed
              distance: "2 km",
              // Adjust this as needed
              address: "23 Bloor St",
              // Adjust this as needed
              eta: "25 min walk", // Adjust this as needed
              documentId: order.id ?? "Default",
            );
          }).toList(),
        );
      }
      // orderCard(
      //     name: "Alex",
      //     item: "Medium White Hot Chocolate",
      //     restaurant: "Tim Hortons",
      //     distance: "2 km",
      //     address: "23 Bloor St",
      //     eta: "25 min walk"),
      // orderCard(
      //     name: "James",
      //     item: "McChicken",
      //     restaurant: "McDonalds",
      //     distance: "1.4 km",
      //     address: "55 Bloor St",
      //     eta: "15 min walk"),
      // orderCard(
      //     name: "Rob",
      //     item: "Foot Long Cookie",
      //     restaurant: "SubWay",
      //     distance: "0.3 km",
      //     address: "82 Bloor St",
      //     eta: "2 min walk"),
    })],
        ),
      ),
    );
  }
}
