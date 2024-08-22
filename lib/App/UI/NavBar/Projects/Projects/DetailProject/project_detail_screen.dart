import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fasolution/App/Resources/Components/AppBar2.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../../../../Model/Model/UserModel.dart';
import '../../../../../Model/Model/project_model.dart';

class ProjectDetailScreen extends StatefulWidget {
  final ProjectModel project;
  final UserModel user;

  ProjectDetailScreen({Key? key, required this.project, required this.user})
      : super(key: key);

  @override
  _ProjectDetailScreenState createState() => _ProjectDetailScreenState();
}

class _ProjectDetailScreenState extends State<ProjectDetailScreen> {
  bool _isLoading = false;
  String _projectStatus = 'loading'; // Initialize with a default value

  @override
  void initState() {
    super.initState();
    _fetchProjectStatus();
  }

  Future<void> _fetchProjectStatus() async {
    try {
      DocumentSnapshot projectSnapshot = await FirebaseFirestore.instance
          .collection('projects')
          .doc(widget.project.projectId)
          .get();
      setState(() {
        _projectStatus = projectSnapshot['status'] ?? 'unknown';
      });
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to fetch project status: $e')),
      );
    }
  }

  Future<void> _markAsCompleted() async {
    setState(() {
      _isLoading = true;
    });

    try {
      String formattedDate = DateFormat('dd/MM/yyyy').format(DateTime.now());
      await FirebaseFirestore.instance
          .collection('projects')
          .doc(widget.project.projectId)
          .update({
        'status': 'completed',
        'updatedAt': formattedDate,
      });

      await FirebaseFirestore.instance
          .collection('users')
          .doc(widget.user.userId)
          .update({
        'ongoingProjects': FieldValue.arrayRemove([widget.project.title]),
        'completedProjects': FieldValue.arrayUnion([widget.project.title]),
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Project marked as completed!')),
      );
      setState(() {
        _projectStatus = 'completed';
      });
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to mark as completed: $e')),
      );
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomizableAppBar(
        title: 'Project detail',
        leadingIcon: Icon(CupertinoIcons.back),
        onLeadingPressed: () {
          Navigator.pop(context);
        },
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 200,
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                image: DecorationImage(
                    image: AssetImage(
                        'assets/images/project.jpg'), // Replace with your image
                    fit: BoxFit.cover,
                    opacity: 0.2),
              ),
              child: Center(
                child: Text(
                  widget.project.title,
                  style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                      fontFamily: 'Lato'),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            SizedBox(height: 16),
            Card(
              elevation: 4,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Description:',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 8),
                    Text(widget.project.description),
                    SizedBox(height: 16),
                    Text(
                      'Type:',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 8),
                    Text(widget.project.type),
                    SizedBox(height: 16),
                    Text(
                      'Status:',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 8),
                    Text(_projectStatus),
                    SizedBox(height: 16),
                    Text(
                      'Created At:',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 8),
                    Text(widget.project.createdAt),
                    SizedBox(height: 16),
                    Text(
                      'Updated At:',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 8),
                    Text(widget.project.updatedAt),
                  ],
                ),
              ),
            ),
            SizedBox(height: 24),
            Center(
              child: _projectStatus == 'completed'
                  ? ElevatedButton(
                      onPressed: null,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.grey,
                        padding:
                            EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                      child: Text(
                        'Completed',
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                    )
                  : ElevatedButton(
                      onPressed: _isLoading ? null : _markAsCompleted,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue.withOpacity(.7),
                        padding:
                            EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                      child: _isLoading
                          ? CircularProgressIndicator()
                          : Text(
                              'Mark as Completed',
                              style: TextStyle(color: Colors.white,
                                  fontSize: 16, fontWeight: FontWeight.bold),
                            ),
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
