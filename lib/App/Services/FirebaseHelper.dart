import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fasolution/App/Model/Model/UserModel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class FirebaseHelper {
  static Future<UserModel?> getInfo(String userId) async {
    UserModel? userModel;
    DocumentSnapshot docSnap =
        await FirebaseFirestore.instance.collection('users').doc(userId).get();

    if (docSnap.data() != null) {
      return userModel =
          UserModel.fromMap(docSnap.data() as Map<String, dynamic>);
    }
    return userModel;
  }
 static Future<void> deleteUserWithConfirmation(BuildContext context, String userId) async {
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
