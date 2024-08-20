import 'package:fasolution/App/Resources/Components/deleteButton.dart';
import 'package:flutter/material.dart';

class ProjectInfoWidget extends StatelessWidget {
  final String title;
  final String description;
  final String assignedTo;
  final String status;
  final String createdAt;
  final String updatedAt;
  final VoidCallback? onDelete;

  const ProjectInfoWidget({
    Key? key,
    required this.title,
    required this.description,
    required this.assignedTo,
    required this.status,
    required this.createdAt,
    required this.updatedAt,  this.onDelete,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(12.0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      elevation: 5,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Project Title
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.blueAccent,
                  ),
                  
                ),if(onDelete!=null)
                DeleteButton(onPressed: onDelete!)
              ],
            ),
            SizedBox(height: 10),

            // Project Description
            Text(
              description,
              style: TextStyle(
                fontSize: 16,
                color: Colors.black87,
              ),
            ),
            SizedBox(height: 20),

            // Assigned To
            _buildInfoRow(Icons.person, 'Assigned to', assignedTo),

            // Status
            _buildInfoRow(Icons.info_outline, 'Status', status),

            // Created At
            _buildInfoRow(Icons.calendar_today, 'Created At', createdAt),

            // Updated At
            _buildInfoRow(Icons.update, 'Last Updated At', updatedAt),
          ],
        ),
      ),
    );
  }

  // Helper method to create info rows
  Widget _buildInfoRow(IconData icon, String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        children: [
          Icon(icon, size: 20, color: Colors.black54),
          SizedBox(width: 10),
          Text(
            '$label:',
            style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 16,
              color: Colors.black54,
            ),
          ),
          SizedBox(width: 5),
          Text(
            value,
            style: TextStyle(
              fontWeight: FontWeight.w400,
              fontSize: 16,
              color: Colors.black87,
            ),
          ),
        ],
      ),
    );
  }
}
