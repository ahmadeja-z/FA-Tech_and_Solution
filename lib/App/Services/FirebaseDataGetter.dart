import 'package:cloud_firestore/cloud_firestore.dart';
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
                        deleteUserWithConfirmation(context, user.userId.toString());
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

  Future<void> deleteUserWithConfirmation(BuildContext context, String userId) async {
    // Show confirmation dialog
    bool? confirmDeletion = await showDialog<bool>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Confirm Deletion'),
          content: Text('Are you sure you want to delete this user?'),
          actions: <Widget>[
            TextButton(
              child: Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop(false); // Close the dialog and return false
              },
            ),
            TextButton(
              child: Text('Confirm'),
              onPressed: () {
                Navigator.of(context).pop(true); // Close the dialog and return true
              },
            ),
          ],
        );
      },
    );

    // Proceed with deletion if confirmed
    if (confirmDeletion == true) {
      try {
        // Perform the deletion
        await FirebaseFirestore.instance.collection('users').doc(userId).delete();
print(userId);
        // Show success message
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('User deleted successfully')),
        );
        Navigator.pop(context);
      } catch (e) {
        // Show error message
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to delete user: $e')),
        );
      }
    }
  }
}
