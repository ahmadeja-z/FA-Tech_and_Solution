import 'package:cloud_firestore/cloud_firestore.dart';

class ProjectModel {
  final String id;
  final String title;
  final String description;
  final String assignedTo;
  final String status; // e.g., assigned, in-progress, completed
  final Timestamp createdAt;
  final Timestamp updatedAt;

  ProjectModel({
    required this.id,
    required this.title,
    required this.description,
    required this.assignedTo,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
  });

  // Convert a ProjectModel instance to a map
  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'description': description,
      'assignedTo': assignedTo,
      'status': status,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
    };
  }

  // Create a ProjectModel instance from a map
  factory ProjectModel.fromMap(Map<String, dynamic> map, String id) {
    return ProjectModel(
      id: id,
      title: map['title'],
      description: map['description'],
      assignedTo: map['assignedTo'],
      status: map['status'],
      createdAt: map['createdAt'],
      updatedAt: map['updatedAt'],
    );
  }
}
