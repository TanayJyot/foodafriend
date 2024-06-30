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
                  SizedBox(height: 20),
                  TextField(
                    onChanged: (val){
                      setState(() => email = val);
                    },
                  ),
                  SizedBox(height: 20),
                  TextField(
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
                        if (_formKey.currentState.validate());
                      },
                      child: const Text(
                        'Register',
                        style: TextStyle(color: Colors.white),
                      )
                  ),

                ],
              )
          )
      ),
    );;
  }
}
