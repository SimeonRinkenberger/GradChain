import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:grad_chain/widgets/claim_card.dart';

class UniversityStudentList extends StatefulWidget {
  List<String> addedStudents = ['Test Data'];

  UniversityStudentList({addedStudents});

  @override
  _UniversityStudentListState createState() => _UniversityStudentListState();
}

class _UniversityStudentListState extends State<UniversityStudentList> {
  List<String> _addedStudents = [];

  @override
  initState() {
    super.initState();
    _addedStudents = widget.addedStudents;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey[300],
        body: StreamBuilder(
            stream:
                FirebaseFirestore.instance.collection('students').snapshots(),
            builder: (context,
                AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }

              return Container(
                //height: 500,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: Colors.white70),
                child: Column(children: [
                  const Padding(padding: EdgeInsets.fromLTRB(0, 10, 0, 0)),
                  const Text(
                    'Sucessfully added students:',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10),
                  Expanded(
                    child: ListView.builder(
                        scrollDirection: Axis.vertical,
                        shrinkWrap: true,
                        itemCount: snapshot.data!.docs.length,
                        //itemCount: snapshot.data!.docs.length,
                        //itemBuilder: (context, index) => ClaimCard(
                        //  snap: snapshot.data!.docs[index].data(),

                        itemBuilder: (context, int index) => ClaimCard(
                              snap: snapshot.data!.docs[index].data(),
                            )),
                    /*
                        itemBuilder: (BuildContext, int index) {
                          return ListTile(
                            leading: CircleAvatar(
                              backgroundImage:
                                  AssetImage("assets/images/CBU_Logo.png"),
                            ),
                            title: Text('Student:'),
                            trailing: Text('View Documents'),
                          );
                        }),
                        */
                  )
                ]),
              );
            }));
  }
}
