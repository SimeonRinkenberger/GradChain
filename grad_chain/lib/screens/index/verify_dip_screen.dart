/* import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:grad_chain/screens/index/home_screen.dart';
import 'package:grad_chain/screens/index/login_screen.dart';
import 'package:grad_chain/screens/index/signup_screen.dart';
import 'package:grad_chain/screens/index/verify_dip_screen.dart';
import 'package:grad_chain/screens/student/student_login_screen.dart';
import 'package:image_picker/image_picker.dart';

import '../../utils/utils.dart';

class verifyDipScreen extends StatefulWidget {
  const verifyDipScreen({Key? key}) : super(key: key);
  @override
  State<verifyDipScreen> createState() => _verifyDipScreen();
}

class _verifyDipScreen extends State<verifyDipScreen> {
  Uint8List? _image;
  bool _isLoading = false;

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  void selectImage() async {
    Uint8List im = await pickImage(ImageSource.gallery);
    setState(() {
      _image = im;
    });
  }

  void signUpUser() async {
    setState(() {
      _isLoading = true;
    });

    setState(() {
      _isLoading = false;
    });

    @override
    Widget build(BuildContext context) {
      return Scaffold(
        backgroundColor: Color.fromARGB(255, 219, 222, 219),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            AspectRatio(
              aspectRatio: 16 / 3,
              child: Container(
                child:
                    Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                  //Grad Chain
                  Image.asset(
                    'assets/images/gradchain_logo.png',
                    height: 250,
                    width: 450,
                    fit: BoxFit.fitWidth,
                  ),
                ]),
              ),
            ),
            SizedBox(height: 10),
            Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
              //Block Chain For Deplomas
              Text(
                'Verify A diploma!',
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ]),

            SizedBox(height: 10),
            //add file
            SizedBox(height: 10),
            Container(
              child: AspectRatio(
                aspectRatio: 16 / 3,
                child:
                    Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                  IconButton(
                    icon: const Icon(
                      Icons.upload,
                      color: Color.fromARGB(255, 78, 78, 78),
                      size: 30,
                    ),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => HomeScreen()),
                      );
                    },
                  ),
                ]),
              ),
            ),
          ],
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 219, 222, 219),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          AspectRatio(
            aspectRatio: 16 / 3,
            child: Container(
              child:
                  Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                //Grad Chain
                Image.asset(
                  'assets/images/gradchain_logo.png',
                  height: 250,
                  width: 450,
                  fit: BoxFit.fitWidth,
                ),
              ]),
            ),
          ),
          SizedBox(height: 10),
          Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
            //Block Chain For Deplomas
            Text(
              'Verify A diploma!',
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.w700,
              ),
            ),
          ]),

          SizedBox(height: 10),
          //add file
          SizedBox(height: 10),
          Container(
            child: AspectRatio(
              aspectRatio: 16 / 3,
              child:
                  Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                IconButton(
                  icon: const Icon(
                    Icons.upload,
                    color: Color.fromARGB(255, 78, 78, 78),
                    size: 30,
                  ),
                  onPressed: selectImage,
                ),
              ]),
            ),
          ),
        ],
      ),
    );
  }
} */

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

class VerifyDipScreen extends StatefulWidget {
  const VerifyDipScreen({super.key});

  @override
  State<VerifyDipScreen> createState() => _VerifyDipScreenState();
}

class _VerifyDipScreenState extends State<VerifyDipScreen> {
  Uint8List? _file;
  Uint8List? _image;
  bool _isLoading = false;
  bool _isValid = true;
  //Icon check = Icon(Icons.check);

  _selectImage(BuildContext context) async {
    return showDialog(
        context: context,
        builder: (context) {
          return SimpleDialog(
            title: const Text('Upload a diploma'),
            children: [
              SimpleDialogOption(
                padding: const EdgeInsets.all(20),
                child: Text('Choose from gallery'),
                onPressed: () async {
                  Navigator.of(context).pop();
                  Uint8List file = await pickImage(
                    ImageSource.camera,
                  );
                  setState(() {
                    _file = file;
                  });
                },
              ),
              SimpleDialogOption(
                padding: const EdgeInsets.all(20),
                child: Text('Cancel'),
                onPressed: () async {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        });
  }

  void clearImage() {
    setState(() {
      _file = null;
    });
  }

  // SELECT PROFILE PIC IMAGE FOR USER
  void selectImage() async {
    Uint8List im = await pickImage(ImageSource.gallery);
    setState(() {
      _image = im;
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return _file == null
        ? Center(
            child: ElevatedButton(
              onPressed: () => _selectImage(context),
              child: Icon(Icons.upload),
            ),
          )
        : Scaffold(
            backgroundColor: Colors.grey[300],
            appBar: AppBar(
              backgroundColor: defaultBackgroundColor,
              leading: IconButton(
                color: Color.fromARGB(255, 70, 70, 70),
                icon: const Icon(Icons.arrow_back),
                onPressed: clearImage,
              ),
            ),
            body: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                AspectRatio(
                  aspectRatio: 16 / 3,
                  child: Container(
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
                ),
                _isLoading
                    ? const LinearProgressIndicator()
                    : const Padding(
                        padding: EdgeInsets.only(top: 0),
                      ),
                const Divider(),
                Column(
                  children: [
                    Text(
                      "Verified Status:",
                      style: TextStyle(fontSize: 30),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    _isValid
                        ? Icon(Icons.check,
                            color: Colors.green, // add green color
                            size: 100)
                        : Icon(Icons.close,
                            color: Colors.red, // add green color
                            size: 100)
                  ],
                ),
              ],
            ),
          );
  }
}
