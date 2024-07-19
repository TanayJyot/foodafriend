import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../models/cart_item.dart';

class DatabaseService {
  final String? uid;
  DatabaseService({this.uid});
  // collection reference
  final CollectionReference userCollection =
      FirebaseFirestore.instance.collection('Users');
  final CollectionReference restaurantCollection =
      FirebaseFirestore.instance.collection('Restaurants');
  final CollectionReference orderQueue =
      FirebaseFirestore.instance.collection('Order Queue');

  Future updateUserData(
    String name,
    String email,
    String category,
    String details,
    String affiliation,
  ) async {
    return await userCollection.doc(uid).set({
      'name': name,
      'email': email,
      'category': category,
      'details': details,
      'affiliation': affiliation,
      // TODO Link this to the address model
      // need these to track commute in the future
    });
  }

  Future getRestaurants() async {
    QuerySnapshot restaurantsSnapshot = await restaurantCollection.get();
    List restaurants = [];
    for (QueryDocumentSnapshot doc in restaurantsSnapshot.docs) {
      restaurants.add(doc.data());
    }
    print(restaurants);
    return restaurants;
  }

  Future updateRestaurantData(
    String name,
    String address,
    String phone,
    String hours, // TODO Find a way to set this up properly
  ) async {
    await restaurantCollection.doc(uid).set({
      'name': name,
      'address': address,
      'phone': phone,
      'hours': hours,
    });
  }

  Future addItems(List<CartItem> itemList) async {

    List<Map<String, dynamic>> listOfItems= [];
    for (final item in itemList){
      listOfItems.add({
        "name": item.food.name,
        "price": item.food.price,
        "quantity": item.quantity
      });
    }
    try {
      final user = FirebaseAuth.instance.currentUser;
      final uid = user?.uid;

      // Create a new item document in the restaurant's items subcollection
      await orderQueue.add({
        'itemList': listOfItems,
        'timestamp': Timestamp.now(),  // Optional: Add a timestamp for order
        'user_id': uid,
      });
    } catch (e) {
      print('Error adding items to Firestore: $e');
      // Optionally, you can show a snackbar or dialog to inform the user of the error
    }
  }




  // User Stream
  Stream<QuerySnapshot> get users {
    return userCollection.snapshots();
  }

  Stream<QuerySnapshot> get restaurants {
    return restaurantCollection.snapshots();
  }

    Stream<QuerySnapshot> get orders {
    return orderQueue.snapshots();
  }


}
