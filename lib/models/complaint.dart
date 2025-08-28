import 'package:intl/intl.dart';

enum ComplaintPriority { low, medium, high }
enum ComplaintStatus { received, assigned, inProgress, resolved, closed }

class Complaint {
  final String id;
  final String title;
  final String description;
  final String ward;
  final ComplaintPriority priority;
  final ComplaintStatus status;
  final DateTime createdAt;
  final DateTime? resolvedAt;

  Complaint({
    required this.id,
    required this.title,
    required this.description,
    required this.ward,
    required this.priority,
    required this.status,
    required this.createdAt,
    this.resolvedAt,
  });

  String get createdAtLabel => DateFormat('yyyy-MM-dd').format(createdAt);
}

