import 'dart:async';
import '../models/complaint.dart';
import '../models/water_source.dart';
import '../models/schedule.dart';
import '../models/alert.dart';
import '../models/user.dart';

class MockService {
  Future<List<WaterSource>> fetchNearbySources() async {
    await Future.delayed(const Duration(milliseconds: 400));
    return const [
      WaterSource(id: '1', name: 'सामुदायिक टैंक 1', ward: 'Ward 12', distanceKm: 0.5, type: SourceType.tank, active: true, lastInspected: DateTime(2024, 8, 15)),
      WaterSource(id: '2', name: 'हैंडपंप स्टेशन A', ward: 'Ward 12', distanceKm: 0.8, type: SourceType.handpump, active: true, lastInspected: DateTime(2024, 8, 18)),
      WaterSource(id: '3', name: 'बोरवेल 3', ward: 'Ward 13', distanceKm: 1.2, type: SourceType.borewell, active: false, lastInspected: DateTime(2024, 8, 10)),
    ];
  }

  Future<List<ScheduleItem>> fetchTodaySchedule() async {
    await Future.delayed(const Duration(milliseconds: 350));
    return const [
      ScheduleItem(label: 'सुबह', timeRange: '6:00 AM - 8:00 AM', status: 'समय पर'),
      ScheduleItem(label: 'शाम', timeRange: '6:00 PM - 7:00 PM', status: 'समय पर'),
    ];
  }

  Future<List<ServiceAlert>> fetchAlerts() async {
    await Future.delayed(const Duration(milliseconds: 300));
    return [
      ServiceAlert(id: 'al1', title: 'रखरखाव कार्य', description: 'वार्ड 12 में आज शाम 4-6 बजे', ward: 'Ward 12', createdAt: DateTime.now()),
    ];
  }

  Future<List<Complaint>> fetchComplaints() async {
    await Future.delayed(const Duration(milliseconds: 450));
    return [
      Complaint(id: 'JST001', title: 'पानी नहीं आया - 3 दिन से', description: 'हमारे इलाके में पानी नहीं आ रहा है।', ward: 'Ward 12', priority: ComplaintPriority.high, status: ComplaintStatus.inProgress, createdAt: DateTime(2024, 8, 18)),
      Complaint(id: 'JST002', title: 'पाइप लाइन में रिसाव', description: 'मुख्य सड़क पर रिसाव हो रहा है।', ward: 'Ward 12', priority: ComplaintPriority.medium, status: ComplaintStatus.resolved, createdAt: DateTime(2024, 8, 15), resolvedAt: DateTime(2024, 8, 17)),
      Complaint(id: 'JST003', title: 'पानी का दबाव कम', description: 'टंकी भरने में समय लगता है।', ward: 'Ward 12', priority: ComplaintPriority.medium, status: ComplaintStatus.assigned, createdAt: DateTime(2024, 8, 16)),
    ];
  }

  Future<AppUser> fetchProfile() async {
    await Future.delayed(const Duration(milliseconds: 300));
    return const AppUser(id: 'u1', name: 'राज कुमार', mobile: '7799822811', email: 'raj@example.com', address: 'Barmer, Rajasthan', ward: 'Ward 12');
  }

  Future<Complaint> submitComplaint(String title, String description, String ward, ComplaintPriority priority) async {
    await Future.delayed(const Duration(milliseconds: 600));
    return Complaint(id: 'JST${DateTime.now().millisecondsSinceEpoch.toString().substring(8)}', title: title, description: description, ward: ward, priority: priority, status: ComplaintStatus.received, createdAt: DateTime.now());
  }
}

