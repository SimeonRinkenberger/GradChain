import 'package:cloud_firestore/cloud_firestore.dart';

class Diploma {
  final String description;
  final String uid;
  final String university;
  final String diplomaId;
  final DateTime datePublished;
  final String diplomaUrl;
  //final String profImage;
  final claimed;
  final String bChainUrl;

  const Diploma({
    required this.description,
    required this.uid,
    required this.university,
    required this.claimed,
    required this.diplomaId,
    required this.datePublished,
    required this.diplomaUrl,
    required this.bChainUrl,
    //required this.profImage,
  });

  Map<String, dynamic> toJson() => {
        "description": description,
        "uid": uid,
        "claimed": claimed,
        "university": university,
        "diplomaId": diplomaId,
        "datePublished": datePublished,
        'diplomaUrl': diplomaUrl,
        "bChainUrl": bChainUrl,
        //'profImage': profImage
      };

  static Diploma fromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;

    return Diploma(
      description: snapshot["description"],
      uid: snapshot["uid"],
      claimed: snapshot["claimed"],
      diplomaId: snapshot["diplomaId"],
      datePublished: snapshot["datePublished"],
      university: snapshot["university"],
      diplomaUrl: snapshot['diplomaUrl'],
      bChainUrl: snapshot["bChainUrl"],
      //profImage: snapshot['profImage'],
    );
  }
}
