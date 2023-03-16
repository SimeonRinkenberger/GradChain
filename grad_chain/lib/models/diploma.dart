import 'dart:ui';
import 'package:cloud_firestore/cloud_firestore.dart';

class DiplomaContainer {
  final List<Diploma> claimed;
  final List<Diploma> unclaimed;
  final String url;

  const DiplomaContainer({
    required this.claimed,
    required this.unclaimed,
    required this.url,
  });

  Map<String, dynamic> toJson() => {
        "claimed": claimed,
        "unclaimed": unclaimed,
        "url": url,
      };

  static DiplomaContainer fromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;

    return DiplomaContainer(
      claimed: snapshot["claimed"],
      unclaimed: snapshot["unclaimed"],
      url: snapshot["url"],
    );
  }
}

class Diploma {
  final String name;
  final String uid;
  final String major;
  final String type;
  final String university;
  final int gpa;

  const Diploma({
    required this.name,
    required this.uid,
    required this.major,
    required this.type,
    required this.university,
    required this.gpa,
  });

  Map<String, dynamic> toJson() => {
        "name": name,
        "uid": uid,
        "major": major,
        "type": type,
        "university": university,
        "gpa": gpa,
      };

  static Diploma fromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;

    return Diploma(
      name: snapshot["name"],
      uid: snapshot["uid"],
      major: snapshot["major"],
      type: snapshot["type"],
      university: snapshot["university"],
      gpa: snapshot["gpa"],
    );
  }
}
