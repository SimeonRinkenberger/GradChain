import 'package:clipboard/clipboard.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:grad_chain/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:grad_chain/screens/university/add_diploma_screen.dart';
import 'package:grad_chain/utils/claim_widget.dart';
import 'package:provider/provider.dart';
import 'package:grad_chain/models/user.dart' as model;

import '../../utils/stu_dip_list.dart';
import '../../widgets/constrants.dart';
import '../index/home_screen.dart';
import '../../utils/my_box.dart';
import '../../utils/my_title.dart';
import 'package:grad_chain/widgets/constrants.dart';
import 'package:grad_chain/utils/claim_widget.dart';

class StuHomeScreen extends StatefulWidget {
  const StuHomeScreen({super.key});

  @override
  State<StuHomeScreen> createState() => _StuHomeScreenState();
}

class _StuHomeScreenState extends State<StuHomeScreen> {
  @override
  Widget build(BuildContext context) {
    final model.User? user = Provider.of<UserProvider>(context).getUser;

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
                      leading: Icon(Icons.person),
                      //leading: Image.network('${user.photoUrl}'),
                      title: Text(
                        //'hu',
                        user!.username,
                        style: drawerTextColor,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 200,
                  ),
                  Padding(
                    padding: tilePadding,
                    child: ListTile(
                      leading: OutlinedButton(
                        onPressed: () {
                          FlutterClipboard.copy('${user.username}');
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

            // first half of page
            Expanded(
                flex: 2,
                child: Column(children: [
                  SizedBox(height: 15),
                  Expanded(child: StuDipList()),
                  SizedBox(height: 10),
                ]))
          ],
        ),
      ),
    );
  }
}
