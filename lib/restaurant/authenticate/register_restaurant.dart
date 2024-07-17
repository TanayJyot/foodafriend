

import 'package:buildspace_s5/shared/constants.dart';
import 'package:buildspace_s5/shared/loading.dart';
import 'package:flutter/material.dart';
import '../../services/auth.dart';
import 'package:firebase_storage/firebase_storage.dart';

class RegisterRestaurant extends StatefulWidget {

  final toggleView;
  const RegisterRestaurant({super.key, required this.toggleView});

  @override
  State<RegisterRestaurant> createState() => _RegisterRestaurantState();
}

class _RegisterRestaurantState extends State<RegisterRestaurant> {

  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();
  bool loading = false;
  final storage = FirebaseStorage.instance;
  final storageRef = FirebaseStorage.instance.ref();

  // text field state
  String email = '';
  String password = '';
  String name = '';
  String address = '';
  String phone = ''; // TODO Change this to integers
  String hours = '';
  String error = '';

  @override
  Widget build(BuildContext context) {
    return loading ? const Loading() : Scaffold(
      backgroundColor: Colors.brown[100],
      appBar: AppBar(
        backgroundColor: Colors.brown[400],
        elevation: 0.0,
        title: const Text(
          'Partner with Food-A-Friend',
          style: TextStyle(color: Colors.white),
        ),
        actions: <Widget>[
          TextButton.icon(
            onPressed: () {
              widget.toggleView();
            },
            icon: const Icon(Icons.person,
              color: Colors.white,),
            label: const Text(
              'Register',
              style: TextStyle(
                  color: Colors.white
              ),),

          )
        ],
      ),
      body: Container(
          padding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 50.0),
          child: Form(
              key: _formKey,
              child: Column(
                children: <Widget>[
                  const SizedBox(height: 15),
                  TextFormField(
                    decoration: textInputDecoration.copyWith(hintText: 'Email'),
                    validator: (val) => val!.isEmpty ? "Enter an email" : null,
                    onChanged: (val) {
                      setState(() => email = val);
                    },
                  ),
                  const SizedBox(height: 15),
                  TextFormField(
                    decoration: textInputDecoration.copyWith(
                        hintText: 'Password'),
                    validator: (val) =>
                    val!.length < 6
                        ? "Enter a password 6+ chars long"
                        : null,
                    obscureText: true,
                    onChanged: (val) {
                      setState(() => password = val);
                    },
                  ),

                  const SizedBox(height: 15),
                  TextFormField(
                    decoration: textInputDecoration.copyWith(hintText: 'Name'),
                    validator: (val) => val!.isEmpty ? "Enter a name" : null,
                    onChanged: (val) {
                      setState(() => name = val);
                    },
                  ),
                  const SizedBox(height: 15),
                  TextFormField(
                    decoration: textInputDecoration.copyWith(
                        hintText: 'Address'),
                    validator: (val) =>
                    val!.isEmpty
                        ? "Enter an Address"
                        : null,
                    onChanged: (val) {
                      setState(() => address = val);
                    },
                  ),
                  const SizedBox(height: 15),
                  TextFormField(
                    decoration: textInputDecoration.copyWith(hintText: 'Phone'),
                    validator: (val) =>
                    val!.isEmpty
                        ? "Enter a phone number"
                        : null,
                    onChanged: (val) {
                      setState(() => phone = val);
                    },
                  ), const SizedBox(height: 15),
                  TextFormField(
                    decoration: textInputDecoration.copyWith(hintText: 'Hours'),
                    validator: (val) =>
                    val!.isEmpty
                        ? "Enter your hours of operation"
                        : null,
                    onChanged: (val) {
                      setState(() => hours = val);
                    },
                  ),

                  const SizedBox(height: 15.0),
                  ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.pink[400]
                      ),
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                          setState(() {
                            loading = true;
                          });
                          print(email);
                          dynamic result = await _auth
                              .registerRestaurantWithEmailAndPassword(
                              email, password, name, address, phone, hours);
                          if (result == null) {
                            setState(() {
                              error = 'Please supply a valid email';
                              loading = false;
                            });
                          }
                        }
                      },
                      child: const Text(
                        'Register',
                        style: TextStyle(color: Colors.white),
                      )
                  ),
                  const SizedBox(height: 12.0),
                  Text(
                    error,
                    style: const TextStyle(color: Colors.red, fontSize: 14.0),
                  ),

                ],
              )
          )
      ),
    );
  }

}