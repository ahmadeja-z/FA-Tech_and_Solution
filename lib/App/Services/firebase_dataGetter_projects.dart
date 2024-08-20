import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fasolution/App/Model/Model/project_model.dart';
import 'package:fasolution/App/Services/FirebaseHelper.dart';
import 'package:fasolution/App/Utils/ShowMessage/Ui%20Helper.dart';
import 'package:flutter/material.dart';

import '../Resources/Components/assingned_project_info.dart';

class AssignedProject extends StatefulWidget {
  final String roleType; // Role type to filter projects

  const AssignedProject({super.key, required this.roleType});

  @override
  State<AssignedProject> createState() => _AssignedProjectState();
}

class _AssignedProjectState extends State<AssignedProject> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('projects')
            .where('type', isEqualTo: widget.roleType) // Use the roleType to filter
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text(snapshot.error.toString()));
          }
          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return Center(child: Text('There are no projects assigned.'));
          }

          // Parse the snapshot data into a list of ProjectModel objects
          List<ProjectModel> projectInfo = snapshot.data!.docs.map((doc) {
            return ProjectModel.fromMap(doc.data() as Map<String, dynamic>);
          }).toList();

          return ListView.builder(
            itemCount: projectInfo.length,
            itemBuilder: (context, index) {
              return ProjectInfoWidget(
                onDelete: () {
                  showDeleteConfirmationDialog(
                    context,
                    projectInfo[index].projectId,
                  );
                },
                title: projectInfo[index].title,
                description: projectInfo[index].description,
                assignedTo: projectInfo[index].assignedTo,
                status: projectInfo[index].status,
                createdAt: projectInfo[index].createdAt,
                updatedAt: projectInfo[index].updatedAt,
              );
            },
          );
        },
      ),
    );
  }

  Future<void> showDeleteConfirmationDialog(
      BuildContext context, String projectId) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // User must tap a button to dismiss
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Confirm Deletion'),
          content: Text('Are you sure you want to delete this project?'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () async {
                Navigator.of(context).pop(); // Close the dialog
                try {
                  await FirebaseFirestore.instance
                      .collection('projects')
                      .doc(projectId)
                      .delete();
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Project deleted successfully')),
                  );
                } catch (e) {
                  print('Error deleting project: $e');
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Error: $e')),
                  );
                }
              },
              child: Text('Delete'),
            ),
          ],
        );
      },
    );
  }
}
