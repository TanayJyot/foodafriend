import 'package:buildspace_s5/shared/constants.dart';
import 'package:flutter/material.dart';

import '../../services/auth.dart';

class Register extends StatefulWidget {

  final toggleView;
  const Register({super.key, required this.toggleView});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {

  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();

  // text field state
  String email = '';
  String password = '';
  String error = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.brown[100],
      appBar: AppBar(
        backgroundColor: Colors.brown[400],
        elevation: 0.0,
        title: const Text(
          'Sign up to Food a Friend',
          style: TextStyle(color: Colors.white),
        ),
        actions: <Widget>[
          TextButton.icon(
            onPressed: () {
              widget.toggleView();
            },
            icon: Icon(Icons.person,
              color: Colors.white,),
            label: Text(
              'Register',
              style: TextStyle(
                  color: Colors.white
              ),),

          )
        ],
      ),
      body: Container(
          padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
          child: Form(
            key: _formKey,
              child: Column(
                children: <Widget>[
                  const SizedBox(height: 20),
                  TextFormField(
                    decoration: textInputDecoration.copyWith(hintText: 'Email'),
                    validator: (val) => val!.isEmpty ? "Enter an email" : null,
                    onChanged: (val){
                      setState(() => email = val);
                    },
                  ),
                  const SizedBox(height: 20),
                  TextFormField(
                    decoration: textInputDecoration.copyWith(hintText: 'Password'),
                    validator: (val) => val!.length < 6 ? "Enter a password 6+ chars long" : null,
                    obscureText: true,
                    onChanged:(val){
                      setState(() => password = val);
                    } ,
                  ),
                  const SizedBox(height: 20.0),
                  ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.pink[400]
                      ),
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                          dynamic result = await _auth.registerWithEmailAndPassword(email, password);
                          if (result == null){
                            setState(() => error = 'Please supply a valid email');
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
                    style: TextStyle(color: Colors.red, fontSize: 14.0),
                  ),


                ],
              )
          )
      ),
    );;
  }
}
