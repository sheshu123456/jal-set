import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:jal_setu/controllers/dashboard_controller.dart';
import 'package:jal_setu/services/api_service.dart';
import 'package:jal_setu/utils/app_theme.dart';
import 'package:jal_setu/controllers/complaints_controller.dart';
import 'package:jal_setu/views/tabs/complaints_view.dart';

class DashboardView extends StatelessWidget {
  const DashboardView({super.key, required this.api});
  final ApiService api;

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(DashboardController(api));
    return Scaffold(
      appBar: AppBar(
        title: const Text('जल सेतु'),
        actions: [
          IconButton(
            icon: const Icon(Icons.translate),
            onPressed: () {},
          )
        ],
      ),
      body: Obx(() {
        if (controller.loading.value) {
          return const Center(child: CircularProgressIndicator());
        }
        return RefreshIndicator(
          onRefresh: controller.load,
          child: ListView(
            padding: const EdgeInsets.symmetric(vertical: Spacing.md),
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: Spacing.lg),
                child: Text('नमस्कार, राज', style: Theme.of(context).textTheme.headlineSmall),
              ),
              _TodaySupplyCard(items: controller.todaysSchedule),
              _AlertsCard(alerts: controller.alerts),
              _QuickActions(api: api),
            ],
          ),
        );
      }),
    );
  }
}

class _TodaySupplyCard extends StatelessWidget {
  const _TodaySupplyCard({required this.items});
  final List items;

  @override
  Widget build(BuildContext context) {
    final time = DateFormat('h:mm a');
    return Card(
      margin: const EdgeInsets.all(Spacing.lg),
      child: Padding(
        padding: const EdgeInsets.all(Spacing.lg),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Icon(Icons.schedule),
                const SizedBox(width: Spacing.md),
                Text('आज की जल आपूर्ति', style: Theme.of(context).textTheme.titleLarge),
              ],
            ),
            const SizedBox(height: Spacing.md),
            ...items.map<Widget>((e) => Padding(
                  padding: const EdgeInsets.symmetric(vertical: 6),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(e.label, style: Theme.of(context).textTheme.titleMedium),
                          Text('${time.format(e.start)} - ${time.format(e.end)}'),
                        ],
                      ),
                      const _StatusChip(label: 'समय पर', color: Colors.green),
                    ],
                  ),
                )),
          ],
        ),
      ),
    );
  }
}

class _AlertsCard extends StatelessWidget {
  const _AlertsCard({required this.alerts});
  final List alerts;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: Spacing.lg, vertical: Spacing.sm),
      child: Padding(
        padding: const EdgeInsets.all(Spacing.lg),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(children: [
                  const Icon(Icons.warning_amber_rounded, color: Colors.orange),
                  const SizedBox(width: Spacing.md),
                  Text('सक्रिय अलर्ट', style: Theme.of(context).textTheme.titleLarge),
                ]),
                TextButton(onPressed: () {}, child: const Text('सभी देखें')),
              ],
            ),
            const SizedBox(height: Spacing.md),
            ...alerts.map<Widget>((a) => Container(
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.errorContainer.withOpacity(0.15),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  padding: const EdgeInsets.all(Spacing.md),
                  margin: const EdgeInsets.only(bottom: Spacing.sm),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(a.title, style: Theme.of(context).textTheme.titleMedium),
                      const SizedBox(height: 4),
                      Text(a.description),
                    ],
                  ),
                )),
          ],
        ),
      ),
    );
  }
}

class _QuickActions extends StatelessWidget {
  const _QuickActions({required this.api});
  final ApiService api;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(Spacing.lg),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('त्वरित कार्य', style: Theme.of(context).textTheme.titleLarge),
          const SizedBox(height: Spacing.md),
          Row(
            children: [
              Expanded(
                child: _ActionButton(
                  color: Theme.of(context).colorScheme.error,
                  icon: Icons.note_add_outlined,
                  label: 'शिकायत दर्ज करें',
                  onTap: () {
                    final c = Get.put(ComplaintsController(api));
                    Get.to(() => NewComplaintPage(controller: c));
                  },
                ),
              ),
              const SizedBox(width: Spacing.md),
              Expanded(
                child: _ActionButton(
                  color: Theme.of(context).colorScheme.primary,
                  icon: Icons.receipt_long_outlined,
                  label: 'टिकट ट्रैक करें',
                  onTap: () {},
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}

class _ActionButton extends StatelessWidget {
  const _ActionButton({required this.color, required this.icon, required this.label, required this.onTap});
  final Color color;
  final IconData icon;
  final String label;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: color,
      borderRadius: BorderRadius.circular(14),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(14),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, color: Colors.white),
              const SizedBox(width: 8),
              Text(label, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w600)),
            ],
          ),
        ),
      ),
    );
  }
}

class _StatusChip extends StatelessWidget {
  const _StatusChip({required this.label, required this.color});
  final String label;
  final Color color;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: color.withOpacity(0.15),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(label, style: TextStyle(color: color, fontWeight: FontWeight.w600)),
    );
  }
}

