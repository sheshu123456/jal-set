class ScheduleItem {
  final String label; // Morning/Evening
  final String timeRange; // 6:00 AM - 8:00 AM
  final String status; // On Time / Delayed / Cancelled

  const ScheduleItem({required this.label, required this.timeRange, required this.status});
}

