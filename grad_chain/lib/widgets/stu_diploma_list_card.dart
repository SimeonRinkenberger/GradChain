import 'dart:html';

import 'package:cloud_firestore/cloud_firestore.dart';
//import 'package:grad_chain/widgets/like_animation.dart';
import 'package:flutter/material.dart';
import 'package:grad_chain/models/user.dart' as model;
import 'package:grad_chain/providers/user_provider.dart';
import 'package:grad_chain/resources/firestore_methods.dart';
import 'package:grad_chain/utils/colors.dart';
//import 'package:grad_chain/utils/global_variables.dart';
import 'package:grad_chain/utils/utils.dart';
import 'package:grad_chain/widgets/add_button.dart';
import 'package:grad_chain/widgets/view_document.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../models/student.dart';
import '../screens/university/add_diploma_screen.dart';

class StudentDiplomaList extends StatefulWidget {
  final snap;
  const StudentDiplomaList({
    Key? key,
    required this.snap,
  }) : super(key: key);

  @override
  State<StudentDiplomaList> createState() => _StudentDiplomaListState();
}

class _StudentDiplomaListState extends State<StudentDiplomaList> {
  @override
  Widget build(BuildContext context) {
    final model.User? user = Provider.of<UserProvider>(context).getUser;
    final Student? stu = Provider.of<UserProvider>(context).getStu;

    final width = MediaQuery.of(context).size.width;

    return ListTile(
      leading: Text(widget.snap['description']),
      title: Image.network(widget.snap['diplomaUrl']),
    );
  }
}
