import 'package:get/get.dart';
import '../models/user.dart';
import '../services/mock_service.dart';

class ProfileController extends GetxController {
  final MockService _service = MockService();
  final Rxn<AppUser> user = Rxn<AppUser>();
  final RxBool loading = false.obs;

  @override
  void onInit() {
    super.onInit();
    load();
  }

  Future<void> load() async {
    loading.value = true;
    user.value = await _service.fetchProfile();
    loading.value = false;
  }
}

