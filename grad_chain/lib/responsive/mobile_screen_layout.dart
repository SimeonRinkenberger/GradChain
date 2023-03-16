import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:grad_chain/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:grad_chain/models/user.dart' as model;

import '../screens/home_screen.dart';
import '../utils/my_box.dart';
import '../utils/my_title.dart';
import 'constrants.dart';

class MobileScreenLayout extends StatefulWidget {
  const MobileScreenLayout({super.key});

  @override
  State<MobileScreenLayout> createState() => _MobileScreenLayoutState();
}

class _MobileScreenLayoutState extends State<MobileScreenLayout> {
  String username = "";

  @override
  Widget build(BuildContext context) {
    final model.User? user = Provider.of<UserProvider>(context).getUser;
    return user == null
        ? const Center(
            child: CircularProgressIndicator(),
          )
        : user.photoUrl == null
            ? Center(
                child: Text(
                user.username,
                style: TextStyle(color: Colors.white),
              ))
            : Scaffold(
                backgroundColor: defaultBackgroundColor,
                appBar: myAppBar,
                drawer: Drawer(
                  backgroundColor: Colors.grey[300],
                  elevation: 0,
                  child: Column(
                    children: [
                      DrawerHeader(
                        child: ListTile(
                          leading: Icon(Icons.person),
                          //leading: Image.network('${user.photoUrl}'),
                          title: Text(
                            //'hu',
                            user.username,
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
                          leading: OutlinedButton(
                            onPressed: () {
                              Navigator.push(
                                context as BuildContext,
                                MaterialPageRoute(
                                    builder: (context) => HomeScreen()),
                              );
                            },
                            child: Icon(Icons.share),
                          ),
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
                                MaterialPageRoute(
                                    builder: (context) => HomeScreen()),
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
                ),
                body: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      // first 4 boxes in grid
                      AspectRatio(
                        aspectRatio: 8 / 7,
                        child: SizedBox(
                          width: double.infinity,
                          child: GridView.builder(
                            itemCount: 2,
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 1),
                            itemBuilder: (context, index) {
                              return MyBox();
                            },
                          ),
                        ),
                      ),

                      // Notifications

                      Expanded(
                        child: ListView.builder(
                          itemCount: 5,
                          itemBuilder: (context, index) {
                            return const MyTile();
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              );
  }
}
