import 'package:get/get.dart';
import 'package:jal_setu/models/complaint.dart';
import 'package:jal_setu/services/api_service.dart';

class ComplaintsController extends GetxController {
  ComplaintsController(this._api);
  final ApiService _api;

  final RxList<Complaint> complaints = <Complaint>[].obs;
  final RxBool loading = false.obs;
  final Rx<Complaint?> lastSubmitted = Rx<Complaint?>(null);

  @override
  void onInit() {
    super.onInit();
    load();
  }

  Future<void> load() async {
    loading.value = true;
    complaints.assignAll(await _api.fetchComplaints());
    loading.value = false;
  }

  Future<void> submit(ComplaintInput input) async {
    loading.value = true;
    final created = await _api.submitComplaint(input);
    lastSubmitted.value = created;
    complaints.insert(0, created);
    loading.value = false;
  }
}

