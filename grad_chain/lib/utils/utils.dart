import 'dart:io';
import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:grad_chain/resources/firestore_methods.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:path_provider/path_provider.dart';

import '../resources/storage_methods.dart';

pickImage(ImageSource source) async {
  final ImagePicker _imagePicker = ImagePicker();
  XFile? _file = await _imagePicker.pickImage(source: source);

  if (_file != null) {
    return await _file.readAsBytes();
  }
  print('No image selected');
}

asdasd(Uint8List file) async {
  print('Im in');
  String diplomaUrl = await StorageMethods()
      .uploadImageToStorage('verifiedDiplomas', file, true);
  print(diplomaUrl);
}
// String bChainDiplomaHash =
//     await FirestoreMethods().uploadDiplomaToBlockChain(diplomaUrl);

// final FirebaseFirestore _firestore = FirebaseFirestore.instance;
// _firestore
//     .collection("diplomas")
//     .where("diplomId", isEqualTo: '481d75c0-dcf2-11ed-97fd-a320441ff9f7')
//     .get()
//     .then(
//   (querySnapshot) async {
//     print("Successfully completed");
//     for (var docSnapshot in querySnapshot.docs) {
//       print('${docSnapshot.id} => ${docSnapshot.data()}');
//     }
//     return file;
//   },
//   onError: (e) => print("Error completing: $e"),
// );

// final ref = FirebaseDatabase.instance.ref();
// final snapshot = await ref.child('users/$userId').get();
// if (snapshot.exists) {
//   print(snapshot.value);
// } else {
//   print('No data available.');
// }w

// final byteData = await rootBundle.load('assets/fileDip/image.png');

// final oFile =
//     File('${(await getTemporaryDirectory()).path}/assets/fileDip/image.png');
// await oFile.writeAsBytes(byteData.buffer
//     .asUint8List(byteData.offsetInBytes, byteData.lengthInBytes));

// final ImagePicker _imagePicker = ImagePicker();
// XFile? _file = await _imagePicker.pickImage(source: source);
// final nFile = _file as File;

// if (_file != null) {
//   if (nFile == oFile) {
//     var dd = await _file.readAsBytes();
//     return [dd, true];
//   } else {
//     var dd = await _file.readAsBytes();
//     return [dd, false];
//   }
// }

showSnackBar(String content, BuildContext context) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(content),
    ),
  );
}
