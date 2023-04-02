import 'package:clipboard/clipboard.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:grad_chain/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:grad_chain/models/user.dart' as model;

import '../../models/student.dart';
import '../../screens/index/home_screen.dart';
import '../../utils/list_widget.dart';
import '../../utils/my_box.dart';
import '../../utils/my_title.dart';
import '../../widgets/constrants.dart';

class MobileScreenLayout extends StatefulWidget {
  const MobileScreenLayout({super.key});

  @override
  State<MobileScreenLayout> createState() => _MobileScreenLayoutState();
}

class _MobileScreenLayoutState extends State<MobileScreenLayout> {
  String username = "";

  @override
  Widget build(BuildContext context) {
    final Student? stu = Provider.of<UserProvider>(context).getStu;
    return stu == null
        ? const Center(
            child: CircularProgressIndicator(),
          )
        : stu.photoUrl == null
            ? Center(
                child: Text(
                stu.username,
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
                            stu.username,
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
                              FlutterClipboard.copy('${stu.username}');
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
                        aspectRatio: 8 / 5,
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

                      SizedBox(height: 15),
                      Expanded(child: ListWidget()),
                    ],
                  ),
                ),
              );
  }
}
