

import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  String? id;
  String? userId;
  String? profileImage;
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
  int? attendance;

  UserModel({
    this.id,
    this.userId,
    this.name,
    this.profileImage,
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

  factory UserModel.fromDocument(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    return UserModel(
      id: doc.id,
      userId: data['userId'],
      name: data['name'] ?? '',
      surName: data['surName']??'',
      email: data['email'] ?? '',
      profileImage: data['profileImage']??'',

      profilePictureUrl: data['profilePictureUrl'] ?? '',
      cvUrl: data['cvUrl'] ?? '',
      resultCardUrl: data['resultCardUrl'] ?? '',
      experienceLetterUrl: data['experienceLetterUrl'] ?? '',
      carrier: data['carrier'],
      joiningDate: data['joiningDate'],
      role: data['role'] ?? '',
      completedProjects: List<String>.from(data['completedProjects'] ?? []),
      ongoingProjects: List<String>.from(data['ongoingProjects'] ?? []),
      attendance: data['attendance'] ?? 0,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'userId':userId,
      'name': name,
      'surName':surName,
      'profileImage':profileImage,
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
}
