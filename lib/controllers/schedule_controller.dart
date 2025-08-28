import 'package:get/get.dart';
import 'package:jal_setu/models/schedule_item.dart';
import 'package:jal_setu/services/api_service.dart';

class ScheduleController extends GetxController {
  ScheduleController(this._api);
  final ApiService _api;

  final RxList<ScheduleItem> today = <ScheduleItem>[].obs;
  final RxList<ScheduleItem> tomorrow = <ScheduleItem>[].obs;
  final RxList<ScheduleItem> week = <ScheduleItem>[].obs;
  final RxBool loading = false.obs;

  @override
  void onInit() {
    super.onInit();
    load();
  }

  Future<void> load() async {
    loading.value = true;
    final data = await _api.fetchSchedule(ward: 'Ward 12');
    today.assignAll(data);
    // Simple mocks for tomorrow and week
    tomorrow.assignAll(data.map((e) => ScheduleItem(
          id: '${e.id}t',
          ward: e.ward,
          label: e.label,
          start: e.start.add(const Duration(days: 1)),
          end: e.end.add(const Duration(days: 1)),
          status: e.status,
        )));
    week.assignAll(List.generate(5, (i) => i).expand((d) => data.map((e) => ScheduleItem(
          id: '${e.id}w$d',
          ward: e.ward,
          label: e.label,
          start: e.start.add(Duration(days: d)),
          end: e.end.add(Duration(days: d)),
          status: e.status,
        ))));
    loading.value = false;
  }
}

