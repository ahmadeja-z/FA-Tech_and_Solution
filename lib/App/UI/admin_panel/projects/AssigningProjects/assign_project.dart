import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fasolution/App/Resources/Components/AppBar2.dart';
import 'package:fasolution/App/Utils/ShowMessage/Ui%20Helper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class AssignProjectPage extends StatefulWidget {
  final String userId; // The ID of the user to whom the project will be assigned
  final String userName;

  const AssignProjectPage({
    Key? key,
    required this.userId,
    required this.userName,
  }) : super(key: key);

  @override
  _AssignProjectPageState createState() => _AssignProjectPageState();
}

class _AssignProjectPageState extends State<AssignProjectPage> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  String _selectedProjectType = 'Flutter'; // Default value
  bool _isLoading = false;

  final List<String> _projectTypes = [
    'Flutter',
    'Web Development',
    'FlutterFlow'
  ];

  Future<void> _assignProject() async {
    if (_titleController.text.isEmpty ||
        _descriptionController.text.isEmpty ||
        _selectedProjectType.isEmpty) {
      UiHelper.showErrorDialog(
          'Requirements', 'Please fill all the requirements', context);
      return;
    }

    setState(() {
      _isLoading = true;
    });

    try {
      final projectRef = FirebaseFirestore.instance.collection('projects').doc();
      String formattedDate = DateFormat('dd/MM/yyyy').format(DateTime.now());

      // Create the project
      await projectRef.set({
        'projectId': projectRef.id,
        'title': _titleController.text,
        'description': _descriptionController.text,
        'assignedTo': widget.userName,
        'status': 'pending', // Set status to 'pending'
        'type': _selectedProjectType, // Store selected project type
        'createdAt': formattedDate,
        'updatedAt': formattedDate
      });

      // Create a pending assignment notification
      await FirebaseFirestore.instance.collection('pendingAssignments').doc(widget.userId).collection('projects').doc(projectRef.id).set({
        'projectId': projectRef.id,
        'title': _titleController.text,
        'description': _descriptionController.text,
        'status': 'pending', // Set status to 'pending'
        'type': _selectedProjectType,
        'createdAt': formattedDate,
      });

      // Notify the user about the pending project
      // You can implement a notification system here, depending on your setup

      UiHelper.showErrorDialog(
          'Project Assign', 'Project assigned pending user confirmation', context);
      _titleController.clear();
      _descriptionController.clear();
      setState(() {
        _selectedProjectType = _projectTypes.first; // Reset to default value
      });
    } catch (e) {
      UiHelper.showErrorDialog('Error on assigning', e.toString(), context);
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }



  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomizableAppBar(
        leadingIcon: Icon(CupertinoIcons.back),
        title: 'Assign Project to ${widget.userName}',
        onLeadingPressed: () {
          Navigator.pop(context);
        },
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: _titleController,
              decoration: InputDecoration(
                labelText: 'Project Title',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 20),
            TextField(
              controller: _descriptionController,
              maxLines: 4,
              decoration: InputDecoration(
                labelText: 'Project Description',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 20),
            DropdownButtonFormField<String>(
              value: _selectedProjectType,
              decoration: InputDecoration(
                labelText: 'Project Type',
                border: OutlineInputBorder(),
              ),
              items: _projectTypes.map((String type) {
                return DropdownMenuItem<String>(
                  value: type,
                  child: Text(type),
                );
              }).toList(),
              onChanged: (String? newValue) {
                setState(() {
                  _selectedProjectType = newValue!;
                });
              },
            ),
            SizedBox(height: 20),
            _isLoading
                ? Center(child: CircularProgressIndicator())
                : ElevatedButton(
              onPressed: _assignProject,
              child: Text('Assign Project'),
            ),
          ],
        ),
      ),
    );
  }
}
