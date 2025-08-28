import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:jal_setu/controllers/schedule_controller.dart';
import 'package:jal_setu/services/api_service.dart';
import 'package:jal_setu/utils/app_theme.dart';

class ScheduleView extends StatelessWidget {
  const ScheduleView({super.key, required this.api});
  final ApiService api;

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ScheduleController(api));
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('जल आपूर्ति समय सारणी'),
          bottom: const TabBar(tabs: [
            Tab(text: 'आज'),
            Tab(text: 'कल'),
            Tab(text: 'इस सप्ताह'),
          ]),
        ),
        body: Obx(() {
          if (controller.loading.value) return const Center(child: CircularProgressIndicator());
          return TabBarView(children: [
            _ScheduleList(items: controller.today),
            _ScheduleList(items: controller.tomorrow),
            _ScheduleList(items: controller.week),
          ]);
        }),
      ),
    );
  }
}

class _ScheduleList extends StatelessWidget {
  const _ScheduleList({required this.items});
  final List items;
  @override
  Widget build(BuildContext context) {
    final time = DateFormat('h:mm a');
    return ListView.builder(
      itemCount: items.length,
      padding: const EdgeInsets.only(top: Spacing.md),
      itemBuilder: (context, i) {
        final e = items[i];
        return Card(
          margin: const EdgeInsets.symmetric(horizontal: Spacing.lg, vertical: Spacing.sm),
          child: ListTile(
            leading: const Icon(Icons.schedule),
            title: Text('${e.label}  •  ${time.format(e.start)} - ${time.format(e.end)}'),
            subtitle: const Text('Ward 12, Barmer'),
            trailing: const _StatusPill(text: 'समय पर'),
          ),
        );
      },
    );
  }
}

class _StatusPill extends StatelessWidget {
  const _StatusPill({required this.text});
  final String text;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
          color: Colors.green.withOpacity(0.15), borderRadius: BorderRadius.circular(18)),
      child: Text(text, style: const TextStyle(color: Colors.green, fontWeight: FontWeight.w600)),
    );
  }
}

