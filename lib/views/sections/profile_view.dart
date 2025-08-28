import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controllers/profile_controller.dart';
import '../../widgets/app_card.dart';

class ProfileView extends GetView<ProfileController> {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(ProfileController());
    return Scaffold(
      appBar: AppBar(title: const Text('मेरी प्रोफाइल')),
      body: Obx(() {
        if (controller.loading.value) return const Center(child: CircularProgressIndicator());
        final user = controller.user.value;
        if (user == null) return const SizedBox();
        return ListView(
          padding: const EdgeInsets.all(16),
          children: [
            Center(
              child: CircleAvatar(
                radius: 40,
                child: Text(user.name.characters.first, style: const TextStyle(fontSize: 32)),
              ),
            ),
            const SizedBox(height: 12),
            Center(child: Text(user.name, style: Theme.of(context).textTheme.titleLarge)),
            Center(child: Text(user.ward)),
            const SizedBox(height: 16),
            AppCard(
              child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Text('व्यक्तिगत जानकारी', style: Theme.of(context).textTheme.titleMedium),
                const SizedBox(height: 10),
                _info('मोबाइल', '${user.mobile} (Verified)'),
                _info('ईमेल', user.email),
                _info('पता', user.address),
                _info('वार्ड', user.ward),
              ]),
            ),
            const SizedBox(height: 12),
            AppCard(
              child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Text('सहायता और समर्थन', style: Theme.of(context).textTheme.titleMedium),
                ListTile(leading: const Icon(Icons.help_outline), title: const Text('अक्सर पूछे जाने वाले प्रश्न'), onTap: () {}),
                ListTile(leading: const Icon(Icons.call), title: const Text('24x7 हेल्पलाइन: 1800-XXX-XXXX'), onTap: () {}),
              ]),
            ),
            const SizedBox(height: 20),
            FilledButton.icon(onPressed: () {}, icon: const Icon(Icons.logout), label: const Text('लॉग आउट')),
          ],
        );
      }),
    );
  }

  Widget _info(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        children: [
          SizedBox(width: 100, child: Text(label, style: const TextStyle(fontWeight: FontWeight.w600))),
          Expanded(child: Text(value)),
        ],
      ),
    );
  }
}

