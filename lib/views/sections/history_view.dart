import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controllers/history_controller.dart';
import '../../widgets/app_card.dart';
import '../../widgets/status_chip.dart';

class HistoryView extends GetView<HistoryController> {
  const HistoryView({super.key});

  Color _priorityColor(ComplaintPriority p) {
    switch (p) {
      case ComplaintPriority.high:
        return Colors.red;
      case ComplaintPriority.medium:
        return Colors.orange;
      case ComplaintPriority.low:
        return Colors.green;
    }
  }

  String _statusLabel(ComplaintStatus s) {
    switch (s) {
      case ComplaintStatus.received:
        return 'प्राप्त';
      case ComplaintStatus.assigned:
        return 'सौंपा गया';
      case ComplaintStatus.inProgress:
        return 'प्रगति में';
      case ComplaintStatus.resolved:
        return 'हल हो गया';
      case ComplaintStatus.closed:
        return 'बंद';
    }
  }

  @override
  Widget build(BuildContext context) {
    Get.put(HistoryController());
    return Scaffold(
      appBar: AppBar(title: const Text('मेरी शिकायतें')),
      body: Obx(() {
        if (controller.loading.value) return const Center(child: CircularProgressIndicator());
        return RefreshIndicator(
          onRefresh: controller.load,
          child: ListView.builder(
            padding: const EdgeInsets.all(12),
            itemCount: controller.complaints.length,
            itemBuilder: (context, i) {
              final c = controller.complaints[i];
              return AppCard(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('#${c.id}', style: Theme.of(context).textTheme.labelLarge),
                        StatusChip(label: _statusLabel(c.status), color: Colors.blue),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Text(c.title, style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w600)),
                    const SizedBox(height: 6),
                    Text(c.description),
                    const SizedBox(height: 10),
                    Row(
                      children: [
                        StatusChip(label: c.ward, color: Colors.grey),
                        const SizedBox(width: 8),
                        StatusChip(label: c.priority.name, color: _priorityColor(c.priority)),
                        const Spacer(),
                        Text(c.createdAtLabel),
                      ],
                    )
                  ],
                ),
              );
            },
          ),
        );
      }),
    );
  }
}

