import 'package:grad_chain/models/student.dart';
import 'package:grad_chain/models/user.dart';
import 'package:grad_chain/resources/auth_methods.dart';
import 'package:flutter/material.dart';

class UserProvider extends ChangeNotifier {
  User? _user = null;
  Student? _student = null;

  final AuthMethods _authMethods = AuthMethods();

  // Getter method
  User? get getUser => _user;
  Student? get getStu => _student;

  Future<void> refreshUser() async {
    List res = await _authMethods.getUserDetails();
    if (res[0] == 0) {
      Student stu = res[1];
      _student = stu;
    } else {
      User user = res[1];
      _user = user;
    }
    notifyListeners();
  }
}
