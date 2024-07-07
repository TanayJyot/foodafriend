import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

final ImagePicker _imagePicker = ImagePicker();
String? imageUrl;

Future<void> pickImage(BuildContext context) async {
  try {
    XFile? res = await _imagePicker.pickImage(source: ImageSource.gallery);
    if (res != null){
      await uploadImageToFirebase(File(res.path), context);
    }
  } catch (e) {
    ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: Colors.red,
        content: Text("Failed to pick image $e")
    )
    );
  }
}

Future<void> uploadImageToFirebase(File image, BuildContext context) async {
  try{
    Reference reference = FirebaseStorage.instance.ref().child("images/${DateTime.now().microsecondsSinceEpoch}.png");
    await reference.putFile(image).whenComplete(() {
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
              backgroundColor: Colors.green,
              duration: Duration(seconds: 2),
              content: Text("Upload Successful ")
          )
      );
    });
    imageUrl = await reference.getDownloadURL();
  } catch(e) {
    ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
            backgroundColor: Colors.red,
            content: Text("Failed to pick image at database $e")
        )
    );
  }
}