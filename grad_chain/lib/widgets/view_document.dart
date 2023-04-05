import 'package:flutter/material.dart';
import 'package:grad_chain/screens/student/stu_home_screen.dart';
import 'package:grad_chain/widgets/list_widget_card.dart';
import 'package:provider/provider.dart';
import 'package:grad_chain/models/student.dart' as model;
import 'package:grad_chain/models/user.dart' as model;
import '../providers/user_provider.dart';

class ViewDocument extends StatelessWidget {
  final stuPhoto;

  const ViewDocument({
    Key? key,
    required this.stuPhoto,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Center(child: Image.network(stuPhoto)));
  }
}
