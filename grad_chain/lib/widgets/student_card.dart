import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:grad_chain/resources/firestore_methods.dart';
import 'package:grad_chain/models/student.dart' as model;
import 'package:grad_chain/models/user.dart' as model;
import 'package:grad_chain/providers/user_provider.dart';
import 'package:grad_chain/widgets/display_diploma.dart';
import 'package:provider/provider.dart';

import 'claim_card.dart';

class StudentCard extends StatefulWidget {
  final snap;
  const StudentCard({
    Key? key,
    required this.snap,
  }) : super(key: key);

  @override
  State<StudentCard> createState() => _StudentCardState();
}

class _StudentCardState extends State<StudentCard> {
  @override
  Widget build(BuildContext context) {
    final model.User user = Provider.of<UserProvider>(context).getUser;
    final width = MediaQuery.of(context).size.width;

    return ListTile(
      leading: CircleAvatar(
          backgroundImage: AssetImage("assets/images/CBU_Logo.png")),
      title: Text(widget.snap['username']),
      trailing: ElevatedButton(
          onPressed: () {
            //Navigator.push(
            //context,
            //MaterialPageRoute(builder: (context) => DisplayDiploma(snapshot.data!.docs])),
            //)
          },
          child: Text('View Documents'),
          style: ElevatedButton.styleFrom(backgroundColor: Colors.black)),
    );
  }
}
