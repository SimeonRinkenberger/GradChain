import 'package:cloud_firestore/cloud_firestore.dart';

class Student {
  final String username;
  final String uid;
  final String uniId;
  final String email;
  final String bio;
  final String photoUrl;
  final int cli_type;

  const Student({
    required this.email,
    required this.uid,
    required this.photoUrl,
    required this.username,
    required this.bio,
    required this.cli_type,
    required this.uniId,
  });

  Map<String, dynamic> toJson() => {
        "username": username,
        "uid": uid,
        "email": email,
        "photoUrl": photoUrl,
        "bio": bio,
        "cli_type": cli_type,
        "uniId": uniId,
      };

  static Student fromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;

    return Student(
      username: snapshot["username"],
      uid: snapshot["uid"],
      email: snapshot["email"],
      photoUrl: snapshot["photoUrl"],
      bio: snapshot["bio"],
      cli_type: snapshot["cli_type"],
      uniId: snapshot["uniId"],
    );
  }
}
