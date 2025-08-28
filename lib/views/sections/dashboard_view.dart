import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controllers/dashboard_controller.dart';
import '../../widgets/app_card.dart';
import '../../widgets/section_header.dart';
import '../../widgets/status_chip.dart';

class DashboardView extends GetView<DashboardController> {
  const DashboardView({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(DashboardController());
    return Scaffold(
      appBar: AppBar(title: const Text('जल सेतु')), 
      body: Obx(() {
        if (controller.loading.value) {
          return const Center(child: CircularProgressIndicator());
        }
        return RefreshIndicator(
          onRefresh: controller.load,
          child: ListView(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            children: [
              const SectionHeader(title: 'आज की जल आपूर्ति'),
              ...controller.todaySchedule.map((s) => AppCard(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                          Text(s.label, style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w600)),
                          const SizedBox(height: 6),
                          Text(s.timeRange),
                        ]),
                        StatusChip(label: s.status, color: Colors.green),
                      ],
                    ),
                  )),
              const SizedBox(height: 4),
              const SectionHeader(title: 'सक्रिय अलर्ट', trailing: 'सभी देखें'),
              ...controller.alerts.map((a) => AppCard(
                    child: ListTile(
                      leading: const Icon(Icons.warning_amber_rounded, color: Colors.orange),
                      title: Text(a.title),
                      subtitle: Text(a.description),
                    ),
                  )),
              const SectionHeader(title: 'नजदीकी जल स्रोत', trailing: 'सभी देखें'),
              ...controller.nearbySources.map((w) => AppCard(
                    child: ListTile(
                      leading: const Icon(Icons.water_drop),
                      title: Text(w.name),
                      subtitle: Text('${w.distanceKm.toStringAsFixed(1)} km • ${w.ward}'),
                      trailing: StatusChip(label: w.active ? 'सक्रिय' : 'रखरखाव', color: w.active ? Colors.green : Colors.orange),
                    ),
                  )),
            ],
          ),
        );
      }),
    );
  }
}

