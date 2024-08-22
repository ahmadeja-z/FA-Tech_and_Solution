import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fasolution/App/Model/Model/UserModel.dart';
import 'package:flutter/material.dart';
import '../../../Model/Model/project_model.dart';
import 'Projects/DetailProject/project_detail_screen.dart';
import 'package:intl/intl.dart'; // For date formatting

class ProjectListWidget extends StatelessWidget {
  final List<String> projectIds;
  final UserModel userModel;
  final String status;

  ProjectListWidget({Key? key, required this.projectIds, required this.status, required this.userModel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<ProjectModel>>(
      stream: _getProjectsStream(projectIds, status),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return Center(child: Text('No $status projects.'));
        } else {
          final projects = snapshot.data!;
          final groupedProjects = _groupProjectsByDate(projects);

          return ListView.builder(
            itemCount: groupedProjects.length,
            itemBuilder: (context, index) {
              final date = groupedProjects.keys.elementAt(index);
              final projectsForDate = groupedProjects[date]!;

              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                    child: Text(
                      date,
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.black54,
                      ),
                    ),
                  ),
                  ...projectsForDate.map((project) => Card(
                    margin: EdgeInsets.all(8.0),
                    child: ListTile(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ProjectDetailScreen(
                              project: project,
                              user: userModel,
                            ),
                          ),
                        );
                      },
                      title: Text(project.title),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(project.description),
                          SizedBox(height: 8.0),
                          Text('Assigned Date: ${_formatDate(project.createdAt)}'),
                        ],
                      ),
                    ),
                  )),
                ],
              );
            },
          );
        }
      },
    );
  }

  Stream<List<ProjectModel>> _getProjectsStream(List<String> projectIds, String status) {
    if (projectIds.isEmpty) {
      return Stream.value([]);
    } else {
      return FirebaseFirestore.instance
          .collection('projects')
          .where(FieldPath.documentId, whereIn: projectIds)
          .where('status', isEqualTo: status)
          .snapshots()
          .map((snapshot) => snapshot.docs
          .map((doc) => ProjectModel.fromMap(doc.data()))
          .toList());
    }
  }

  Map<String, List<ProjectModel>> _groupProjectsByDate(List<ProjectModel> projects) {
    final grouped = <String, List<ProjectModel>>{};

    for (var project in projects) {
      final date = _formatDate(project.createdAt); // Format date for display and grouping
      if (!grouped.containsKey(date)) {
        grouped[date] = [];
      }
      grouped[date]!.add(project);
    }

    // Sort dates in descending order
    final sortedKeys = grouped.keys.toList()
      ..sort((a, b) => _parseDate(b).compareTo(_parseDate(a)));

    final sortedGrouped = <String, List<ProjectModel>>{};
    for (var key in sortedKeys) {
      sortedGrouped[key] = grouped[key]!;
    }

    return sortedGrouped;
  }

  DateTime _parseDate(String dateString) {
    try {
      // Parse the date based on your format
      return DateFormat('dd/MM/yyyy').parse(dateString);
    } catch (e) {
      return DateTime.now(); // Fallback to current date if parsing fails
    }
  }

  String _formatDate(String dateString) {
    try {
      final date = _parseDate(dateString);
      return DateFormat('EEEE-dd-MMMM-yyyy').format(date); // Format as "Sunday-01-August-2024"
    } catch (e) {
      return dateString; // Return the original string if formatting fails
    }
  }
}
