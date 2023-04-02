import 'package:grad_chain/screens/university/add_diploma_screen.dart';
import 'package:grad_chain/screens/student/stu_home_screen.dart';
import 'package:flutter/material.dart';
import 'package:grad_chain/screens/university/test_screen.dart';
import 'package:grad_chain/screens/university/uni_home_screen.dart';

const stuHomeScreenItems = [
  StuHomeScreen(),
  Text('search'),
  // AddDiplomaScreen(),
  // Text('notif'),
  // Text('profile'),
];

const uniHomeScreenItems = [
  UniHomeScreen(),
  TestScreen(),
  AddDiplomaScreen(),
  Text('notif'),
  Text('profile'),
];
