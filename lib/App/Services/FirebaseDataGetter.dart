import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fasolution/App/Services/FirebaseHelper.dart';
import 'package:fasolution/App/UI/admin_panel/projects/AssigningProjects/assign_project.dart';
import 'package:flutter/material.dart';
import 'package:fasolution/App/Model/Model/UserModel.dart';
import 'package:fasolution/App/Resources/Components/PersonCard.dart';
import '../UI/NavBar/Home/detail_person_info.dart';

class UserListWidget extends StatelessWidget {
  final String role;
  final String whichRole;
  final String emptyMessage;
  final String career;
  final String whichCareer;

  const UserListWidget({
    Key? key,
    this.emptyMessage = 'No users found',
    required this.role,
    required this.whichCareer,
    required this.career,
    required this.whichRole,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance
          .collection('users')
          .where(role, isEqualTo: whichRole)
          .where(career, isEqualTo: whichCareer)
          .snapshots(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        }
        if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        }
        if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
          return Center(child: Text(emptyMessage));
        }

        List<UserModel> users = snapshot.data!.docs.map((doc) {
          return UserModel.fromMap(doc.data() as Map<String, dynamic>);
        }).toList();

        return ListView.builder(
          itemCount: users.length,
          itemBuilder: (context, index) {
            UserModel user = users[index];
            return GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => DetailProfileInfo(
                      name: user.name.toString(),
                      profileImage: user.profilePictureUrl.toString(),
                      role: user.role.toString(),
                      surName: user.surName.toString(),
                      carrier: user.carrier.toString(),
                      attendance: user.attendance.toString(),
                      email: user.email.toString(),
                      joiningDate: user.joiningDate.toString(),
                      OnDelete: () {
                       FirebaseHelper. deleteUserWithConfirmation(context, user.userId.toString());
                      },
                      OnAssign: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context) => AssignProjectPage(userId: user.userId.toString()  , userName: user.name.toString()),));
                      },
                    ),
                  ),
                );
              },
              child: PersonCard(
                name: user.name.toString(),
                profilePictureUrl: user.profilePictureUrl.toString(),
                joiningDate: user.joiningDate.toString(),
                career: user.carrier.toString(),
                email: user.email.toString(),
                role: user.role.toString(),
              ),
            );
          },
        );
      },
    );
  }

}
