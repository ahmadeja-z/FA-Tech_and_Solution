
class ProjectModel {
  final String projectId;
  final String title;
  final String description;
  final String assignedTo;
  final String status; // e.g., assigned, in-progress, completed
  final String type; // New field for project type
  final String createdAt;
  final String updatedAt;

  ProjectModel({
    required this.projectId,
    required this.title,
    required this.description,
    required this.assignedTo,
    required this.status,
    required this.type,
    required this.createdAt,
    required this.updatedAt,
  });

  // Convert a ProjectModel instance to a map
  Map<String, dynamic> toMap() {
    return {
      'projectId':projectId,
      'title': title,
      'description': description,
      'assignedTo': assignedTo,
      'status': status,
      'type': type,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
    };
  }

  // Create a ProjectModel instance from a map
  ProjectModel.fromMap(Map<String, dynamic> map)
      :
        projectId=map['projectId']??'',
        title = map['title'] ?? '',
        description = map['description'] ?? '',
        assignedTo = map['assignedTo'] ?? '',
        status = map['status'] ?? '',
        type = map['type'] ?? '', // Handle null values with default empty string
        createdAt = map['createdAt'] ?? '',
        updatedAt = map['updatedAt'] ?? '';
}
