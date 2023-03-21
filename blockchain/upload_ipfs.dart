import 'package:flutter/material.dart';
import 'package:flutter_ipfs/flutter_ipfs.dart';

import 'dart:typed_data';

import 'package:grad_chain/resources/auth_methods.dart';
import 'package:grad_chain/screens/login_screen.dart';
import 'package:grad_chain/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:image_picker/image_picker.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 25),
        child: Center(
          child: ElevatedButton(
            onPressed: () => ImagePickerService.pickImage(context),
            child: const SizedBox(
              height: 50,
              child: Center(
                child: Text(
                  'Upload Image',
                  style: TextStyle(fontSize: 18, fontFamily: 'Brand-Bold'),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
