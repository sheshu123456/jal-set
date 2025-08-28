import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/navigation_controller.dart';
import 'sections/dashboard_view.dart';
import 'sections/form_view.dart';
import 'sections/history_view.dart';
import 'sections/profile_view.dart';

class RootView extends GetView<NavigationController> {
  const RootView({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(NavigationController());

    final pages = const [
      DashboardView(),
      FormView(),
      HistoryView(),
      ProfileView(),
    ];

    return Obx(() => Scaffold(
          body: IndexedStack(index: controller.currentIndex.value, children: pages),
          bottomNavigationBar: NavigationBar(
            selectedIndex: controller.currentIndex.value,
            onDestinationSelected: controller.setIndex,
            destinations: const [
              NavigationDestination(icon: Icon(Icons.home_outlined), selectedIcon: Icon(Icons.home), label: 'होम'),
              NavigationDestination(icon: Icon(Icons.edit_note_outlined), selectedIcon: Icon(Icons.edit_note), label: 'फॉर्म'),
              NavigationDestination(icon: Icon(Icons.history_outlined), selectedIcon: Icon(Icons.history), label: 'इतिहास'),
              NavigationDestination(icon: Icon(Icons.person_outline), selectedIcon: Icon(Icons.person), label: 'प्रोफाइल'),
            ],
          ),
        ));
  }
}

