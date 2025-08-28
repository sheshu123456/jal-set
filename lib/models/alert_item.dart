enum AlertLevel { info, warning, critical }

class AlertItem {
  final String id;
  final String title;
  final String description;
  final AlertLevel level;
  final DateTime timestamp;

  AlertItem({
    required this.id,
    required this.title,
    required this.description,
    required this.level,
    required this.timestamp,
  });
}

