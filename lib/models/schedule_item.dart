enum SupplyStatus { onTime, delayed, cancelled, lowPressure }

class ScheduleItem {
  final String id;
  final String ward;
  final String label; // Morning/Evening
  final DateTime start;
  final DateTime end;
  final SupplyStatus status;

  ScheduleItem({
    required this.id,
    required this.ward,
    required this.label,
    required this.start,
    required this.end,
    required this.status,
  });
}

