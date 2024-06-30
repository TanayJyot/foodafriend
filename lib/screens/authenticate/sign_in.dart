import 'package:buildspace_s5/services/auth.dart';
import 'package:flutter/material.dart';

class SignIn extends StatefulWidget {

  final toggleView;
  const SignIn({super.key, required this.toggleView});

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {

  final AuthService _auth = AuthService();
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
        title: Text(
          'Sign in to Food a Friend',
        style: TextStyle(color: Colors.white),
        ),
        actions: <Widget>[
          TextButton.icon(
              onPressed: () {
                widget.toggleView();
              },
              icon: Icon(Icons.person,
              color: Colors.white,),
            label: Text('Register',
            style: TextStyle(
              color: Colors.white
            ),),

          )
        ],
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
        child: Form(
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
              SizedBox(height: 20.0),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.pink[400]
                ),
                  onPressed: () async {
                  print(email);
                  print(password);
                  },
                  child: const Text(
                    'Sign In',
                    style: TextStyle(color: Colors.white),
                  )
              ),

            ],
          )
        )
      ),
    );
  }
}


// TODO Create an anonymous sign in in the future
// ElevatedButton(
// child: Text('sign in anon'),
// onPressed: () async {
// dynamic result = await _auth.signInAnon();
// if(result == null){
// print('error signing in');
// } else {
// print('signed in');
// print(result.uid);
// }
// },
// ),
