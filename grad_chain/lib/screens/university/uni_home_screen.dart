import 'package:clipboard/clipboard.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:grad_chain/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:grad_chain/screens/index/landing_screen.dart';
import 'package:grad_chain/screens/university/add_diploma_screen.dart';
import 'package:grad_chain/utils/list_widget.dart';
import 'package:provider/provider.dart';
import 'package:grad_chain/models/user.dart' as model;

import '../../models/student.dart';
import '../../resources/auth_methods.dart';
import '../../widgets/constrants.dart';
import '../index/home_screen.dart';
import '../../utils/my_box.dart';
import '../../utils/my_title.dart';
import 'package:grad_chain/widgets/constrants.dart';
import 'package:grad_chain/utils/list_widget.dart';

class UniHomeScreen extends StatefulWidget {
  const UniHomeScreen({super.key});

  @override
  State<UniHomeScreen> createState() => _UniHomeScreenState();
}

class _UniHomeScreenState extends State<UniHomeScreen> {
  @override
  Widget build(BuildContext context) {
    final model.User? user = Provider.of<UserProvider>(context).getUser;
    final Student? stu = Provider.of<UserProvider>(context).getStu;

    return Scaffold(
      backgroundColor: defaultBackgroundColor,
      appBar: myAppBar,
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // open drawer
            Drawer(
              backgroundColor: Colors.grey[300],
              elevation: 0,
              width: 200,
              child: Column(
                children: [
                  DrawerHeader(
                    child: ListTile(
                      leading: CircleAvatar(
                        backgroundImage: NetworkImage(
                          user!.photoUrl,
                        ),
                      ),
                      //leading: Image.network('${user.photoUrl}'),
                      title: Text(
                        //'hu',
                        user!.username,
                        style: drawerTextColor,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.4,
                  ),
                  // Padding(
                  //   padding: tilePadding,
                  //   child: ListTile(
                  //     leading: OutlinedButton(
                  //       onPressed: () {
                  //         FlutterClipboard.copy('${user.username}');
                  //       },
                  //       child: Icon(Icons.share),
                  //     ),
                  //     title: Text(
                  //       'S H A R E',
                  //       style: drawerTextColor,
                  //     ),
                  //   ),
                  // ),
                  Padding(
                    padding: tilePadding,
                    child: ListTile(
                      leading: OutlinedButton(
                        onPressed: () async {
                          await AuthMethods().signOut();
                          Navigator.of(context).pushReplacement(
                            MaterialPageRoute(
                              builder: (context) => const LandingScreen(),
                            ),
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

            // first half of page
            Expanded(
                flex: 2,
                child: Column(children: [
                  SizedBox(height: 15),
                  Expanded(child: ListWidget()),
                  SizedBox(height: 10),
                ]))
          ],
        ),
      ),
    );
  }
}
