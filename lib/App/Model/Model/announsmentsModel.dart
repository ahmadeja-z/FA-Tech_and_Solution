import 'package:cloud_firestore/cloud_firestore.dart';

class Announcement {
  String? id;
  String? title;
  String? description;
  DateTime? dateCreated;

  Announcement({
    required this.id,
    required this.title,
    required this.description,
    required this.dateCreated,
  });

  // Factory constructor to create an Announcement from a map
  factory Announcement.fromMap(Map<String, dynamic> map) {
    return Announcement(
      id: map['id'] as String?,
      title: map['title'] as String?,
      description: map['description'] as String?,
      // Handling dateCreated if it's stored as a Timestamp in Firestore
      dateCreated: map['dateCreated'] is Timestamp
          ? (map['dateCreated'] as Timestamp).toDate()
          : DateTime.tryParse(map['dateCreated'] as String? ?? ''),
    );
  }

  // Method to convert an Announcement to a JSON map
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'dateCreated': dateCreated?.toIso8601String(),
    };
  }
}
