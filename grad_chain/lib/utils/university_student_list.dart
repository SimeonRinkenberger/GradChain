import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:grad_chain/widgets/claim_card.dart';

class UniversityStudentList extends StatefulWidget {
  List<String> uniStudentList = [
    'BS Computer Science, California Baptist University',
    'MS Software Development, University of California Riverside',
    'PHD Computer Engineering, Harvard'
  ];

  // ignore: use_key_in_widget_constructors
  UniversityStudentList({uniStudentList});

  @override
  _UniversityStudentList createState() => _UniversityStudentList();
}

class _UniversityStudentList extends State<UniversityStudentList> {
  List<String> _uniStudentList = [];
  //late final List<String> claimDiplomas;
  //NotificationPreviewList({requied. this.ClaimDiplomas});

  @override
  initState() {
    super.initState();
    _uniStudentList = widget.uniStudentList;
  }

  void _removeItem(int index) {
    setState(() {
      _uniStudentList.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: StreamBuilder(
          stream: FirebaseFirestore.instance.collection('diplomas').snapshots(),
          builder: (context,
              AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }

            return Container(
              //height: 255,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                //border: Border.all(color: Colors.black),
                color: Colors.white70,
              ),
              child: Column(
                  //crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Padding(padding: EdgeInsets.fromLTRB(0, 10, 0, 0)),
                    const Text(
                      'Sucessfully added students',
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
                        itemBuilder: (context, index) {
                          return ListTile(
                              leading: CircleAvatar(
                                backgroundImage:
                                    AssetImage("assets/images/CBU_Logo.png"),
                              ),
                              title: ClaimCard(
                                  snap: snapshot.data!.docs[index].data()),
                              trailing: Text('View Documents'));

                          SizedBox(height: 5);
                          /*
                    _uniStudentList.length > 0
                        ? Text('')
                        : Text('No pending docuements'),
                        */
                        })
                  ]),
            );
          }),
    );
  }
}
