import 'package:cloud_firestore/cloud_firestore.dart';

class Diploma {
  final String description;
  final String studentId;
  final String university;
  final String diplomaId;
  final DateTime datePublished;
  final String diplomaUrl;
  final claimed;
  final String bChainHash;

  const Diploma({
    required this.description,
    required this.studentId,
    required this.university,
    required this.claimed,
    required this.diplomaId,
    required this.datePublished,
    required this.diplomaUrl,
    required this.bChainHash,
    //required this.profImage,
  });

  Map<String, dynamic> toJson() => {
        "description": description,
        "studentId": studentId,
        "claimed": claimed,
        "university": university,
        "diplomaId": diplomaId,
        "datePublished": datePublished,
        'diplomaUrl': diplomaUrl,
        "bChainHash": bChainHash,
        //'profImage': profImage
      };

  static Diploma fromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;

    return Diploma(
      description: snapshot["description"],
      studentId: snapshot["studentId"],
      claimed: snapshot["claimed"],
      diplomaId: snapshot["diplomaId"],
      datePublished: snapshot["datePublished"],
      university: snapshot["university"],
      diplomaUrl: snapshot['diplomaUrl'],
      bChainHash: snapshot["bChainHash"],
      //profImage: snapshot['profImage'],
    );
  }
}
