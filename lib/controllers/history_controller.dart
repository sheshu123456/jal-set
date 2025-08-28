import 'package:get/get.dart';
import '../models/complaint.dart';
import '../services/mock_service.dart';

class HistoryController extends GetxController {
  final MockService _service = MockService();
  final RxList<Complaint> complaints = <Complaint>[].obs;
  final RxBool loading = false.obs;

  @override
  void onInit() {
    super.onInit();
    load();
  }

  Future<void> load() async {
    loading.value = true;
    complaints.assignAll(await _service.fetchComplaints());
    loading.value = false;
  }
}

