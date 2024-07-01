import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService {

  final String uid;
  DatabaseService({ required this.uid });
  // collection reference
  final CollectionReference userCollection = FirebaseFirestore.instance.collection('Users');

  Future updateUserData(
      String name,
      bool isDeliverer,
      String details,
      String affiliation,
      String homeAddress,
      String workAddress
      ) async {
    return await userCollection.doc(uid).set({
      'name': name,
      'isDeliverer': isDeliverer,
      'details': details,
      'affiliation': affiliation,
      'homeAddress': homeAddress,
      'workAddress': workAddress, // need these to track commute in the future
    });
  }

  // User Stream
  Stream<QuerySnapshot> get users {
    return userCollection.snapshots();
}
}