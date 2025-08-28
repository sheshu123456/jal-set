enum WaterSourceType { tank, handpump, borewell, standpost }

class WaterSource {
  final String id;
  final String name;
  final String ward;
  final double distanceKm;
  final WaterSourceType type;
  final bool isActive;
  final DateTime lastInspection;

  WaterSource({
    required this.id,
    required this.name,
    required this.ward,
    required this.distanceKm,
    required this.type,
    required this.isActive,
    required this.lastInspection,
  });
}

