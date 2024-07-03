import 'package:buildspace_s5/enums/user_type_enum.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService {

  final String uid;
  DatabaseService({ required this.uid });
  // collection reference
  final CollectionReference userCollection = FirebaseFirestore.instance.collection('Users');

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

  // User Stream
  Stream<QuerySnapshot> get users {
    return userCollection.snapshots();
}
}

