import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:grad_chain/resources/firestore_methods.dart';
import 'package:grad_chain/providers/user_provider.dart' as model;
import 'package:grad_chain/providers/user_provider.dart';
import 'package:grad_chain/models/user.dart' as model;
import 'package:grad_chain/utils/utils.dart';
import 'package:provider/provider.dart';

class DisplayDiploma extends StatefulWidget {
  final snap;

  const DisplayDiploma({
    Key? key,
    required this.snap,
  }) : super(key: key);

  @override
  State<DisplayDiploma> createState() => _DisplayDiplomaState();
}

class _DisplayDiplomaState extends State<DisplayDiploma> {
  @override
  Widget build(BuildContext context) {
    final model.User user = Provider.of<UserProvider>(context).getUser;
    return Scaffold(
        body: Center(
      child: InkWell(
          child: Ink.image(
              image: AssetImage(widget.snap['photoURL']),
              width: 100,
              height: 100)),
    ));
  }
}
