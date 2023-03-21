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

class _ListScreenState extends State<ListScreen> {

  List<Reference> _files = [];

  @override
  void initState() {
    super.initState();
    _listFiles;
  }

  Future<void> _listFiles() async {
    final storage = FirebaseStorage.instance;
    final dir = storage.ref(widget.directoryPath);
    final files = await dir.listAll();
    setState(() {
      _files = files.items;
    });
  }

  void returnToPrevious() {
    //TODO: Add a way to return to the previous menu, assuming that this isn't a tab.
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text(widget.directoryPath)),
        body: _buildBody()
    );
  }

  Widget _buildBody() {
    if (_files == null) {
      return Center(child: CircularProgressIndicator());
    } else if (_files.isEmpty) {
      return Center(child: Text('No files found.'));
    } else {
      return ListView.builder(
        itemCount: _files.length,
        itemBuilder: (BuildContext context, int index) {
          final file = _files[index];
          return ListTile(
            title: Text(file.name),
            trailing: Icon(Icons.arrow_forward),
            onTap: () {
              //TODO: Add code to navigate to the file details screen.
            },
          );
        },
      );
    }
  }
}