import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService {

  final String uid;
  DatabaseService({ required this.uid });
  // collection reference
  final CollectionReference userCollection = FirebaseFirestore.instance.collection('Users');
  final CollectionReference restaurantCollection = FirebaseFirestore.instance.collection('Restaurants');

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

  // User Stream
  Stream<QuerySnapshot> get users {
    return userCollection.snapshots();
}
  Stream<QuerySnapshot> get restaurants {
    return restaurantCollection.snapshots();
  }
}

