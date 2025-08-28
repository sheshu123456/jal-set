import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controllers/form_controller.dart';
import '../../widgets/primary_button.dart';
import '../../widgets/rounded_text_field.dart';

class FormView extends GetView<FormController> {
  const FormView({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(FormController());
    return Scaffold(
      appBar: AppBar(title: const Text('नई शिकायत')),
      body: Form(
        key: controller.formKey,
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            RoundedTextField(
              controller: controller.titleCtrl,
              labelText: 'शीर्षक',
              prefixIcon: Icons.title,
              validator: controller.validateTitle,
            ),
            const SizedBox(height: 12),
            RoundedTextField(
              controller: controller.descCtrl,
              labelText: 'विवरण',
              prefixIcon: Icons.description_outlined,
              maxLines: 4,
              validator: controller.validateDesc,
            ),
            const SizedBox(height: 12),
            RoundedTextField(
              controller: controller.wardCtrl,
              labelText: 'वार्ड',
              prefixIcon: Icons.location_on_outlined,
              validator: (v) => v == null || v.isEmpty ? 'वार्ड आवश्यक है' : null,
            ),
            const SizedBox(height: 12),
            Text('प्राथमिकता', style: Theme.of(context).textTheme.titleMedium),
            const SizedBox(height: 8),
            Obx(() => SegmentedButton(
                  segments: const [
                    ButtonSegment(value: 'low', label: Text('Low')),
                    ButtonSegment(value: 'medium', label: Text('Medium')),
                    ButtonSegment(value: 'high', label: Text('High')),
                  ],
                  selected: {
                    switch (controller.priority.value) {
                      ComplaintPriority.low => 'low',
                      ComplaintPriority.medium => 'medium',
                      ComplaintPriority.high => 'high'
                    }
                  },
                  onSelectionChanged: (s) {
                    final v = s.first;
                    if (v == 'low') controller.priority.value = ComplaintPriority.low;
                    if (v == 'medium') controller.priority.value = ComplaintPriority.medium;
                    if (v == 'high') controller.priority.value = ComplaintPriority.high;
                  },
                )),
            const SizedBox(height: 20),
            Obx(() => PrimaryButton(
                  onPressed: controller.submitting.value
                      ? null
                      : () async {
                          final c = await controller.submit();
                          if (c != null) {
                            if (context.mounted) {
                              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('शिकायत दर्ज हो गई')));
                              controller.titleCtrl.clear();
                              controller.descCtrl.clear();
                              FocusScope.of(context).unfocus();
                            }
                          }
                        },
                  label: controller.submitting.value ? 'भेजा जा रहा है...' : 'सबमिट करें',
                  icon: Icons.send,
                )),
          ],
        ),
      ),
    );
  }
}

