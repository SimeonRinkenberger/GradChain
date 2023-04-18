import 'package:cloud_firestore/cloud_firestore.dart';
//import 'package:grad_chain/widgets/like_animation.dart';
import 'package:flutter/material.dart';
import 'package:grad_chain/models/user.dart' as model;
import 'package:grad_chain/providers/user_provider.dart';
import 'package:grad_chain/resources/firestore_methods.dart';
import 'package:grad_chain/utils/colors.dart';
//import 'package:grad_chain/utils/global_variables.dart';
import 'package:grad_chain/utils/utils.dart';
import 'package:grad_chain/widgets/view_document.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:grad_chain/utils/student_list.dart';

import '../models/student.dart' as model;

class StuListWidgetCard extends StatefulWidget {
  final snap;
  const StuListWidgetCard({
    Key? key,
    required this.snap,
  }) : super(key: key);

  @override
  State<StuListWidgetCard> createState() => _StuListWidgetCardState();
}

class _StuListWidgetCardState extends State<StuListWidgetCard> {
  @override
  Widget build(BuildContext context) {
    final model.User? user = Provider.of<UserProvider>(context).getUser;
    final model.Student? stu = Provider.of<UserProvider>(context).getStu;
    String studentPhoto = widget.snap['photoUrl'];

    final width = MediaQuery.of(context).size.width;

    return ListTile(
        leading: CircleAvatar(backgroundImage: NetworkImage(user!.photoUrl)),
        title: Text('test'),
        trailing:
            ElevatedButton(onPressed: () {}, child: Text('View Documents')));
  }
}
