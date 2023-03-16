import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:grad_chain/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:grad_chain/screens/home_screen.dart';
import 'package:provider/provider.dart';
import 'package:grad_chain/models/user.dart' as model;

class WebScreenLayout extends StatefulWidget {
  const WebScreenLayout({super.key});

  @override
  State<WebScreenLayout> createState() => _WebScreenLayoutState();
}

class _WebScreenLayoutState extends State<WebScreenLayout> {
  // THIS CODE IS FOR TESTING GETTING USER DATA FROM FIRESTORE
  // String username = "";

  // @override
  // void initState() {
  //   super.initState();
  //   getUsername();
  // }

  // void getUsername() async {
  //   DocumentSnapshot snap = await FirebaseFirestore.instance
  //       .collection('users')
  //       .doc(FirebaseAuth.instance.currentUser!.uid)
  //       .get();

  //   setState(() {
  //     username = (snap.data() as Map<String, dynamic>)['username'];
  //   });
  // }

  Future NavigateTo(int cli_type) {
    switch (cli_type) {
      case 0:
        break;
      case 1:
        break;
      case 2:
        break;
      default:
    }
    return Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => const HomeScreen(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final model.User? user = Provider.of<UserProvider>(context).getUser;

    switch (user?.cli_type) {
      case 0:
        break;
      case 1:
        break;
      case 2:
        break;
      default:
    }

    return user == null
        ? const Center(
            child: CircularProgressIndicator(),
          )
        : user.photoUrl == null
            ? Center(child: Text(user.username))
            : Scaffold(
                body: Center(
                  child: Text(user.username),
                ),
              );

    // return Scaffold(
    //   body: Center(
    //     child: Text('This is web'),
    //   ),
    // );
  }
}
