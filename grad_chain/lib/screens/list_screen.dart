import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'dart:html';
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

  late List<Reference> _files;

  @override
  void initState() {
    super.initState();
    _listFiles;
  }

  Future<void> _listFiles() async{
    final storage = FirebaseStorage.instance;
    final dir = storage.ref(widget.directoryPath);
    final files = await dir.listAll();
    setState(() {
      _files = files.items;
    });
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