import 'dart:async';

import 'package:intl/intl.dart';
import 'package:jal_setu/models/alert_item.dart';
import 'package:jal_setu/models/complaint.dart';
import 'package:jal_setu/models/schedule_item.dart';
import 'package:jal_setu/models/user_profile.dart';
import 'package:jal_setu/models/water_source.dart';
import 'package:jal_setu/services/api_service.dart';

class MockApiService implements ApiService {
  final DateFormat _time = DateFormat('HH:mm');

  @override
  Future<UserProfile> fetchProfile() async {
    await Future.delayed(const Duration(milliseconds: 350));
    return UserProfile(
      id: 'u1',
      name: 'राज कुमार',
      phone: '7799822811',
      address: 'Barmer, Rajasthan',
      ward: 'Ward 12',
      email: 'raj@example.com',
    );
  }

  @override
  Future<List<AlertItem>> fetchAlerts() async {
    await Future.delayed(const Duration(milliseconds: 300));
    return [
      AlertItem(
        id: 'a1',
        title: 'रखरखाव कार्य',
        description: 'वार्ड 12 में आज शाम 4-6 बजे',
        level: AlertLevel.warning,
        timestamp: DateTime.now().subtract(const Duration(hours: 2)),
      ),
    ];
  }

  @override
  Future<List<WaterSource>> fetchWaterSources() async {
    await Future.delayed(const Duration(milliseconds: 450));
    return [
      WaterSource(
        id: 'ws1',
        name: 'सामुदायिक टैंक 1',
        ward: 'Ward 12, Barmer',
        distanceKm: 0.5,
        type: WaterSourceType.tank,
        isActive: true,
        lastInspection: DateTime.now().subtract(const Duration(days: 3)),
      ),
      WaterSource(
        id: 'ws2',
        name: 'हैंडपंप स्टेशन A',
        ward: 'Ward 12, Barmer',
        distanceKm: 0.8,
        type: WaterSourceType.handpump,
        isActive: true,
        lastInspection: DateTime.now().subtract(const Duration(days: 0)),
      ),
      WaterSource(
        id: 'ws3',
        name: 'बोरवेल 3',
        ward: 'Ward 13, Barmer',
        distanceKm: 1.2,
        type: WaterSourceType.borewell,
        isActive: false,
        lastInspection: DateTime.now().subtract(const Duration(days: 10)),
      ),
    ];
  }

  @override
  Future<List<ScheduleItem>> fetchSchedule({required String ward}) async {
    await Future.delayed(const Duration(milliseconds: 420));
    final now = DateTime.now();
    DateTime todayAt(int hour, int minute) => DateTime(now.year, now.month, now.day, hour, minute);
    return [
      ScheduleItem(
        id: 's1',
        ward: ward,
        label: 'सुबह',
        start: todayAt(6, 0),
        end: todayAt(8, 0),
        status: SupplyStatus.onTime,
      ),
      ScheduleItem(
        id: 's2',
        ward: ward,
        label: 'शाम',
        start: todayAt(18, 0),
        end: todayAt(19, 0),
        status: SupplyStatus.onTime,
      ),
    ];
  }

  @override
  Future<List<Complaint>> fetchComplaints() async {
    await Future.delayed(const Duration(milliseconds: 400));
    return [
      Complaint(
        id: 'JST001',
        title: 'पानी नहीं आया - 3 दिन से',
        description: 'हमारे इलाके में 3 दिन से पानी नहीं आ रहा है।',
        ward: 'Ward 12, Barmer',
        priority: ComplaintPriority.high,
        status: ComplaintStatus.inProgress,
        createdAt: DateTime.now().subtract(const Duration(days: 1)),
      ),
      Complaint(
        id: 'JST002',
        title: 'पाइप लाइन में रिसाव',
        description: 'मुख्य सड़क पर पाइप लाइन में रिसाव हो रहा है।',
        ward: 'Ward 12, Barmer',
        priority: ComplaintPriority.medium,
        status: ComplaintStatus.resolved,
        createdAt: DateTime.now().subtract(const Duration(days: 3)),
        resolvedAt: DateTime.now().subtract(const Duration(days: 1)),
      ),
    ];
  }

  @override
  Future<Complaint> submitComplaint(ComplaintInput input) async {
    await Future.delayed(const Duration(milliseconds: 600));
    return Complaint(
      id: 'JST${DateTime.now().millisecondsSinceEpoch % 10000}'.padLeft(4, '0'),
      title: input.title,
      description: input.description,
      ward: input.ward,
      priority: input.priority,
      status: ComplaintStatus.received,
      createdAt: DateTime.now(),
    );
  }
}

