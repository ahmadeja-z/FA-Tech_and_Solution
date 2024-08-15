import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  String? id;
  String? userId;
  String? name;
  String? surName;
  String? email;
  String? profilePictureUrl;
  String? cvUrl;
  String? resultCardUrl;
  String? experienceLetterUrl;
  String? carrier;
  String? joiningDate;
  String? role;
  List<String>? completedProjects;
  List<String>? ongoingProjects;
  String ? attendance;

  UserModel({
    this.id,
    this.userId,
    this.name,
    this.surName,
    this.email,
    this.profilePictureUrl,
    this.cvUrl,
    this.resultCardUrl,
    this.experienceLetterUrl,
    this.carrier,
    this.joiningDate,
    this.role,
    this.completedProjects,
    this.ongoingProjects,
    this.attendance,
  });

  UserModel.fromMap(Map<String, dynamic> map) {
    userId = map['userId'];
    name = map['name'] ?? '';
    surName = map['surName'] ?? '';
    email = map['email'] ?? '';
    profilePictureUrl = map['profilePictureUrl'] ?? '';
    cvUrl = map['cvUrl'] ?? '';
    resultCardUrl = map['resultCardUrl'] ?? '';
    experienceLetterUrl = map['experienceLetterUrl'] ?? '';
    carrier = map['carrier'];
    joiningDate = map['joiningDate'];
    role = map['role'] ?? '';
    completedProjects = List<String>.from(map['completedProjects'] ?? []);
    ongoingProjects = List<String>.from(map['ongoingProjects'] ?? []);
    attendance = map['attendance'] ?? '0';
  }

  Map<String, dynamic> toMap() {
    return {
      'userId': userId,
      'name': name,
      'surName': surName,
      'email': email,
      'profilePictureUrl': profilePictureUrl,
      'cvUrl': cvUrl,
      'resultCardUrl': resultCardUrl,
      'experienceLetterUrl': experienceLetterUrl,
      'carrier': carrier,
      'joiningDate': joiningDate,
      'role': role,
      'completedProjects': completedProjects,
      'ongoingProjects': ongoingProjects,
      'attendance': attendance,
    };
  }

  @override
  String toString() {
    return 'UserModel(id: $id, userId: $userId, name: $name, surName: $surName, email: $email, profilePictureUrl: $profilePictureUrl, cvUrl: $cvUrl, resultCardUrl: $resultCardUrl, experienceLetterUrl: $experienceLetterUrl, carrier: $carrier, joiningDate: $joiningDate, role: $role, completedProjects: $completedProjects, ongoingProjects: $ongoingProjects, attendance: $attendance)';
  }
}
