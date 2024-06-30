import 'package:buildspace_s5/services/auth.dart';
import 'package:flutter/material.dart';

class Heropage extends StatelessWidget {
  Heropage({super.key});
  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.brown[50],
      appBar: AppBar(
        title: const Text('Food a friend'),
        backgroundColor: Colors.brown[400],
        elevation: 0.0,
        actions: <Widget>[
          TextButton.icon(
            icon: const Icon(Icons.person),
            onPressed: () async {
              await _auth.signOut();
            },
            label: const Text('logout'),
          )
        ],
      ),
    );
  }
}

