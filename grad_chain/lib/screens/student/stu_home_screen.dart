import 'package:clipboard/clipboard.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:grad_chain/models/student.dart';
import 'package:grad_chain/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:grad_chain/screens/index/landing_screen.dart';
import 'package:grad_chain/screens/university/add_diploma_screen.dart';
import 'package:grad_chain/utils/list_widget.dart';
import 'package:provider/provider.dart';
import 'package:grad_chain/models/user.dart' as model;

import '../../resources/auth_methods.dart';
import '../../widgets/constrants.dart';
import '../index/home_screen.dart';
import '../../utils/my_box.dart';
import '../../utils/my_title.dart';
import 'package:grad_chain/widgets/constrants.dart';
import 'package:grad_chain/utils/list_widget.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';

class StuHomeScreen extends StatefulWidget {
  const StuHomeScreen({super.key});

  @override
  State<StuHomeScreen> createState() => _StuHomeScreenState();
}

class _StuHomeScreenState extends State<StuHomeScreen> {
  @override
  Widget build(BuildContext context) {
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
                          stu!.photoUrl,
                        ),
                      ),
                      //leading: Image.network('${user.photoUrl}'),
                      title: Text(
                        //'hu',
                        stu.username,
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
                  //         FlutterClipboard.copy('${stu.photoUrl}');
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
