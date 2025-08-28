import 'package:get/get.dart';
import 'package:jal_setu/models/user_profile.dart';
import 'package:jal_setu/services/api_service.dart';

class ProfileController extends GetxController {
  ProfileController(this._api);
  final ApiService _api;

  final RxBool loading = false.obs;
  final Rx<UserProfile?> profile = Rx<UserProfile?>(null);

  @override
  void onInit() {
    super.onInit();
    load();
  }

  Future<void> load() async {
    loading.value = true;
    profile.value = await _api.fetchProfile();
    loading.value = false;
  }
}

