import 'dart:js';

import 'package:flutter/material.dart';
import 'package:grad_chain/models/user.dart' as model;

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:grad_chain/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:grad_chain/models/user.dart' as model;

import '../screens/home_screen.dart';

model.User? user = Provider.of<UserProvider>(context as BuildContext).getUser;

var defaultBackgroundColor = Colors.grey[300];
var appBarColor = Colors.grey[400];
var myAppBar = AppBar(
  backgroundColor: appBarColor,
  title: Image.asset(
    'assets/images/gradchain_logo.png',
    width: 200,
  ),
);
var drawerTextColor = TextStyle(
  color: Colors.grey[600],
);

var tilePadding = const EdgeInsets.only(left: 8, right: 8, top: 8);

// @override
// Widget build(BuildContext context) {
//   final model.User? user = Provider.of<UserProvider>(context).getUser;

//   return user == null
//       ? const Center(
//           child: CircularProgressIndicator(),
//         )
//       : user.photoUrl == null
//           ? Center(
//               child: Text(
//               user.username,
//               style: TextStyle(color: Colors.white),
//             ))
//           : Scaffold(
//               body: Center(
//                 child: Text('This is web'),
//               ),
//             );
// }

var myDrawer = Drawer(
  backgroundColor: Colors.grey[300],
  elevation: 0,
  child: Column(
    children: [
      DrawerHeader(
        child: ListTile(
          leading: Icon(Icons.person),
          title: Text(
            'hu',
            //user!.username,
            style: drawerTextColor,
          ),
        ),
      ),
      SizedBox(
        height: 300,
      ),
      Padding(
        padding: tilePadding,
        child: ListTile(
          leading: Icon(Icons.share),
          title: Text(
            'S H A R E',
            style: drawerTextColor,
          ),
        ),
      ),
      Padding(
        padding: tilePadding,
        child: ListTile(
          leading: OutlinedButton(
            onPressed: () {
              Navigator.push(
                context as BuildContext,
                MaterialPageRoute(builder: (context) => const HomeScreen()),
              );
            },
            child: Icon(Icons.logout),
          ),
          title: Text(
            'L O G O U T',
            style: drawerTextColor,
          ),
        ),
      ),
    ],
  ),
);
