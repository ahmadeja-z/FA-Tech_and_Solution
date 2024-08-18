import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fasolution/App/Utils/ShowMessage/Ui%20Helper.dart';
import 'package:flutter/material.dart';
import '../../../Model/Model/announsmentsModel.dart';
import '../../../Resources/Color.dart';
import 'package:intl/intl.dart';

class AnnouncementsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        automaticallyImplyLeading: false,
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('announcements')
            .orderBy('dateCreated', descending: true)
            .snapshots(),
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

          final groupedAnnouncements = _groupAnnouncementsByMonthAndDay(announcements);

          return ListView.builder(
            itemCount: groupedAnnouncements.length,
            itemBuilder: (context, index) {
              final month = groupedAnnouncements.keys.elementAt(index);
              final days = groupedAnnouncements[month]!;

              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Align(
                      alignment: Alignment.bottomRight,
                      child: Container(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          month,
                          style: const TextStyle(
                            fontSize: 20,
                            fontFamily: 'Poppins'
                          ),
                        ),
                      ),
                    ),
                    ...days.entries.map((dayEntry) {
                      final day = dayEntry.key;
                      final dayAnnouncements = dayEntry.value;

                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 4.0, horizontal: 8.0),
                            child: Text(
                              day,
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold, color: FColor.primaryColor1),
                            ),
                          ),
                          ...dayAnnouncements.map((announcement) {
                            return Card(
                              elevation: 6.0,
                              margin: const EdgeInsets.all(8.0),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(16.0)),
                              child: ListTile(
                                leading: Icon(Icons.announcement, color: FColor.primaryColor1),
                                title: Text(
                                  announcement.title.toString(),
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold, fontSize: 16),
                                ),
                                subtitle: Text(
                                  announcement.description.toString(),
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                trailing: Text(
                                  DateFormat('yyyy-MM-dd')
                                      .format(announcement.dateCreated!),
                                  style: const TextStyle(color: Colors.grey),
                                ),
                                onTap: () {
                                  UiHelper.showErrorDialog(
                                    announcement.title.toString(),
                                    announcement.description.toString(),
                                    context,
                                  );
                                },
                              ),
                            );
                          }).toList(),
                        ],
                      );
                    }).toList(),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }

  Map<String, Map<String, List<Announcement>>> _groupAnnouncementsByMonthAndDay(
      List<Announcement> announcements) {
    final Map<String, Map<String, List<Announcement>>> groupedAnnouncements = {};

    for (var announcement in announcements) {
      final dateCreated = announcement.dateCreated!;
      final month = DateFormat.yMMMM().format(dateCreated); // e.g., "August 2024"
      final day = DateFormat.EEEE().format(dateCreated); // e.g., "Tuesday"

      if (!groupedAnnouncements.containsKey(month)) {
        groupedAnnouncements[month] = {};
      }

      if (!groupedAnnouncements[month]!.containsKey(day)) {
        groupedAnnouncements[month]![day] = [];
      }

      groupedAnnouncements[month]![day]!.add(announcement);
    }

    return groupedAnnouncements;
  }
}
