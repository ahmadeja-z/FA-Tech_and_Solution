import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../../../Model/Model/UserModel.dart';
import '../../../Resources/Components/AppBar.dart';


class UserProjectsScreen extends StatefulWidget {
  final UserModel userModel;

  UserProjectsScreen({Key? key, required this.userModel}) : super(key: key);

  @override
  _UserProjectsScreenState createState() => _UserProjectsScreenState();
}

class _UserProjectsScreenState extends State<UserProjectsScreen> {
  late Future<List<Project>> _projectsFuture;

  @override
  void initState() {
    super.initState();
    _projectsFuture = _fetchProjects();
  }

  Future<List<Project>> _fetchProjects() async {
    List<Project> projects = [];
    List<String>? projectNames = widget.userModel.ongoingProjects;

    if (projectNames == null || projectNames.isEmpty) {
      // Debugging
      print('No ongoing projects found in user model.');
      return projects;
    }

    for (String projectName in projectNames) {
      try {
        final projectSnapshot = await FirebaseFirestore.instance
            .collection('projects')
            .where('title', isEqualTo: projectName)
            .get();

        if (projectSnapshot.docs.isEmpty) {
          // Debugging
          print('No project found with name: $projectName');
        }

        for (var doc in projectSnapshot.docs) {
          final projectData = doc.data();
          projects.add(Project.fromMap(projectData));
        }
      } catch (e) {
        // Debugging
        print('Error fetching project $projectName: $e');
      }
    }

    return projects;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomizedAppBar(
        title: 'User Projects',
        UserId: widget.userModel.userId.toString(),
      ),
      body: FutureBuilder<List<Project>>(
        future: _projectsFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No projects assigned.'));
          } else {
            final projects = snapshot.data!;
            return ListView.builder(
              itemCount: projects.length,
              itemBuilder: (context, index) {
                final project = projects[index];
                // return ListTile(
                //   title: Text(project.title),
                //   subtitle: Text(project.description),
                //   onTap: () {
                //     Navigator.push(
                //       context,
                //       MaterialPageRoute(
                //         builder: (context) => ProjectDetailScreen(project: project),
                //       ),
                //     );
                //   },
                // );
              },
            );
          }
        },
      ),
    );
  }
}

class Project {
  final String id;
  final String title;
  final String description;
  final String status;
  final String type;
  final String createdAt;
  final String updatedAt;

  Project({
    required this.id,
    required this.title,
    required this.description,
    required this.status,
    required this.type,
    required this.createdAt,
    required this.updatedAt,
  });

  Project.fromMap(Map<String, dynamic> map)
      : id = map['projectId'],
        title = map['title'],
        description = map['description'],
        status = map['status'],
        type = map['type'],
        createdAt = map['createdAt'],
        updatedAt = map['updatedAt'];

  Map<String, dynamic> toMap() {
    return {
      'projectId': id,
      'title': title,
      'description': description,
      'status': status,
      'type': type,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
    };
  }
}
