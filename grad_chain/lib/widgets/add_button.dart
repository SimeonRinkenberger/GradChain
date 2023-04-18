// import 'dart:typed_data';

// import 'package:flutter/material.dart';
// import 'package:grad_chain/widgets/constrants.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:provider/provider.dart';

// import 'package:grad_chain/models/user.dart';
// import 'package:grad_chain/providers/user_provider.dart';
// import 'package:grad_chain/resources/firestore_methods.dart';
// import 'package:grad_chain/utils/colors.dart';
// import 'package:grad_chain/utils/utils.dart';

// import '../../resources/auth_methods.dart';
// import '../../widgets/text_field_input.dart';

// import 'package:flutter/material.dart';

// class DocumentUploader extends StatefulWidget {
//   @override
//   _DocumentUploaderState createState() => _DocumentUploaderState();
// }

// class _DocumentUploaderState extends State<DocumentUploader> {
//   String? _filePath;
//   Uint8List? _file;

//   final TextEditingController _descriptionController = TextEditingController();

//   final TextEditingController _emailController = TextEditingController();
//   Uint8List? _image;
//   bool _isLoading = false;

//   void signUpStudent(String uni)

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Document Uploader'),
//       ),
//       body: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         crossAxisAlignment: CrossAxisAlignment.center,
//         children: [
//           ElevatedButton(
//             onPressed: () async {
//               //String? path = await ();
//               setState(() {
//                 //_filePath = path;
//               });
//             },
//             child: Text('Select File'),
//           ),
//           SizedBox(height: 16),
//           ElevatedButton(
//             onPressed: _filePath != null
//                 ? () async {
//                     //await uploadFile(_filePath!);
//                   }
//                 : null,
//             child: Text('Upload File'),
//           ),
//         ],
//       ),
//     );
//   }
// }

import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:grad_chain/widgets/constrants.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

import 'package:grad_chain/models/user.dart';
import 'package:grad_chain/providers/user_provider.dart';
import 'package:grad_chain/resources/firestore_methods.dart';
import 'package:grad_chain/utils/utils.dart';

import '../../resources/auth_methods.dart';
import '../../widgets/text_field_input.dart';

class DocumentUploader extends StatefulWidget {
  final stuId; //Student's uid

  final Uni; //University

  const DocumentUploader({Key? key, required this.stuId, this.Uni})
      : super(key: key);

  @override
  State<DocumentUploader> createState() => _DocumentUploaderState();
}

class _DocumentUploaderState extends State<DocumentUploader> {
  Uint8List? _file;
  final TextEditingController _descriptionController = TextEditingController();
  // final TextEditingController _descriptionController2 = TextEditingController();
  // final TextEditingController _descriptionController3 = TextEditingController();
  // final TextEditingController _descriptionController4 = TextEditingController();
  // final TextEditingController _descriptionController5 = TextEditingController();
  // final TextEditingController _descriptionController6 = TextEditingController();

  // CREATE STUDENT CONTROLLERS
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _bioController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();
  Uint8List? _image;
  bool _isLoading = false;

  void postDiploma(
    String uid,
    String university,
    //String profImage,
  ) async {
    try {
      String res = await FirestoreMethods()
          .uploadDiploma(_descriptionController.text, _file!, uid, university);

      if (res == 'success') {
        setState(() {
          _isLoading = false;
        });
        showSnackBar('Student and Diploma created!', context);
        clearImage();
      } else {
        setState(() {
          _isLoading = false;
        });
        showSnackBar(res, context);
      }
    } catch (e) {
      showSnackBar(e.toString(), context);
    }
  }

  _selectImage(BuildContext context) async {
    return showDialog(
        context: context,
        builder: (context) {
          return SimpleDialog(
            title: const Text('Upload a diploma'),
            children: [
              SimpleDialogOption(
                  // padding: const EdgeInsets.all(20),
                  // child: Text('Take a photo'),
                  // onPressed: () async {
                  //   Navigator.of(context).pop();
                  //   Uint8List file = await pickImage(
                  //     ImageSource.camera,
                  //   );
                  //   setState(() {
                  //     _file = file;
                  //   });
                  // },
                  ),
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

  void signUpStudent(String uniId, String university) async {
    setState(() {
      _isLoading = true;
    });
    List res = await AuthMethods().signUpStudent(
      email: _emailController.text,
      password: _passwordController.text,
      username: _usernameController.text,
      bio: _bioController.text,
      file: _image!,
      uniId: uniId,
    );

    if (res[0] != 'success') {
      showSnackBar(res[0], context);
    } else {
      postDiploma(res[1], university);
    }

    //print(res);
  }

  // SELECT PROFILE PIC IMAGE FOR USER
  void selectImage() async {
    Uint8List im = await pickImage(ImageSource.gallery);
    setState(() {
      _image = im;
    });
  }

  void addDiplomaToExisting() async {
    setState(() {
      _isLoading = true;
    });

    postDiploma(widget.stuId, widget.Uni);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    // DIPLOMA FORM CONTROLLERS
    _descriptionController.dispose();
    // _descriptionController2.dispose();
    // _descriptionController3.dispose();
    // _descriptionController4.dispose();
    // _descriptionController5.dispose();
    // _descriptionController6.dispose();

    // SIGN UP FORM CONTROLLERS
    _emailController.dispose();
    _passwordController.dispose();
    _bioController.dispose();
    _usernameController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final User? user = Provider.of<UserProvider>(context).getUser;

    //debugPrint(user?.photoUrl);

    return _file == null
        ? Scaffold(
            body: Center(
            child: IconButton(
              icon: const Icon(Icons.upload,
                  color: Color.fromARGB(255, 78, 78, 78)),
              onPressed: () => _selectImage(context),
            ),
          ))
        : Scaffold(
            backgroundColor: Colors.grey[300],
            appBar: AppBar(
              backgroundColor: defaultBackgroundColor,
              leading: IconButton(
                color: Color.fromARGB(255, 70, 70, 70),
                icon: const Icon(Icons.arrow_back),
                onPressed: clearImage,
              ),
              title: const Text('Upload diploma for',
                  style: TextStyle(color: Color.fromARGB(255, 75, 75, 75))),
              centerTitle: false,
            ),
            body: SingleChildScrollView(
              //   child: Column(
              //     children: [
              //       _isLoading
              //           ? const LinearProgressIndicator()
              //           : const Padding(
              //               padding: EdgeInsets.only(top: 0),
              //             ),
              //       const Divider(),

              //       // START OF SIGNUP FORM

              child: Center(
                child: Column(children: [
                  SizedBox(
                      width: MediaQuery.of(context).size.width * 0.4,
                      height: MediaQuery.of(context).size.height * 0.10),
                  Row(
                    children: [
                      // IconButton(
                      //   icon: Icon(Icons.upload,
                      //       color: Color.fromARGB(255, 78, 78, 78)),
                      //   onPressed: () => _selectImage(context),
                      // ),
                      // Text(widget.stuId),
                      SizedBox(
                        height: 20,
                        width: 50,
                      ),
                      // Text(widget.Uni),
                      SizedBox(
                        height: 20,
                        width: 50,
                      ),
                      Text(
                        '1. Diploma information',
                        textAlign: TextAlign.left,
                        style: TextStyle(
                          color: Colors.grey[700],
                          fontSize: 32,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 40,
                  ),

                  //       // END OF SIGN UP FORM

                  //       // START OF THE DIPLOMA UPLOAD FORM
                  Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // CircleAvatar(
                        //   backgroundImage: NetworkImage(
                        //     user.photoUrl,
                        //   ),
                        // ),

                        //           // THIS SHOWS THE IMAGE THAT HAS BEEN JUST SELECTED
                        //           SizedBox(
                        //             width: MediaQuery.of(context).size.width * 0.1,
                        //           ),
                        //           SizedBox(
                        //             height: 60,
                        //             width: 60,
                        //             child: AspectRatio(
                        //               aspectRatio: 487 / 451,
                        //               child: Container(
                        //                 decoration: BoxDecoration(
                        //                   image: DecorationImage(
                        //                     image: MemoryImage(_file!),
                        //                     fit: BoxFit.fill,
                        //                     alignment: FractionalOffset.topCenter,
                        //                   ),
                        //                 ),
                        //               ),
                        //             ),
                        //           ),
                        //           SizedBox(
                        //             width: MediaQuery.of(context).size.width * 0.15,
                        //           ),
                        //           // This is the description TextBox
                        Column(children: [
                          Container(
                            decoration: BoxDecoration(
                                image: DecorationImage(
                                    image: MemoryImage(_file!),
                                    fit: BoxFit.fill,
                                    alignment: FractionalOffset.topCenter)),
                          ),
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.4,
                            height: MediaQuery.of(context).size.height * 0.10,
                            child: TextFieldInput(
                              textEditingController: _descriptionController,
                              textInputType: TextInputType.text,
                              hintText: 'Enter diploma degree',
                              isPass: false,
                            ),
                          ),
                          SizedBox(
                            height: 80,
                          ),

                          TextButton(
                              onPressed: () =>
                                  postDiploma(widget.stuId, user!.username),
                              child: const Text(
                                'Add Diploma',
                                style: TextStyle(
                                  color: Colors.blueAccent,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20,
                                ),
                              )),

                          SizedBox(
                            height: 15,
                          ),

                          // Container(decoration: BoxDecoration(
                          //   image: DecorationImage(
                          //     image: MemoryImage(_file != null? _file!: ''),
                          //     fit: BoxFit.fill,
                          //     alignment: FractionalOffset.topCenter,
                          //   ),
                          // ),
                          //              TextButton(
                          //                 onPressed: () => signUpStudent(user!.uid, user!.username),
                          //                 child: const Text(
                          //                   'Create',
                          //                   style: TextStyle(
                          //                     color: Colors.blueAccent,
                          //                     fontWeight: FontWeight.bold,
                          //                     fontSize: 20,
                          //                   ),
                          //                 ),
                          //               ),
                          //               SizedBox(
                          //                 height: 100,
                          //               ),
                          //               // SizedBox(
                          //               //   width: MediaQuery.of(context).size.width * 0.3,
                          //               //   height: MediaQuery.of(context).size.height * 0.10,
                          //               //   child: TextField(
                          //               //     controller: _descriptionController2,
                          //               //     decoration: const InputDecoration(
                          //               //         hintText: 'Write a caption',
                          //               //         border: InputBorder.none),
                          //               //     maxLines: 8,
                          //               //   ),
                          //               // ),
                          //               // SizedBox(
                          //               //   width: MediaQuery.of(context).size.width * 0.3,
                          //               //   height: MediaQuery.of(context).size.height * 0.10,
                          //               //   child: TextField(
                          //               //     controller: _descriptionController3,
                          //               //     decoration: const InputDecoration(
                          //               //         hintText: 'Write a caption',
                          //               //         border: InputBorder.none),
                          //               //     maxLines: 8,
                          //               //   ),
                          //               // ),
                          //               // SizedBox(
                          //               //   width: MediaQuery.of(context).size.width * 0.3,
                          //               //   height: MediaQuery.of(context).size.height * 0.10,
                          //               //   child: TextField(
                          //               //     controller: _descriptionController4,
                          //               //     decoration: const InputDecoration(
                          //               //         hintText: 'Write a caption',
                          //               //         border: InputBorder.none),
                          //               //     maxLines: 8,
                          //               //   ),
                          //               // ),
                          //               // SizedBox(
                          //               //   width: MediaQuery.of(context).size.width * 0.3,
                          //               //   height: MediaQuery.of(context).size.height * 0.10,
                          //               //   child: TextField(
                          //               //     controller: _descriptionController5,
                          //               //     decoration: const InputDecoration(
                          //               //         hintText: 'Write a caption',
                          //               //         border: InputBorder.none),
                          //               //     maxLines: 8,
                          //               //   ),
                          //               // ),
                          //             ],
                          //           ),

                          //           const Divider(),
                          //         ],
                        ])
                      ],
                    ),
                  ),
                ]),
              ),
            ));
  }
}
