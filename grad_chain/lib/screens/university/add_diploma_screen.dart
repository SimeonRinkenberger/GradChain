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

class AddDiplomaScreen extends StatefulWidget {
  const AddDiplomaScreen({super.key});

  @override
  State<AddDiplomaScreen> createState() => _AddDiplomaScreenState();
}

class _AddDiplomaScreenState extends State<AddDiplomaScreen> {
  Uint8List? _file;
  final TextEditingController _descriptionController = TextEditingController();

  // CREATE STUDENT CONTROLLERS
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _bioController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();
  Uint8List? _image;
  bool _isLoading = false;

  void postImage(
    String uid,
    String username,
    String profImage,
  ) async {
    setState(() {
      _isLoading = true;
    });
    try {
      String res = await FirestoreMethods().uploadDiploma(
          _descriptionController.text, _file!, uid, username, profImage);

      if (res == 'success') {
        setState(() {
          _isLoading = false;
        });
        showSnackBar('Posted', context);
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

  void signUpUser() async {
    setState(() {
      _isLoading = true;
    });
    String res = await AuthMethods().signUpUser(
      email: _emailController.text,
      password: _passwordController.text,
      username: _usernameController.text,
      bio: _bioController.text,
      file: _image!,
    );

    setState(() {
      _isLoading = false;
    });

    if (res != 'success') {
      showSnackBar(res, context);
    } else {}

    print(res);
  }

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
    // ADD ALL CONTROLLERS
    _descriptionController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _bioController.dispose();
    _usernameController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final User user = Provider.of<UserProvider>(context).getUser;
    debugPrint(user.bio);

    return _file == null
        ? Center(
            child: IconButton(
              icon: const Icon(
                Icons.upload,
                color: Colors.white,
              ),
              onPressed: () => _selectImage(context),
            ),
          )
        : Scaffold(
            appBar: AppBar(
              backgroundColor: defaultBackgroundColor,
              leading: IconButton(
                icon: const Icon(Icons.arrow_back),
                onPressed: clearImage,
              ),
              title: const Text('Upload diploma for'),
              centerTitle: false,
              actions: [
                TextButton(
                  onPressed: () => postImage(
                    user.uid,
                    user.username,
                    user.photoUrl,
                  ),
                  child: const Text(
                    'Upload',
                    style: TextStyle(
                      color: Colors.blueAccent,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                )
              ],
            ),
            body: Column(
              children: [
                _isLoading
                    ? const LinearProgressIndicator()
                    : const Padding(
                        padding: EdgeInsets.only(top: 0),
                      ),
                const Divider(),

                /* // START OF SIGNUP FORM

                // Row(
                //   children: [
                //     // Flexible(
                //     //   child: Container(),
                //     //   flex: 2,
                //     // ),
                //     // // svg image (we use a package called flutter_svg to show svg images)
                //     // const Icon(
                //     //   Icons.lock,
                //     //   size: 100,
                //     // ),
                //     // const SizedBox(height: 50),

                //     Text(
                //       'Create the student',
                //       style: TextStyle(
                //         color: Colors.grey[700],
                //         fontSize: 42,
                //       ),
                //     ),
                //     const SizedBox(height: 64),
                //     Stack(
                //       children: [
                //         _image != null
                //             ? CircleAvatar(
                //                 radius: 64,
                //                 backgroundImage: MemoryImage(_image!),
                //               )
                //             : const CircleAvatar(
                //                 radius: 64,
                //                 backgroundImage: NetworkImage(
                //                   'https://t3.ftcdn.net/jpg/00/64/67/80/360_F_64678017_zUpiZFjj04cnLri7oADnyMH0XBYyQghG.jpg',
                //                 ),
                //               ),
                //         Positioned(
                //           bottom: -10,
                //           left: 80,
                //           child: IconButton(
                //             onPressed: selectImage,
                //             icon: const Icon(
                //               Icons.add_a_photo,
                //             ),
                //           ),
                //         )
                //       ],
                //     ),
                //     const SizedBox(
                //       height: 24,
                //     ),
                //     // text field input for username
                //     TextFieldInput(
                //       hintText: 'Enter your username',
                //       textInputType: TextInputType.text,
                //       textEditingController: _usernameController,
                //     ),
                //     const SizedBox(
                //       height: 24,
                //     ),
                //     // text input for email
                //     TextFieldInput(
                //       hintText: 'Enter your email',
                //       textInputType: TextInputType.emailAddress,
                //       textEditingController: _emailController,
                //     ),
                //     const SizedBox(
                //       height: 24,
                //     ),
                //     // text input for password
                //     TextFieldInput(
                //       hintText: 'Enter your password',
                //       textInputType: TextInputType.text,
                //       textEditingController: _passwordController,
                //       isPass: true,
                //     ),
                //     const SizedBox(
                //       height: 24,
                //     ),
                //     // text field for bio
                //     TextFieldInput(
                //       hintText: 'Enter your bio',
                //       textInputType: TextInputType.text,
                //       textEditingController: _bioController,
                //     ),
                //     const SizedBox(
                //       height: 24,
                //     ),
                //     // button for login
                //     InkWell(
                //       onTap: signUpUser,
                //       child: Container(
                //         child: _isLoading
                //             ? const Center(
                //                 child: CircularProgressIndicator(
                //                   color: primaryColor,
                //                 ),
                //               )
                //             : const Text(
                //                 'Sign up',
                //                 style: TextStyle(
                //                   color: Colors.white,
                //                   fontWeight: FontWeight.bold,
                //                   fontSize: 16,
                //                 ),
                //               ),
                //         width: double.infinity,
                //         alignment: Alignment.center,
                //         padding: const EdgeInsets.symmetric(vertical: 12),
                //         decoration: const ShapeDecoration(
                //           shape: RoundedRectangleBorder(
                //             borderRadius: BorderRadius.all(
                //               Radius.circular(4),
                //             ),
                //           ),
                //           color: Colors.black,
                //         ),
                //       ),
                //     ),

                //     const SizedBox(
                //       height: 12,
                //     ),
                //     Flexible(
                //       child: Container(),
                //       flex: 2,
                //     ),
                //     // transitioning to sign up
                //     Row(
                //       mainAxisAlignment: MainAxisAlignment.center,
                //       children: [
                //         Container(
                //           padding: const EdgeInsets.symmetric(
                //             vertical: 12,
                //           ),
                //           child: const Text("Already have an account?"),
                //         ),
                //         GestureDetector(
                //           onTap: () {},
                //           child: Container(
                //             padding: const EdgeInsets.symmetric(
                //               vertical: 12,
                //               horizontal: 4,
                //             ),
                //             child: const Text(
                //               "Log in",
                //               style: TextStyle(
                //                 fontWeight: FontWeight.bold,
                //                 color: Colors.lightBlueAccent,
                //               ),
                //             ),
                //           ),
                //         ),
                //       ],
                //     )
                //   ],
                // ),

                // Row(
                //   mainAxisAlignment: MainAxisAlignment.spaceAround,
                //   crossAxisAlignment: CrossAxisAlignment.start,
                //   children: [
                //     Text(
                //       'Create the student',
                //       style: TextStyle(
                //         color: Colors.grey[700],
                //         fontSize: 42,
                //       ),
                //     ),
                //     const Divider(),
                //   ],
                // ),
                // Row(
                //   mainAxisAlignment: MainAxisAlignment.spaceAround,
                //   crossAxisAlignment: CrossAxisAlignment.start,
                //   children: [
                //     const Divider(),
                //   ],
                // ),
                // Row(
                //   mainAxisAlignment: MainAxisAlignment.spaceAround,
                //   crossAxisAlignment: CrossAxisAlignment.start,
                //   children: [
                //     Stack(
                //       children: [
                //         _image != null
                //             ? CircleAvatar(
                //                 radius: 64,
                //                 backgroundImage: MemoryImage(_image!),
                //               )
                //             : const CircleAvatar(
                //                 radius: 64,
                //                 backgroundImage: NetworkImage(
                //                   'https://t3.ftcdn.net/jpg/00/64/67/80/360_F_64678017_zUpiZFjj04cnLri7oADnyMH0XBYyQghG.jpg',
                //                 ),
                //               ),
                //         Positioned(
                //           bottom: -10,
                //           left: 80,
                //           child: IconButton(
                //             onPressed: selectImage,
                //             icon: const Icon(
                //               Icons.add_a_photo,
                //             ),
                //           ),
                //         )
                //       ],
                //     ),
                //     const Divider(),
                //   ],
                // ),
                */ // END OF SIGN UP FORM

                // START OF THE PICTURE UPLOAD FORM
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CircleAvatar(
                      backgroundImage: NetworkImage(
                        user.photoUrl,
                      ),
                    ),
                    // This is the description TextBox
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.3,
                      child: TextField(
                        controller: _descriptionController,
                        decoration: const InputDecoration(
                            hintText: 'Write a caption',
                            border: InputBorder.none),
                        maxLines: 8,
                      ),
                    ),

                    // THIS SHOWS THE IMAGE THAT HAS BEEN JUST SELECTED
                    SizedBox(
                      height: 45,
                      width: 45,
                      child: AspectRatio(
                        aspectRatio: 487 / 451,
                        child: Container(
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: MemoryImage(_file!),
                              fit: BoxFit.fill,
                              alignment: FractionalOffset.topCenter,
                            ),
                          ),
                        ),
                      ),
                    ),
                    const Divider(),
                  ],
                )
              ],
            ),
          );
  }
}
