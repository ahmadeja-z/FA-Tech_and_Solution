import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fasolution/App/Resources/Components/AppBar2.dart';
import 'package:fasolution/App/Utils/ShowMessage/Ui%20Helper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PendingProjectsPage extends StatefulWidget {
  final String userId; // The ID of the user

  const PendingProjectsPage({Key? key, required this.userId}) : super(key: key);

  @override
  _PendingProjectsPageState createState() => _PendingProjectsPageState();
}

class _PendingProjectsPageState extends State<PendingProjectsPage> {
  Future<void> _acceptProject(String projectId) async {
    UiHelper.showLoadingAlert('Accept', context);

    try {
      final userRef =
      FirebaseFirestore.instance.collection('users').doc(widget.userId);
      final projectRef =
      FirebaseFirestore.instance.collection('projects').doc(projectId);

      // Fetch the pending project data
      final pendingProject = await FirebaseFirestore.instance
          .collection('pendingAssignments')
          .doc(widget.userId)
          .collection('projects')
          .doc(projectId)
          .get();

      if (pendingProject.exists) {
        final projectData = pendingProject.data()!;
        final projectTitle = projectData['title'];

        // Move the project to the user's ongoingProjects
        await userRef.update({
          'ongoingProjects': FieldValue.arrayUnion([projectTitle]),
          'ongoingProjectIds': FieldValue.arrayUnion([projectId]),
        });

        // Update the project status
        await projectRef.update({
          'status': 'ongoing', // Update status to 'ongoing'
        }).then(
              (value) => {
            Navigator.pop(context),

          },
        );

        // Remove the project from pendingAssignments
        await FirebaseFirestore.instance
            .collection('pendingAssignments')
            .doc(widget.userId)
            .collection('projects')
            .doc(projectId)
            .delete();

        UiHelper.showErrorDialog('Project Acceptance',
            'Project has been accepted and is now ongoing', context);
      } else {
        UiHelper.showErrorDialog(
            'Error', 'Project not found in pending assignments', context);
      }
    } catch (e) {
      UiHelper.showErrorDialog(
          'Error on accepting project', e.toString(), context);
    } finally {}
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('pendingAssignments')
            .doc(widget.userId)
            .collection('projects')
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text(snapshot.error.toString()));
          }
          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return Center(child: Text('No pending projects.'));
          }

          List<DocumentSnapshot> projects = snapshot.data!.docs;

          return ListView.builder(
            itemCount: projects.length,
            itemBuilder: (context, index) {
              final project = projects[index].data() as Map<String, dynamic>;
              final projectId = project['projectId'] as String;
              final title = project['title'] as String;
              final description = project['description'] as String;
              final status = project['status'] as String;
              final createdAt = project['createdAt'] as String;

              return Card(
                margin: EdgeInsets.all(8.0),
                child: ListTile(
                  contentPadding: EdgeInsets.all(16.0),
                  title: Text(title),
                  subtitle: Text(description),
                  trailing: ElevatedButton(
                    onPressed: () => _acceptProject(projectId),
                    child: Text('Accept'),
                  ),
                  isThreeLine: true,
                ),
              );
            },
          );
        },
      ),
    );
  }
}
