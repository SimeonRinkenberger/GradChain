import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:grad_chain/widgets/claim_card.dart';

import '../widgets/dip_card.dart';

class StuDipList extends StatefulWidget {
  List<String> claimableDiplomas = [
    'BS Computer Science, California Baptist University',
    'MS Software Development, University of California Riverside',
    'PHD Computer Engineering, Harvard'
  ];

  // ignore: use_key_in_widget_constructors
  StuDipList({claimableDiplomas});

  @override
  _StuDipListState createState() => _StuDipListState();
}

class _StuDipListState extends State<StuDipList> {
  List<String> _claimableDiplomas = [];
  //late final List<String> claimDiplomas;
  //NotificationPreviewList({requied. this.ClaimDiplomas});

  @override
  initState() {
    super.initState();
    _claimableDiplomas = widget.claimableDiplomas;
  }

  void _removeItem(int index) {
    setState(() {
      _claimableDiplomas.removeAt(index);
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

            return ConstrainedBox(
              //constraints: BoxConstraints.loose(Size(700.0, 250.0)),
              constraints: BoxConstraints(
                maxHeight: MediaQuery.of(context).size.width * 0.5,
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Container(
                  height: 255,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    //border: Border.all(color: Colors.black),
                    color: Colors.white70,
                  ),
                  child: Column(
                      //crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Padding(padding: EdgeInsets.fromLTRB(0, 10, 0, 0)),
                        Text(
                          'My Diplomas',
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
                            itemBuilder: (context, index) => DipCard(
                                  snap: snapshot.data!.docs[index].data(),
                                )),
                        SizedBox(height: 5),
                        _claimableDiplomas.length > 0
                            ? Text('')
                            : Text('No docuements'),
                      ]),
                ),
              ),
            );
          }),
    );
  }
}
