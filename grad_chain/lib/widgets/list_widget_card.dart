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

import '../models/student.dart';

class ListWidgetCard extends StatefulWidget {
  final snap;
  const ListWidgetCard({
    Key? key,
    required this.snap,
  }) : super(key: key);

  @override
  State<ListWidgetCard> createState() => _ListWidgetCardState();
}

class _ListWidgetCardState extends State<ListWidgetCard> {
  @override
  Widget build(BuildContext context) {
    final model.User? user = Provider.of<UserProvider>(context).getUser;
    final Student? stu = Provider.of<UserProvider>(context).getStu;
    String studentPhoto = widget.snap[user != null ? 'photoUrl' : 'diplomaUrl'];

    String uniUsername = '';
    String studentId = '';

    // if (user != null) {
    //   String uniUsername = user.username;
    //   String studentId = widget.snap['uid'];
    // }

    final width = MediaQuery.of(context).size.width;

    print(widget.snap['diplomaUrl']);

    return ListTile(
        leading: CircleAvatar(
            backgroundImage: NetworkImage(user != null
                ? widget.snap['photoUrl']
                : widget.snap['diplomaUrl'])),
        title: Text(widget.snap[user != null ? 'username' : 'description']),
        trailing:
            ElevatedButton(onPressed: () {}, child: Text('View Documents')));
  }
}
