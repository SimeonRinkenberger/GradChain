import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:grad_chain/widgets/list_widget_card.dart';
import 'package:provider/provider.dart';

import '../models/student.dart';
import '../models/user.dart';
import '../providers/user_provider.dart';

class ListWidget extends StatefulWidget {
  // ignore: use_key_in_widget_constructors
  ListWidget({claimableDiplomas});

  @override
  _ListWidgetState createState() => _ListWidgetState();
}

class _ListWidgetState extends State<ListWidget> {
  List<String> _claimableDiplomas = [];
  //late final List<String> claimDiplomas;
  //NotificationPreviewList({requied. this.ClaimDiplomas});

  @override
  initState() {
    super.initState();
  }

  void _removeItem(int index) {
    setState(() {
      _claimableDiplomas.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    final User? user = Provider.of<UserProvider>(context).getUser;
    final Student? stu = Provider.of<UserProvider>(context).getStu;

    var uniQuery = FirebaseFirestore.instance
        .collection('students')
        .where('uniId', isEqualTo: user?.uid)
        .snapshots();
    var uniTitle = "List of students";

    var stuQuery = FirebaseFirestore.instance
        .collection('diplomas')
        .where('uid', isEqualTo: stu?.uid)
        .snapshots();
    var stuTitle = "List of diplomas";

    return Scaffold(
        backgroundColor: Colors.grey[300],
        body: StreamBuilder(
            stream: user != null ? uniQuery : stuQuery,
            //FirebaseFirestore.instance.collection('diplomas').snapshots(),
            builder: (context,
                AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }

              return Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  //border: Border.all(color: Colors.black),
                  color: Colors.white70,
                ),
                child: SingleChildScrollView(
                  child: Column(
                      //crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Padding(padding: EdgeInsets.fromLTRB(0, 10, 0, 0)),
                        Text(
                          user != null ? uniTitle : stuTitle,
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 5),

                        // List of items
                        ListView.builder(
                            shrinkWrap: true,
                            itemCount: snapshot.data!.docs.length,
                            itemBuilder: (context, index) => ListWidgetCard(
                                  snap: snapshot.data!.docs[index].data(),
                                )),
                        SizedBox(height: 5),
                        _claimableDiplomas.length > 0 ? Text('') : Text(''),
                      ]),
                ),
              );
            }));
  }
}
