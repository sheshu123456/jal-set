import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../models/complaint.dart';
import '../services/mock_service.dart';
import '../utils/validators.dart';

class FormController extends GetxController {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController titleCtrl = TextEditingController();
  final TextEditingController descCtrl = TextEditingController();
  final TextEditingController wardCtrl = TextEditingController(text: 'Ward 12');
  final Rx<ComplaintPriority> priority = ComplaintPriority.medium.obs;
  final RxBool submitting = false.obs;
  final MockService _service = MockService();

  String? validateTitle(String? v) => Validators.requiredField(v, message: 'शीर्षक आवश्यक है');
  String? validateDesc(String? v) => Validators.requiredField(v, message: 'विवरण आवश्यक है');

  Future<Complaint?> submit() async {
    if (!(formKey.currentState?.validate() ?? false)) return null;
    submitting.value = true;
    final complaint = await _service.submitComplaint(
      titleCtrl.text.trim(),
      descCtrl.text.trim(),
      wardCtrl.text.trim(),
      priority.value,
    );
    submitting.value = false;
    return complaint;
  }

  @override
  void onClose() {
    titleCtrl.dispose();
    descCtrl.dispose();
    wardCtrl.dispose();
    super.onClose();
  }
}

