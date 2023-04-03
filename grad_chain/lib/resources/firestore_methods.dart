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

  // Future<String> uploadDiplomaToBlockChain(String diplomaUrl) async {
  //   HttpsCallable callable = _functions.httpsCallable('ipfs_upload');

  //   print(callable);
  //   // final resp = await callable.call(<String, dynamic>{
  //   //   'url': diplomaUrl,
  //   // });
  //   // // resp will have the bChainUrl
  //   // print("result: ${resp.data}");
  //   // print(resp.data as String);
  //   //return resp.data as String;
  //   return 'Test';
  // }

  // HTTP PACKAGE
  // final String url =
  //     'https://us-central1-gradchain-55ffd.cloudfunctions.net/ipfs_upload';

  // Future<String> uploadDiplomaToBlockChain(String diplomaUrl) async {
  //   final response = await http.post(
  //     Uri.parse(url),
  //     headers: {'Content-Type': 'application/json'},
  //     body: {'url': diplomaUrl},
  //   );
  //   if (response.statusCode == 200) {
  //     print(response.body);
  //     return response.body;
  //   } else {
  //     throw Exception('Failed to send value to cloud function.');
  //   }
  // }

  // HTTP PACKAGE
  final String url =
      'https://cors-anywhere.herokuapp.com/https://us-central1-gradchain-55ffd.cloudfunctions.net/ipfs_upload';

  Future<String> uploadDiplomaToBlockChain(String diplomaUrl) async {
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

  // DIO PACKAGE
  // final String url =
  //     'https://us-central1-gradchain-55ffd.cloudfunctions.net/ipfs_upload';

  // Future<String> uploadDiplomaToBlockChain(String diplomaUrl) async {
  //   try {
  //     final response = await Dio().post(
  //       url,
  //       data: {'url': diplomaUrl},
  //       options: Options(
  //         headers: {
  //           'Content-Type': 'application/json',
  //         },
  //       ),
  //     );

  //     print(response.statusCode);

  //     if (response.statusCode == 200 || response.statusCode == 204) {
  //       print(response.data);
  //       return response.data;
  //     } else {
  //       throw Exception('Failed to send value to cloud function.');
  //     }
  //   } catch (e) {
  //     throw Exception('Failed to send value to cloud function.');
  //   }
  // }

  // upload diploma
  Future<String> uploadDiploma(
    String description,
    Uint8List file,
    String uid,
    String university,
    //String profImage,
  ) async {
    String res = "Some error ocurred";
    try {
      String diplomaUrl =
          await StorageMethods().uploadImageToStorage('diplomas', file, true);

      // CALL CLOUD FUNCTION HERE
      String bChainUrl = await uploadDiplomaToBlockChain(diplomaUrl);

      String diplomaId = const Uuid().v1();
      Diploma diploma = Diploma(
        description: description,
        uid: uid,
        university: university,
        diplomaId: diplomaId,
        datePublished: DateTime.now(),
        diplomaUrl: diplomaUrl,
        //profImage: profImage,
        claimed: [],
        bChainUrl: bChainUrl,
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
