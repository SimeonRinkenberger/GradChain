import 'package:grad_chain/models/user.dart';
import 'package:grad_chain/resources/auth_methods.dart';
import 'package:flutter/material.dart';

class UserProvider extends ChangeNotifier {
  User? _user;

  final AuthMethods _authMethods = AuthMethods();

  // Getter method
  User? get getUser => _user;

  Future<void> refreshUser() async {
    User user = await _authMethods.getUserDetails();
    _user = user;
    notifyListeners();
  }
}
