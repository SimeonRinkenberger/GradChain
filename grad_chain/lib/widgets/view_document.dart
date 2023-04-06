import 'dart:js';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:grad_chain/responsive/student/web_screen_layout.dart';
import 'package:grad_chain/responsive/university/uni_web_screen.dart';
import 'package:grad_chain/screens/student/stu_home_screen.dart';
import 'package:grad_chain/screens/university/uni_home_screen.dart';
import 'package:grad_chain/widgets/list_widget_card.dart';
import 'package:provider/provider.dart';
import 'package:grad_chain/models/student.dart' as model;
import 'package:grad_chain/models/user.dart' as model;
import '../models/student.dart';
import '../providers/user_provider.dart';
import '../utils/list_widget.dart';

class ViewDocument extends StatelessWidget {
  final stuPhoto;
  final user;

  const ViewDocument({
    Key? key,
    required this.stuPhoto,
    this.user,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            backgroundColor: Colors.grey[300],
            leading: BackButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            user != null ? UniWebScreen() : WebScreenLayout()));
              },
            )),
        body: Center(child: Image.network(stuPhoto)));
  }
}
