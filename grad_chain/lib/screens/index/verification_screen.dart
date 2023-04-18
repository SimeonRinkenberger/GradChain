import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:grad_chain/widgets/constrants.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

import 'package:grad_chain/models/user.dart';
import 'package:grad_chain/providers/user_provider.dart';
import 'package:grad_chain/resources/firestore_methods.dart';
import 'package:grad_chain/utils/colors.dart';
import 'package:grad_chain/utils/utils.dart';

import '../../resources/auth_methods.dart';
import '../../resources/storage_methods.dart';
import '../../widgets/text_field_input.dart';

final TextEditingController _emailController = TextEditingController();
var txt = TextEditingController();

@override
void dispose() {
  // SIGN UP FORM CONTROLLERS
  _emailController.dispose();
}

class VerifyScreen extends StatefulWidget {
  const VerifyScreen({super.key});

  @override
  State<VerifyScreen> createState() => _VerifyScreenState();
}

class _VerifyScreenState extends State<VerifyScreen> {
  String dipUrl = '';
  String dipInfo = '';

  validateDiploma(String studentId) async {
    print('Im in');
    // String diplomaUrl = await StorageMethods()
    //     .uploadImageToStorageNew('verifiedDiplomas', _file!, true);
    // print(diplomaUrl);

    // String bChainDiplomaHash = await FirestoreMethods().uploadDiplomaToBlockChain(diplomaUrl);

    final FirebaseFirestore _firestore = FirebaseFirestore.instance;
    _firestore
        .collection("diplomas")
        .where("uid", isEqualTo: studentId)
        .get()
        .then(
      (querySnapshot) async {
        print("Successfully completed");
        for (var docSnapshot in querySnapshot.docs) {
          print('${docSnapshot.id} => ${docSnapshot.data()}');
          print(docSnapshot.data()['description']);
          String description = docSnapshot.data()['description'];
          //print(description.length);
          if (description.length > 1) {
            setState(() {
              dipUrl = docSnapshot.data()['diplomaUrl'];
              dipInfo = docSnapshot.data()['description'] + 'is verified';
            });
          } else {
            setState(() {
              dipInfo = 'Not verified';
            });
          }
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      appBar: AppBar(
        backgroundColor: defaultBackgroundColor,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            AspectRatio(
              aspectRatio: 14 / 3,
              child: Column(
                children: [
                  Container(
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          //Grad Chain
                          Image.asset(
                            'assets/images/gradchain_logo.png',
                            height: 250,
                            width: 450,
                            fit: BoxFit.fitWidth,
                          ),
                        ]),
                  ),
                ],
              ),
            ),
            Text(
              "Verify an Account and documentation",
              style: TextStyle(fontSize: 24),
            ),
            SizedBox(
              height: 50,
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.4,
              height: MediaQuery.of(context).size.height * 0.10,
              child: TextFieldInput(
                textEditingController: _emailController,
                textInputType: TextInputType.text,
                hintText: 'Enter student id',
                isPass: false,
              ),
            ),
            TextButton(
              onPressed: () {
                bool text = validateDiploma(_emailController.text);
              },
              child: const Text(
                'Verify',
                style: TextStyle(
                  color: Colors.blueAccent,
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
            ),
            Text(
              'Diploma: $dipInfo',
              style: TextStyle(fontSize: 24),
            ),

            Container(
              alignment: Alignment.center,
              child: Container(
                width: 1000.0,
                height: 1000.0,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30.0),
                    image: DecorationImage(
                        image: NetworkImage(
                          dipUrl,
                        ),
                        fit: BoxFit.cover)),
              ),
            ),
            // CircleAvatar(
            //   radius: 150,
            //   backgroundImage: NetworkImage(
            //     dipUrl,
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}
