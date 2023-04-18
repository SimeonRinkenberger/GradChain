import 'package:flutter/material.dart';
import 'package:grad_chain/screens/index/landing_screen.dart';
import 'package:grad_chain/utils/list_widget.dart';

import '../../resources/auth_methods.dart';
import '../../widgets/constrants.dart';

class VerifyDiplomaHomeScreen extends StatefulWidget {
  const VerifyDiplomaHomeScreen({super.key});

  @override
  State<VerifyDiplomaHomeScreen> createState() =>
      _VerifyDiplomaHomeScreenState();
}

class _VerifyDiplomaHomeScreenState extends State<VerifyDiplomaHomeScreen> {
  @override
  Widget build(BuildContext context) {
    //final model.User? user = Provider.of<UserProvider>(context).getUser;
    //final Student? stu = Provider.of<UserProvider>(context).getStu;

    return Scaffold(
      backgroundColor: defaultBackgroundColor,
      appBar: myAppBar,
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
          // open drawer
          Drawer(
            backgroundColor: Colors.grey[300],
            elevation: 0,
            width: 200,
            child: Column(
              children: [
                DrawerHeader(
                  child: ListTile(
                    //leading: Image.network('${user.photoUrl}'),
                    title: Text(
                      'Guest',
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
              ])),
          //Image(image: NetworkImage('widget.snap[photoURL]'))
        ]),
      ),
    );
    ;
  }
}
