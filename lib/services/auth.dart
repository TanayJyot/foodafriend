
import 'package:buildspace_s5/models/user.dart';
import 'package:buildspace_s5/services/database.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../enums/user_type_enum.dart';

class AuthService {

  final FirebaseAuth _auth = FirebaseAuth.instance;

  // create user obj based on firebase user
  MyUser? _userFromCredUser(User? user) {
    return user != null ? MyUser(uid: user.uid) : null;
  }



  // auth change user stream
  Stream<MyUser?> get user {
    return _auth.authStateChanges()
        .map((User? user) => _userFromCredUser(user));
  }


  // sign in anon
  Future signInAnon() async {
    try {
      UserCredential result = await _auth.signInAnonymously();
      User? user = result.user;
      return _userFromCredUser(user);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

// sign in with email and password
  Future signInWithEmailAndPassword(String email, String password) async {
    try{
      UserCredential result = await _auth.signInWithEmailAndPassword(email: email, password: password);
      User? user = result.user;
      return _userFromCredUser(user);
    } catch (e){
      print(e.toString());
      return null;
    }
  }


// register with email and password
  Future registerWithEmailAndPassword(String email, String password, String name, String details, String category, String affiliation) async {
    try{
      UserCredential result = await _auth.createUserWithEmailAndPassword(email: email, password: password);
      User? user = result.user;

      // String name = 'new member 001';
      // String details = 'Hi I am a computer science student at the university of toronto';
      // String affiliation = 'University of Toronto'; // TODO Make an enum for this to handle university choices\
      // // String homeAddress = '55 Centre Avenue'; //TODO Somehow link this to google maps and retrieve postal code
      // // String workAddress = "King's college Circle";





      // create a new document with the user
      await DatabaseService(uid: user!.uid).updateUserData(name, email, category, details, affiliation);

      return _userFromCredUser(user);
    } catch (e){
      print(e.toString());
      return null;
    }
  }

// sign out
Future signOut() async{
    try{
      return await _auth.signOut();
    }catch(e){
      print(e.toString());
      return null;
    }
}

}