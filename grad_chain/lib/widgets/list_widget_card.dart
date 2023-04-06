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
  //final snap2;

  const ListWidgetCard({Key? key, required this.snap}) : super(key: key);

  @override
  State<ListWidgetCard> createState() => _ListWidgetCardState();
}

class _ListWidgetCardState extends State<ListWidgetCard> {
  @override
  Widget build(BuildContext context) {
    final model.User? user = Provider.of<UserProvider>(context).getUser;
    final Student? stu = Provider.of<UserProvider>(context).getStu;
    String studentPhoto = widget.snap[user != null ? 'photoUrl' : 'diplomaUrl'];
    String placeHolderPhoto =
        "https://cdn.shopify.com/s/files/1/1699/4809/products/SD_Penn_Foster_High_School_Diploma_Converted_-_Copy_1024x1024@2x.jpg?v=1556304897";

    final width = MediaQuery.of(context).size.width;

    return ListTile(
        leading: CircleAvatar(
            backgroundImage: NetworkImage(user != null
                ? widget.snap['photoUrl']
                : widget.snap['diplomaUrl'])),
        title: Text(widget.snap[user != null ? 'username' : 'description']),
        trailing: ElevatedButton(
            onPressed: () {
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(
                  builder: (context) => ViewDocument(
                      stuPhoto: user != null ? placeHolderPhoto : studentPhoto,
                      user: user),
                ),
              );
            },
            child: Text('View Documents')));
  }
}
