import 'package:buildspace_s5/services/auth.dart';
import 'package:buildspace_s5/shared/constants.dart';
import 'package:buildspace_s5/shared/loading.dart';
import 'package:flutter/material.dart';

class SignIn extends StatefulWidget {

  final toggleView;
  const SignIn({super.key, required this.toggleView});

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {

  final _formKey = GlobalKey<FormState>();

  final AuthService _auth = AuthService();
  bool loading = false;
  // text field state
  String email = '';
  String password = '';
  String error = '';


  @override
  Widget build(BuildContext context) {
    return loading? Loading() : Scaffold(
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
          key: _formKey,
          child: Column(
            children: <Widget>[
              SizedBox(height: 20),
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
              SizedBox(height: 20.0),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.pink[400]
                ),
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      setState(() => loading = true);
                      dynamic result = await _auth.signInWithEmailAndPassword(email, password);
                      if (result == null){
                        setState(() {
                          error = 'Could not sign in with those credentials';
                          loading = false;
                        });//TODO There is a way to get the error directly from firebase_auth here
                      }
                    }
                  },
                  child: const Text(
                    'Sign In',
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
// TODO I/flutter ( 7359): [firebase_auth/invalid-email] The email address is badly formatted.
// TODO THis is what firebase_auth is giving so find a way to access it directly


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
