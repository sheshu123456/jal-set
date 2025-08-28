import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jal_setu/controllers/profile_controller.dart';
import 'package:jal_setu/controllers/theme_controller.dart';
import 'package:jal_setu/services/api_service.dart';
import 'package:jal_setu/utils/app_theme.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({super.key, required this.api});
  final ApiService api;

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ProfileController(api));
    final theme = Get.find<ThemeController>();
    return Scaffold(
      appBar: AppBar(title: const Text('मेरी प्रोफाइल')),
      body: Obx(() {
        if (controller.loading.value) return const Center(child: CircularProgressIndicator());
        final p = controller.profile.value;
        if (p == null) return const SizedBox.shrink();
        return ListView(
          padding: const EdgeInsets.all(Spacing.lg),
          children: [
            CircleAvatar(radius: 36, child: Text(p.name.characters.first)),
            const SizedBox(height: Spacing.md),
            Center(child: Text(p.name, style: Theme.of(context).textTheme.titleLarge)),
            const SizedBox(height: Spacing.lg),
            _InfoTile(icon: Icons.call, label: 'मोबाइल', value: p.phone + ' (Verified)'),
            _InfoTile(icon: Icons.email_outlined, label: 'ईमेल', value: p.email ?? '-'),
            _InfoTile(icon: Icons.place_outlined, label: 'पता', value: p.address),
            _InfoTile(icon: Icons.map_outlined, label: 'वार्ड', value: p.ward),
            const SizedBox(height: Spacing.lg),
            SwitchListTile(
              value: theme.themeMode.value == ThemeMode.dark,
              onChanged: (_) => theme.toggleThemeMode(),
              title: const Text('डार्क मोड'),
            ),
            const SizedBox(height: Spacing.lg),
            ListTile(
              leading: const Icon(Icons.support_agent),
              title: const Text('24x7 हेल्पलाइन: 1800-XXX-XXXX'),
              onTap: () {},
            ),
            const SizedBox(height: Spacing.lg),
            ElevatedButton.icon(onPressed: () {}, icon: const Icon(Icons.logout), label: const Text('लॉग आउट')),
          ],
        );
      }),
    );
  }
}

class _InfoTile extends StatelessWidget {
  const _InfoTile({required this.icon, required this.label, required this.value});
  final IconData icon;
  final String label;
  final String value;
  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: Icon(icon),
        title: Text(label),
        subtitle: Text(value),
      ),
    );
  }
}

