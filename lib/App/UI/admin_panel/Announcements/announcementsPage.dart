import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fasolution/App/UI/admin_panel/Announcements/makeAnouncementsPage.dart';
import 'package:fasolution/App/Utils/ShowMessage/Ui%20Helper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../../Model/Model/announsmentsModel.dart';
import '../../../Resources/Color.dart';


class adminAnnouncementsPage extends StatelessWidget {
  const adminAnnouncementsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Announcements'),
        backgroundColor: FColor.primaryColor1,
      ),
      body: Column(
        children: [
          TextButton(onPressed: (){Navigator.push(context, MaterialPageRoute(builder: (context) => CreateAnnouncementPage(),));}, child: Text('Make a new announcement',style: TextStyle(color: Colors.blue,fontFamily: 'Poppins',decoration:TextDecoration.underline),)),
       SizedBox(
         height: 10,
       ),
          Expanded(
            child: StreamBuilder(
              stream: FirebaseFirestore.instance.collection('announcements').orderBy('dateCreated',descending: true).snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    return Center(child: Text('Error: ${snapshot.error}'));
                  }

                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                    return const Center(child: Text('No announcements available.'));
                  }

                  final announcements = snapshot.data!.docs.map((doc) {
                    return Announcement.fromMap(doc.data() as Map<String, dynamic>);
                  }).toList();

                  return ListView.builder(
                    itemCount: announcements.length,
                    itemBuilder: (context, index) {
                      final announcement = announcements[index];
                      return Card(
                        elevation: 4.0,
                        margin: const EdgeInsets.all(8.0),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
                        child: ListTile(
                          leading: IconButton(onPressed: (){
                            _deleteAnnouncement(context, announcement.id);
                          }, icon: Icon(Icons.delete_outline,color: Colors.red,)),
                          title: Text(
                            announcement.title.toString(),
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                          subtitle: Text(
                            announcement.description.toString(),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                          trailing: Text(
                            announcement.dateCreated.toString().split(' ')[0], // Show only the date
                            style: const TextStyle(color: Colors.grey),
                          ),
                          onTap: () {
                            UiHelper.showErrorDialog(announcement.title.toString(),announcement.description.toString(),context);
                          },
                        ),
                      );
                    },
                  );
                }

            ),
          ),
          TextButton(onPressed: (){}, child: Icon(Icons.abc))
        ],
      ),
    );
  }
  void _deleteAnnouncement(BuildContext context, String? id) async {
    if (id == null) return;

    // Show confirmation dialog before deleting
    final shouldDelete = await showDialog<bool>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Delete Announcement'),
          content: const Text('Are you sure you want to delete this announcement?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(false),
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () => Navigator.of(context).pop(true),
              child: const Text('Delete'),
            ),
          ],
        );
      },
    );

    // If the user confirmed, proceed with deletion
    if (shouldDelete == true) {
      await FirebaseFirestore.instance.collection('announcements').doc(id).delete();

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Announcement deleted successfully!')),
      );
    }
  }


}
