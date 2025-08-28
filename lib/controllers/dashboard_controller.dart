import 'package:get/get.dart';
import '../models/schedule.dart';
import '../models/water_source.dart';
import '../models/alert.dart';
import '../services/mock_service.dart';

class DashboardController extends GetxController {
  final MockService _service = MockService();

  final RxList<ScheduleItem> todaySchedule = <ScheduleItem>[].obs;
  final RxList<WaterSource> nearbySources = <WaterSource>[].obs;
  final RxList<ServiceAlert> alerts = <ServiceAlert>[].obs;
  final RxBool loading = false.obs;

  @override
  void onInit() {
    super.onInit();
    load();
  }

  Future<void> load() async {
    loading.value = true;
    final results = await Future.wait([
      _service.fetchTodaySchedule(),
      _service.fetchNearbySources(),
      _service.fetchAlerts(),
    ]);
    todaySchedule.assignAll(results[0] as List<ScheduleItem>);
    nearbySources.assignAll(results[1] as List<WaterSource>);
    alerts.assignAll(results[2] as List<ServiceAlert>);
    loading.value = false;
  }
}

