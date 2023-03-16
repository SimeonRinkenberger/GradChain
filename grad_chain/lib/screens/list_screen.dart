import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:grad_chain/utils/colors.dart';
import 'package:grad_chain/utils/utils.dart';

import '../responsive/mobile_screen_layout.dart';
import '../responsive/responsive_layout_screen.dart';
import '../responsive/web_screen_layout.dart';

class ListScreen extends StatefulWidget{
  const ListScreen(
  {super.key}
      );
  @override
  State<ListScreen> createState() => _ListScreenState();
}

class _ListScreenState extends State<ListScreen>{
  void displayDiplomas(){
    //TODO: Figure out a way to display a list of diplomas on screen.
  }

  void uploadFiles(){
    // Create a storage reference from our app
    final storageRef = FirebaseStorage.instance.ref();

// Create a reference to "mountains.jpg"
    final mountainsRef = storageRef.child("mountains.jpg");

// Create a reference to 'images/mountains.jpg'
    final mountainImagesRef = storageRef.child("images/mountains.jpg");

// While the file names are the same, the references point to different files
    assert(mountainsRef.name == mountainImagesRef.name);
    assert(mountainsRef.fullPath != mountainImagesRef.fullPath);
    //TODO: Rewrite above code so as to allow the uploading of .csv files
  }

  void filter(){
    //TODO: add a filter function. Subject to possible removal.
  }

  void returnToPrevious(){
    //TODO: Add a way to return to the previous menu, assuming that this isn't a tab.
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color.fromARGB(255, 23, 67, 24),
        body: Column(
          children:[
            Text(
              'No files found',
              style: TextStyle(
                fontSize: 70,
                fontWeight: FontWeight.bold,
        )
            )
          ]
        )
      //TODO: Finish Implementation
    );
    throw UnimplementedError();
  }

}