import 'package:grad_chain/models/student.dart';
import 'package:grad_chain/resources/auth_methods.dart';
import 'package:flutter/material.dart';

import '../models/user.dart';

class StudentProvider extends ChangeNotifier {
  late User _student;

  final AuthMethods _authMethods = AuthMethods();

  // Getter method
  User get getStudent => _student;

  Future<void> refreshUser() async {
    User student = await _authMethods.getStudentDetails();
    _student = student;
    notifyListeners();
  }
}
