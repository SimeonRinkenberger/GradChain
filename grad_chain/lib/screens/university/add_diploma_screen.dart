import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

import 'package:grad_chain/models/user.dart';
import 'package:grad_chain/providers/user_provider.dart';
import 'package:grad_chain/resources/firestore_methods.dart';
import 'package:grad_chain/utils/colors.dart';
import 'package:grad_chain/utils/utils.dart';

class AddDiplomaScreen extends StatefulWidget {
  const AddDiplomaScreen({super.key});

  @override
  State<AddDiplomaScreen> createState() => _AddDiplomaScreenState();
}

class _AddDiplomaScreenState extends State<AddDiplomaScreen> {
  Uint8List? _file;
  final TextEditingController _descriptionController1 = TextEditingController();
  final TextEditingController _descriptionController2 = TextEditingController();
  final TextEditingController _descriptionController3 = TextEditingController();
  final TextEditingController _descriptionController4 = TextEditingController();
  final TextEditingController _descriptionController5 = TextEditingController();

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
          _descriptionController1.text, _file!, uid, username, profImage);

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

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    // ADD ALL CONTROLLERS
    _descriptionController1.dispose();
    _descriptionController2.dispose();
    _descriptionController3.dispose();
    _descriptionController4.dispose();
    _descriptionController5.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final User user = Provider.of<UserProvider>(context).getUser;
    debugPrint(user.photoUrl);

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
            backgroundColor: Colors.grey[300],
            appBar: AppBar(
              backgroundColor: mobileBackgroundColor,
              leading: IconButton(
                icon: const Icon(Icons.arrow_back),
                onPressed: clearImage,
              ),
              title: const Text('Post to'),
              centerTitle: false,
              actions: [
                TextButton(
                  onPressed: () => postImage(
                    user.uid,
                    user.username,
                    user.photoUrl,
                  ),
                  child: const Text(
                    'Post',
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
                    Column(
                      children: [
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.3,
                          height: MediaQuery.of(context).size.height * 0.10,
                          child: TextField(
                            controller: _descriptionController1,
                            decoration: const InputDecoration(
                                hintText: 'Write a caption',
                                border: InputBorder.none),
                            maxLines: 8,
                          ),
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.3,
                          height: MediaQuery.of(context).size.height * 0.10,
                          child: TextField(
                            controller: _descriptionController2,
                            decoration: const InputDecoration(
                                hintText: 'Write a caption',
                                border: InputBorder.none),
                            maxLines: 8,
                          ),
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.3,
                          height: MediaQuery.of(context).size.height * 0.10,
                          child: TextField(
                            controller: _descriptionController3,
                            decoration: const InputDecoration(
                                hintText: 'Write a caption',
                                border: InputBorder.none),
                            maxLines: 8,
                          ),
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.3,
                          height: MediaQuery.of(context).size.height * 0.10,
                          child: TextField(
                            controller: _descriptionController4,
                            decoration: const InputDecoration(
                                hintText: 'Write a caption',
                                border: InputBorder.none),
                            maxLines: 8,
                          ),
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.3,
                          height: MediaQuery.of(context).size.height * 0.10,
                          child: TextField(
                            controller: _descriptionController5,
                            decoration: const InputDecoration(
                                hintText: 'Write a caption',
                                border: InputBorder.none),
                            maxLines: 8,
                          ),
                        ),
                      ],
                    ),

                    // IMAGE UPLOADED
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
