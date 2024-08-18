import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../../../main.dart';
import '../../../Model/Model/announsmentsModel.dart';
import '../../../Resources/Color.dart';

class CreateAnnouncementPage extends StatefulWidget {
  const CreateAnnouncementPage({Key? key}) : super(key: key);

  @override
  _CreateAnnouncementPageState createState() => _CreateAnnouncementPageState();
}

class _CreateAnnouncementPageState extends State<CreateAnnouncementPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Create Announcement'),
        backgroundColor: FColor.primaryColor1,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFormField(
                controller: _titleController,
                decoration: InputDecoration(
                  labelText: 'Title',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a title';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16.0),
              TextFormField(
                controller: _descriptionController,
                maxLines: 5,
                decoration: InputDecoration(
                  labelText: 'Description',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a description';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: () => _createAnnouncement(context),
                style: ElevatedButton.styleFrom(
                  backgroundColor: FColor.primaryColor1,
                  padding: const EdgeInsets.symmetric(vertical: 12.0),
                ),
                child: const Center(
                  child: Text(
                    'Create Announcement',
                    style: TextStyle(fontSize: 18.0,color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _createAnnouncement(BuildContext context) async {
    String announcementId=uid.v1();
    if (_formKey.currentState!.validate()) {
      final announcement = Announcement(
        id: announcementId, // Firestore will generate the ID automatically
        title: _titleController.text,
        description: _descriptionController.text,
        dateCreated: DateTime.now(),
      );

      await FirebaseFirestore.instance.collection('announcements').doc(announcementId).set(announcement.toMap());

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Announcement created successfully!')),
      );

      _titleController.clear();
      _descriptionController.clear();
    }
  }
}
