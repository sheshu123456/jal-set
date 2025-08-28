import 'package:get/get.dart';
import 'package:jal_setu/models/water_source.dart';
import 'package:jal_setu/services/api_service.dart';

class SourcesController extends GetxController {
  SourcesController(this._api);
  final ApiService _api;

  final RxList<WaterSource> allSources = <WaterSource>[].obs;
  final RxList<WaterSource> filtered = <WaterSource>[].obs;
  final Rx<WaterSourceType?> selectedType = Rx<WaterSourceType?>(null);
  final RxString query = ''.obs;
  final RxBool loading = false.obs;

  @override
  void onInit() {
    super.onInit();
    load();
    everAll([query, selectedType], (_) => applyFilters());
  }

  Future<void> load() async {
    loading.value = true;
    final data = await _api.fetchWaterSources();
    allSources.assignAll(data);
    applyFilters();
    loading.value = false;
  }

  void applyFilters() {
    Iterable<WaterSource> list = allSources;
    if (selectedType.value != null) {
      list = list.where((e) => e.type == selectedType.value);
    }
    if (query.value.isNotEmpty) {
      final q = query.value.toLowerCase();
      list = list.where(
        (e) => e.name.toLowerCase().contains(q) || e.ward.toLowerCase().contains(q),
      );
    }
    filtered.assignAll(list.toList());
  }
}

