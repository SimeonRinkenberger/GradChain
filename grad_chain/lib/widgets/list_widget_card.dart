import 'package:cloud_firestore/cloud_firestore.dart';
//import 'package:grad_chain/widgets/like_animation.dart';
import 'package:flutter/material.dart';
import 'package:grad_chain/models/user.dart' as model;
import 'package:grad_chain/providers/user_provider.dart';
import 'package:grad_chain/resources/firestore_methods.dart';
import 'package:grad_chain/utils/colors.dart';
//import 'package:grad_chain/utils/global_variables.dart';
import 'package:grad_chain/utils/utils.dart';
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

    final width = MediaQuery.of(context).size.width;

    return ListTile(
        title: Text(widget.snap[user != null ? 'email' : 'description']),
        trailing: Row(mainAxisSize: MainAxisSize.min, children: [
          // IconButton(
          //   icon: widget.snap['claimed'].contains(stu?.uid)
          //       ? const Icon(
          //           Icons.check,
          //           color: Colors.red,
          //         )
          //       : const Icon(
          //           Icons.check_box_outline_blank,
          //         ),
          //   onPressed: () {
          //     // debugPrint(user.uid);
          //     // debugPrint(widget.snap['diplomaId']);
          //     // debugPrint(widget.snap['claimed'].toString());
          //     FirestoreMethods().claimDiploma(
          //       widget.snap['diplomaId'],
          //       stu!.uid,
          //       widget.snap['claimed'],
          //     );
          //   },
          // ),
          IconButton(
            icon: Icon(Icons.remove),
            onPressed: () {},
          )
        ]));
  }
}
