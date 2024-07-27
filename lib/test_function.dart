import 'package:buildspace_s5/services/database.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'models/queue_model.dart';


class TestOrderQueue extends StatelessWidget {
  final DatabaseService databaseService = DatabaseService();

  TestOrderQueue({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Test Order Queue"),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () async {
            QuerySnapshot snapshot = await databaseService.orderQueue.get();
            Iterable<OrderQueue> orderQueueList = await databaseService.orderQueueFromSnapshot(snapshot);
            for (var order in orderQueueList) {
              print('Order: ${order.item}, User: ${order.name}');
            }
          },
          child: const Text("Test Order Queue"),
        ),
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: TestOrderQueue(),
  ));
}