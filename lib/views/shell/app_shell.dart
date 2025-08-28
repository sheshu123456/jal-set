import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jal_setu/services/api_service.dart';
import 'package:jal_setu/services/mock_api_service.dart';
import 'package:jal_setu/views/tabs/dashboard_view.dart';
import 'package:jal_setu/views/tabs/sources_view.dart';
import 'package:jal_setu/views/tabs/schedule_view.dart';
import 'package:jal_setu/views/tabs/complaints_view.dart';
import 'package:jal_setu/views/tabs/profile_view.dart';

class AppShell extends StatefulWidget {
  const AppShell({super.key});

  @override
  State<AppShell> createState() => _AppShellState();
}

class _AppShellState extends State<AppShell> {
  final RxInt _index = 0.obs;
  late final ApiService _api;

  @override
  void initState() {
    super.initState();
    _api = Get.put<ApiService>(MockApiService(), permanent: true);
  }

  @override
  Widget build(BuildContext context) {
    final pages = [
      DashboardView(api: _api),
      SourcesView(api: _api),
      ScheduleView(api: _api),
      ComplaintsView(api: _api),
      ProfileView(api: _api),
    ];
    return Obx(() => Scaffold(
          body: AnimatedSwitcher(
            duration: const Duration(milliseconds: 250),
            child: pages[_index.value],
          ),
          bottomNavigationBar: NavigationBar(
            selectedIndex: _index.value,
            onDestinationSelected: (i) => _index.value = i,
            destinations: const [
              NavigationDestination(icon: Icon(Icons.home_outlined), selectedIcon: Icon(Icons.home), label: 'होम'),
              NavigationDestination(icon: Icon(Icons.water_drop_outlined), selectedIcon: Icon(Icons.water_drop), label: 'जल स्रोत'),
              NavigationDestination(icon: Icon(Icons.event_outlined), selectedIcon: Icon(Icons.event), label: 'समय सारणी'),
              NavigationDestination(icon: Icon(Icons.receipt_long_outlined), selectedIcon: Icon(Icons.receipt_long), label: 'शिकायतें'),
              NavigationDestination(icon: Icon(Icons.person_outline), selectedIcon: Icon(Icons.person), label: 'प्रोफाइल'),
            ],
          ),
        ));
  }
}

