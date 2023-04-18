import 'dart:js';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:grad_chain/responsive/student/web_screen_layout.dart';
import 'package:grad_chain/responsive/university/uni_web_screen.dart';
import 'package:grad_chain/widgets/stu_diploma_list_card.dart';

import 'package:provider/provider.dart';

import '../models/student.dart';
import '../providers/user_provider.dart';

class ViewDocument extends StatefulWidget {
  final stuPhoto;
  final user;
  final snap;

  ViewDocument({Key? key, this.stuPhoto, this.user, this.snap})
      : super(key: key);

  @override
  State<ViewDocument> createState() => _ViewDocumentState();
}

class _ViewDocumentState extends State<ViewDocument> {
  @override
  Widget build(BuildContext context) {
    final Student? stu = Provider.of<UserProvider>(context).getStu;

    var dipQuery = FirebaseFirestore.instance
        .collection('diplomas')
        .where('uid', isEqualTo: widget.snap['uid'])
        .snapshots();

    return Scaffold(
        appBar: AppBar(
            backgroundColor: Colors.grey[300],
            leading: BackButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => widget.user != null
                            ? UniWebScreen()
                            : WebScreenLayout()));
              },
            )),
        body: StreamBuilder(
            stream: dipQuery,
            builder: (context,
                AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting)
                return const Center(
                  child: CircularProgressIndicator(),
                );

              print(snapshot.data!.docs.length.toString());
              return Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    color: Colors.white70,
                  ),
                  child: SingleChildScrollView(
                      child: Column(children: [
                    Padding(padding: EdgeInsets.fromLTRB(0, 10, 0, 0)),
                    Text(
                      'List of Diplomas for: ' + widget.snap['username'],
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 5),
                    //debugPrint(snapshot.data!.docs.length);
                    ListView.builder(
                        shrinkWrap: true,
                        itemCount: snapshot.data!.docs.length,
                        itemBuilder: (context, index) => StudentDiplomaList(
                            snap: snapshot.data!.docs[index].data()))
                  ])));
            }));
  }
}
