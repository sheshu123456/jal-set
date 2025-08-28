import 'package:get/get.dart';
import 'package:jal_setu/models/alert_item.dart';
import 'package:jal_setu/models/schedule_item.dart';
import 'package:jal_setu/services/api_service.dart';

class DashboardController extends GetxController {
  DashboardController(this._api);

  final ApiService _api;

  final RxBool loading = false.obs;
  final RxList<AlertItem> alerts = <AlertItem>[].obs;
  final RxList<ScheduleItem> todaysSchedule = <ScheduleItem>[].obs;

  @override
  void onInit() {
    super.onInit();
    load();
  }

  Future<void> load() async {
    loading.value = true;
    try {
      final results = await Future.wait([
        _api.fetchAlerts(),
        _api.fetchSchedule(ward: 'Ward 12'),
      ]);
      alerts.assignAll(results[0] as List<AlertItem>);
      todaysSchedule.assignAll(results[1] as List<ScheduleItem>);
    } finally {
      loading.value = false;
    }
  }
}

