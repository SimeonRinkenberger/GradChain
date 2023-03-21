import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'dart:io';
import 'package:grad_chain/utils/colors.dart';
import 'package:grad_chain/utils/utils.dart';

import '../responsive/mobile_screen_layout.dart';
import '../responsive/responsive_layout_screen.dart';
import '../responsive/web_screen_layout.dart';

class ListScreen extends StatefulWidget{
  //TODO: We're going to have to rewrite this to access files on the cloud rather than on a local machine.
  final String directoryPath;

  ListScreen({required this.directoryPath});



 /* const ListScreen(
  {super.key}
      );*/
  @override
  State<ListScreen> createState() => _ListScreenState();
}

class _ListScreenState extends State<ListScreen>{


  Future<List<File>> listFiles(String directoryPath) async{
    final dir = Directory(directoryPath);
    if(!(await dir.exists())){
      throw Exception('Directory does not exist');
    }
    final files = await dir.list().where((entity) => entity is File).map((entity) => entity as File).toList();
    return files;
  }

  void returnToPrevious(){
    //TODO: Add a way to return to the previous menu, assuming that this isn't a tab.
  }




  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<File>>(
      future: listFiles(widget.directoryPath),
      builder: (BuildContext context, AsyncSnapshot<List<File>> snapshot) {
        if (snapshot.connectionState == ConnectionState.done && snapshot.hasData) {
          final files = snapshot.data!;
          return ListView.builder(
            itemCount: files.length,
            itemBuilder: (BuildContext context, int index) {
              return ListTile(
                title: Text(files[index].path),
              );
            },
          );
        } else if (snapshot.hasError) {
          return Text("Error: ${snapshot.error}");
        } else {
          return CircularProgressIndicator();
        }
      },
    );
  }

}