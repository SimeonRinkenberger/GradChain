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

            //building the desktop profile layout
            : Scaffold(
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

                      // first half of page
                      Expanded(
                        flex: 2,
                        child: Column(
                          children: [
                            // first 4 boxes in grid
                            AspectRatio(
                              aspectRatio: 16 / 6,
                              child: SizedBox(
                                width: double.infinity,
                                child: Container(
                                  height: 400,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8),
                                    color: Colors.grey[400],
                                  ),
                                ),
                              ),
                            ),

                            // list of previous days
                            Expanded(
                              child: ListView.builder(
                                itemCount: 7,
                                itemBuilder: (context, index) {
                                  return MyTile();
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                      // second half of page
                      // Expanded(
                      //   child: Column(
                      //     children: [
                      //       Padding(
                      //         padding: const EdgeInsets.all(8.0),
                      //         child: Container(
                      //           height: 400,
                      //           decoration: BoxDecoration(
                      //             borderRadius: BorderRadius.circular(8),
                      //             color: Colors.grey[400],
                      //           ),
                      //         ),
                      //       ),
                      //       // list of stuff
                      //       Expanded(
                      //         child: Padding(
                      //           padding: const EdgeInsets.all(8.0),
                      //           child: Container(
                      //             decoration: BoxDecoration(
                      //               borderRadius: BorderRadius.circular(8),
                      //               color: Colors.grey[200],
                      //             ),
                      //           ),
                      //         ),
                      //       ),
                      //     ],
                      //   ),
                      // ),
                    ],
                  ),
                ),
              );
  }
}
