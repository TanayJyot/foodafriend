import 'dart:async';

import 'package:buildspace_s5/pages/food_page.dart';
import 'package:buildspace_s5/pages/home_page.dart';
import 'package:buildspace_s5/services/auth.dart';
import 'package:buildspace_s5/vid_pages/available_orders.dart';
import 'package:flutter/material.dart';

class Heropage extends StatefulWidget {
  Heropage({super.key});

  @override
  State<Heropage> createState() => _HeropageState();
}

class _HeropageState extends State<Heropage> {
  final AuthService _auth = AuthService();
  late Timer timer;

  void _dummy_popup(BuildContext context) async {
    TextEditingController editingController = TextEditingController();
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            scrollable: true,
            title: Text('Where are you heading?'),
            content: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Form(
                child: Column(
                  children: <Widget>[
                    TextFormField(
                      controller: editingController,
                      decoration: InputDecoration(
                        labelText: 'Location',
                        icon: Icon(Icons.location_pin),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            actions: [
              ElevatedButton(
                  child: Text("Submit"),
                  onPressed: () {
                    Navigator.of(context).pushReplacement(MaterialPageRoute(
                        builder: (context) => AvaialableOrders(
                            location: editingController.text)));
                  })
            ],
          );
        });
  }

  void _showBanner(BuildContext context) {
    final snackBar = SnackBar(
      duration: Duration(seconds: 100),
      content: const Text('Are you heading somewhere?'),
      showCloseIcon: true,
      action: SnackBarAction(
        label: 'Yes',
        onPressed: () {
          ScaffoldMessenger.of(context).hideCurrentSnackBar();
          _dummy_popup(context);
        },
      ),
    );

    ScaffoldMessenger.of(context).showSnackBar(snackBar);

    // ScaffoldMessenger.of(context).showMaterialBanner(
    //   MaterialBanner(
    //     content: const Text('Are you heading somewhere?'),
    //     actions: [
    //       TextButton(
    //         child: const Text('Yes'),
    //         onPressed: () {
    //           ScaffoldMessenger.of(context).hideCurrentMaterialBanner();
    //           _dummy_popup(context);
    //         },
    //       ),
    //       TextButton(
    //         child: const Text('No'),
    //         onPressed: () =>
    //             ScaffoldMessenger.of(context).hideCurrentMaterialBanner(),
    //       ),
    //     ],
    //   ),
    // );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    timer = Timer(Duration(seconds: 2), () {
      // _dummy_popup(context);
      _showBanner(context);
    });
    // _dummy_popup(context);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    timer.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.brown[50],
      // appBar: AppBar(
      //   title: const Text('Food a friend'),
      //   backgroundColor: Colors.brown[400],
      //   elevation: 0.0,
      //   actions: <Widget>[
      //     TextButton.icon(
      //       icon: const Icon(Icons.person),
      //       // onPressed: () async {
      //       //   await _auth.signOut();
      //       // },
      //       onPressed: () {
      //         _dummy_popup(context);
      //       },
      //       label: const Text('logout'),
      //     )
      //   ],
      // ),
      body: HomePage(),
    );
  }
}
