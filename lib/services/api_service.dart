import 'package:jal_setu/models/alert_item.dart';
import 'package:jal_setu/models/complaint.dart';
import 'package:jal_setu/models/schedule_item.dart';
import 'package:jal_setu/models/user_profile.dart';
import 'package:jal_setu/models/water_source.dart';

abstract class ApiService {
  Future<UserProfile> fetchProfile();
  Future<List<AlertItem>> fetchAlerts();
  Future<List<WaterSource>> fetchWaterSources();
  Future<List<ScheduleItem>> fetchSchedule({required String ward});
  Future<List<Complaint>> fetchComplaints();
  Future<Complaint> submitComplaint(ComplaintInput input);
}

