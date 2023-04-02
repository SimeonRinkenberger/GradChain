import 'package:grad_chain/models/student.dart';
//import 'package:grad_chain/resources/auth_methods.dart';
import 'package:flutter/material.dart';
import 'package:grad_chain/models/user.dart';
import 'package:grad_chain/resources/stu_auth_methods.dart';

class StuProvider extends ChangeNotifier {
  late User _user;

  final StuAuthMethods _stuAuthMethods = StuAuthMethods();

  // Getter method
  User get getUser => _user;

  Future<void> refreshUser() async {
    User user = await _stuAuthMethods.getUserDetails();
    _user = user;
    notifyListeners();
  }
}
