import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:grad_chain/models/student.dart';
import 'package:grad_chain/models/user.dart' as model;

import 'package:grad_chain/resources/storage_methods.dart';
import 'package:flutter/widgets.dart';

class AuthMethods {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<List> getUserDetails() async {
    User currentUser = _auth.currentUser!;
    List res = <dynamic>[];

    DocumentSnapshot documentSnapshot =
        await _firestore.collection('users').doc(currentUser.uid).get();

    if (documentSnapshot.data() == null) {
      DocumentSnapshot documentSnapshot =
          await _firestore.collection('students').doc(currentUser.uid).get();
      res.add(0);
      res.add(Student.fromSnap(documentSnapshot));
      return res;
    }
    //print(documentSnapshot.data());
    res.add(1);
    res.add(model.User.fromSnap(documentSnapshot));
    return res;
  }

  // sign up user function
  Future<List> signUpUser({
    required String email,
    required String password,
    required String username,
    required String bio,
    required Uint8List file,
  }) async {
    List res = ["some error ocurred"];
    try {
      if (email.isNotEmpty ||
          password.isNotEmpty ||
          username.isNotEmpty ||
          bio.isNotEmpty) {
        // register user
        UserCredential cred = await _auth.createUserWithEmailAndPassword(
            email: email, password: password);

        print(cred.user!.uid);

        String photoUrl = await StorageMethods()
            .uploadImageToStorage('profilePics', file, false);

        // add user data to firestore database
        model.User user = model.User(
          username: username,
          uid: cred.user!.uid,
          email: email,
          bio: bio,
          photoUrl: photoUrl,
          cli_type: 0,
        );

        await _firestore.collection('users').doc(cred.user!.uid).set(
              user.toJson(),
            );

        // Alternate method
        // await _firestore.collection('users').add({
        //   'username': username,
        //   'uid': cred.user!.uid,
        //   'email': email,
        //   'bio': bio,
        //   'followers': [],
        //   'following': [],
        // });

        res.clear();
        res.add("success");
        res.add(cred.user!.uid);
      }
      // } on FirebaseAuthException catch (err) {
      //   if (err.code == 'invalid-email') {
      //     res = 'The email is badly formatted.';
      //   } else if (err.code == 'weak-password') {
      //     res = 'Password should be at least 6 characters.';
      //   }
    } catch (err) {
      String error = err.toString();
      res.clear();
    }
    return res;
  }

  Future<List> signUpStudent({
    required String email,
    required String password,
    required String username,
    required String bio,
    required String uniId,
    required Uint8List file,
  }) async {
    List res = ["some error ocurred"];
    try {
      if (email.isNotEmpty ||
          password.isNotEmpty ||
          username.isNotEmpty ||
          bio.isNotEmpty) {
        // register student
        UserCredential cred = await _auth.createUserWithEmailAndPassword(
            email: email, password: password);

        print(cred.user!.uid);

        String photoUrl = await StorageMethods()
            .uploadImageToStorage('profilePics', file, false);

        // add student data to firestore database
        Student student = Student(
          username: username,
          uid: cred.user!.uid,
          email: email,
          bio: bio,
          photoUrl: photoUrl,
          cli_type: 0,
          uniId: uniId,
        );

        await _firestore.collection('students').doc(cred.user!.uid).set(
              student.toJson(),
            );

        // Alternate method
        // await _firestore.collection('users').add({
        //   'username': username,
        //   'uid': cred.user!.uid,
        //   'email': email,
        //   'bio': bio,
        //   'followers': [],
        //   'following': [],
        // });

        res.clear();
        res.add("success"); // 0
        res.add(cred.user!.uid); // 1. student's id
        res.add(username); // 2. student's username
      }
      // } on FirebaseAuthException catch (err) {
      //   if (err.code == 'invalid-email') {
      //     res = 'The email is badly formatted.';
      //   } else if (err.code == 'weak-password') {
      //     res = 'Password should be at least 6 characters.';
      //   }
    } catch (err) {
      res.clear();
      res.add(err.toString());
    }
    return res;
  }

  // logging in user
  Future<String> loginUser({
    required String email,
    required String password,
  }) async {
    String res = "Some error occurred";

    try {
      if (email.isNotEmpty & password.isNotEmpty) {
        await _auth.signInWithEmailAndPassword(
            // here we cn use the return value, UserCredentials, to get the uid and the type of user in order to load the employer, university or personal account screen
            email: email,
            password: password);
        res = "success";
      } else {
        res = "Please enter all the fields";
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        res = 'Invalid user';
      } else if (e.code == 'wrong-password') {
        res = 'Wrong password';
      }
    } catch (err) {
      res = err.toString();
    }

    return res;
  }
}
