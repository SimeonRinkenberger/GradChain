//TODO: Add a way to access this screen from existing screens.
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

  void filter(){
    //TODO: add a filter function. Subject to possible removal.
  }

  void returnToPrevious(){
    //TODO: Add a way to return to the previous menu, assuming that this isn't a tab.
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color.fromARGB(255, 23, 67, 24)
            //TODO: Finish Implementation
    );
    throw UnimplementedError();
  }

}