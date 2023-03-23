import 'package:cloud_firestore/cloud_firestore.dart';

class Diploma {
  final String description;
  final String uid;
  final String username;
  final String diplomaId;
  final DateTime datePublished;
  final String diplomaUrl;
  final String profImage;
  final claimed;

  const Diploma({
    required this.description,
    required this.uid,
    required this.username,
    required this.claimed,
    required this.diplomaId,
    required this.datePublished,
    required this.diplomaUrl,
    required this.profImage,
  });

  Map<String, dynamic> toJson() => {
        "description": description,
        "uid": uid,
        "claimed": claimed,
        "username": username,
        "diplomaId": diplomaId,
        "datePublished": datePublished,
        'diplomaUrl': diplomaUrl,
        'profImage': profImage
      };

  static Diploma fromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;

    return Diploma(
        description: snapshot["description"],
        uid: snapshot["uid"],
        claimed: snapshot["claimed"],
        diplomaId: snapshot["diplomaId"],
        datePublished: snapshot["datePublished"],
        username: snapshot["username"],
        diplomaUrl: snapshot['diplomaUrl'],
        profImage: snapshot['profImage']);
  }
}
