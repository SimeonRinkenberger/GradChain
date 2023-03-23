import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:grad_chain/models/diploma.dart';
import 'package:grad_chain/resources/storage_methods.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

class FirestoreMethods {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // upload post
  Future<String> uploadDiploma(
    String description,
    Uint8List file,
    String uid,
    String username,
    String profImage,
  ) async {
    String res = "Some error ocurred";
    try {
      String diplomaUrl =
          await StorageMethods().uploadImageToStorage('diplomas', file, true);

      String diplomaId = const Uuid().v1();
      Diploma diploma = Diploma(
        description: description,
        uid: uid,
        username: username,
        diplomaId: diplomaId,
        datePublished: DateTime.now(),
        diplomaUrl: diplomaUrl,
        profImage: profImage,
        claimed: [],
      );

      _firestore.collection('diplomas').doc(diplomaId).set(
            diploma.toJson(),
          );

      res = 'success';
    } catch (e) {
      res = e.toString();
    }

    return res;
  }

  Future<void> claimDiploma(String diplomaId, String uid, List claimed) async {
    String res = "Some error occurred";
    try {
      if (claimed.contains(uid)) {
        // if the likes list contains the user uid, we need to remove it
        _firestore.collection('diplomas').doc(diplomaId).update({
          'claimed': FieldValue.arrayRemove([uid])
        });
      } else {
        // else we need to add uid to the likes array
        _firestore.collection('diplomas').doc(diplomaId).update({
          'claimed': FieldValue.arrayUnion([uid])
        });
      }
      res = 'success';
    } catch (err) {
      res = err.toString();
    }
  }
}
