import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:grad_chain/models/diploma.dart';
import 'package:grad_chain/resources/storage_methods.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import 'package:cloud_functions/cloud_functions.dart';
import 'package:http/http.dart' as http;
import 'package:dio/dio.dart';

class FirestoreMethods {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseFunctions _functions = FirebaseFunctions.instance;

  // HTTP PACKAGE
  Future<String> uploadDiplomaToBlockChain(String diplomaUrl) async {
    final String url = 'https://ipfs-file-upload-5oqtywqtuq-uc.a.run.app';

    final response = await http.post(Uri.parse(url), body: {'url': diplomaUrl});

    print(response.statusCode);
    print(response.body);

    if (response.statusCode == 200) {
      print(response.body);
      return response.body;
    } else {
      throw Exception('Failed to send value to cloud function.');
    }
  }

  // upload diploma
  Future<String> uploadDiploma(
    String description,
    Uint8List file,
    String studentId,
    String university,
    //String profImage,
  ) async {
    String res = "Some error ocurred";
    try {
      String diplomaUrl =
          await StorageMethods().uploadImageToStorage('diplomas', file, true);

      String diplomaId = const Uuid().v1();

      Diploma diploma = Diploma(
        description: description,
        studentId: studentId,
        university: university,
        diplomaId: diplomaId,
        datePublished: DateTime.now(),
        diplomaUrl: diplomaUrl,
        claimed: [],
        bChainHash: '',
      );

      _firestore.collection('diplomas').doc(diplomaId).set(
            diploma.toJson(),
          );

      // CALL CLOUD FUNCTION HERE
      String bChainDiplomaHash = await uploadDiplomaToBlockChain(diplomaUrl);

      final updatedDiploma = <String, String>{
        "bChainHash": bChainDiplomaHash,
      };

      _firestore.collection('diplomas').doc(diplomaId).set(updatedDiploma);

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
