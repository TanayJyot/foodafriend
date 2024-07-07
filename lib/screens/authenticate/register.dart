import 'package:buildspace_s5/services/pick_image.dart';
import 'package:buildspace_s5/shared/constants.dart';
import 'package:buildspace_s5/shared/loading.dart';
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
  bool loading = false;

  // text field state
  String email = '';
  String password = '';
  String name = '';
  String details = '';
  String category = 'receiver';
  String affiliation = '';
  String error = '';

  @override
  Widget build(BuildContext context) {
    return loading
        ? const Loading()
        : Scaffold(
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
                  icon: const Icon(
                    Icons.person,
                    color: Colors.white,
                  ),
                  label: const Text(
                    'Register',
                    style: TextStyle(color: Colors.white),
                  ),
                )
              ],
            ),
            body: Container(
                padding: const EdgeInsets.symmetric(
                    vertical: 20.0, horizontal: 50.0),
                child: Form(
                    key: _formKey,
                    child: Column(
                      children: <Widget>[
                        Stack(children: [
                          CircleAvatar(
                              radius: 100,
                              child: imageUrl == null
                                  ? const Icon(
                                      Icons.person,
                                      size: 200,
                                      color: Colors.grey,
                                    )
                                  : SizedBox(
                                      height: 200,
                                      child: ClipOval(
                                          child: Image.network(
                                        imageUrl!,
                                        fit: BoxFit.cover,
                                      )),
                                    )),
                          Positioned(
                              right: 20,
                              top: 10,
                              child: GestureDetector(
                                onTap: () {
                                  try {
                                    pickImage(context);
                                  } catch (e) {}
                                },
                                child: const Icon(
                                  Icons.camera_alt,
                                  color: Colors.white,
                                  size: 35,
                                ),
                              ))
                        ]),
                        const SizedBox(height: 20),
                        TextFormField(
                          decoration:
                              textInputDecoration.copyWith(hintText: 'Name'),
                          validator: (val) =>
                              val!.isEmpty ? "Enter your name" : null,
                          onChanged: (val) {
                            setState(() => name = val);
                          },
                        ),
                        const SizedBox(height: 20),
                        TextFormField(
                          decoration:
                              textInputDecoration.copyWith(hintText: 'Email'),
                          validator: (val) =>
                              val!.isEmpty ? "Enter your email" : null,
                          onChanged: (val) {
                            setState(() => email = val);
                          },
                        ),
                        const SizedBox(height: 20),
                        TextFormField(
                          decoration: textInputDecoration.copyWith(
                              hintText: 'Password'),
                          validator: (val) => val!.length < 6
                              ? "Enter a password 6+ chars long"
                              : null,
                          obscureText: true,
                          onChanged: (val) {
                            setState(() => password = val);
                          },
                        ),
                        const SizedBox(height: 20),
                        TextFormField(
                          decoration: textInputDecoration.copyWith(
                              hintText: 'Tell us more about you!'),
                          // validator: (val) => val!.isEmpty ? "Enter your email" : null,
                          onChanged: (val) {
                            setState(() => details = val);
                          },
                        ),
                        const SizedBox(height: 20),
                        TextFormField(
                          decoration: textInputDecoration.copyWith(
                              hintText: 'Where do you study?'),
                          // validator: (val) => val!.isEmpty ? "Enter your email" : null,
                          onChanged: (val) {
                            setState(() => affiliation = val);
                          },
                        ),
                        const SizedBox(height: 20.0),
                        ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.pink[400]),
                            onPressed: () async {
                              if (_formKey.currentState!.validate()) {
                                setState(() {
                                  loading = true;
                                });
                                dynamic result =
                                    await _auth.registerWithEmailAndPassword(
                                        email,
                                        password,
                                        name,
                                        details,
                                        category,
                                        affiliation);
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
                            )),
                        const SizedBox(height: 12.0),
                        Text(
                          error,
                          style: const TextStyle(
                              color: Colors.red, fontSize: 14.0),
                        ),
                      ],
                    ))),
          );
  }
}

// TODO Add the roles that the user would want to play using UserType
