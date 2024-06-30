import 'package:buildspace_s5/models/user.dart';
import 'package:buildspace_s5/screens/authenticate/authenticate.dart';
import 'package:buildspace_s5/screens/heropage/heropage.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Wrapper extends StatelessWidget {
  const Wrapper({super.key});

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<MyUser?>(context);
    print(user);

    // check if there is some user logged in
    if (user == null){
      return Authenticate();
    } else {
      return Heropage();
    }

  }
}
