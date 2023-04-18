import 'package:cloud_firestore/cloud_firestore.dart';
//import 'package:grad_chain/widgets/like_animation.dart';
import 'package:flutter/material.dart';
import 'package:grad_chain/models/user.dart' as model;
import 'package:grad_chain/providers/user_provider.dart';
import 'package:grad_chain/resources/firestore_methods.dart';
import 'package:grad_chain/utils/colors.dart';
//import 'package:grad_chain/utils/global_variables.dart';
import 'package:grad_chain/utils/utils.dart';
import 'package:grad_chain/widgets/stu_view_docuement';
import 'package:grad_chain/widgets/view_document.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../models/student.dart';

class StudentListWidgetCard extends StatefulWidget {
  final snap;
  const StudentListWidgetCard({
    Key? key,
    required this.snap,
  }) : super(key: key);

  @override
  State<StudentListWidgetCard> createState() => _StudentListWidgetCardState();
}

class _StudentListWidgetCardState extends State<StudentListWidgetCard> {
  @override
  Widget build(BuildContext context) {
    final model.User? user = Provider.of<UserProvider>(context).getUser;
    final Student? stu = Provider.of<UserProvider>(context).getStu;
    String studentPhoto = widget.snap[user != null ? 'photoUrl' : 'diplomaUrl'];
    String stuUid = widget.snap['uid'];

    print(stuUid);

    final width = MediaQuery.of(context).size.width;

    return ListTile(
        leading: Icon(Icons.archive_rounded),
        title: Text(widget.snap[user != null ? 'username' : 'description']),
        trailing: ElevatedButton(
            onPressed: () {
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(
                  builder: (context) => StudentViewDocument(
                      stuuid: stuUid,
                      user: user //Needed for back button to work properly
                      ),
                ),
              );

              ;
            },
            child: Text('View Document')));
  }
}
