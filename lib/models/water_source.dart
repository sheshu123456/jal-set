enum SourceType { tank, handpump, borewell, standpost }

class WaterSource {
  final String id;
  final String name;
  final String ward;
  final double distanceKm;
  final SourceType type;
  final bool active;
  final DateTime lastInspected;

  const WaterSource({
    required this.id,
    required this.name,
    required this.ward,
    required this.distanceKm,
    required this.type,
    required this.active,
    required this.lastInspected,
  });
}

