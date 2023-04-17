import 'dart:typed_data';

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
import '../../widgets/text_field_input.dart';

final TextEditingController _emailController = TextEditingController();

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
                hintText: 'Enter student email',
                isPass: false,
              ),
            ),
            TextButton(
              onPressed: () {},
              child: const Text(
                'Verify',
                style: TextStyle(
                  color: Colors.blueAccent,
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
