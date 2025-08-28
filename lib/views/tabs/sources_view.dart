import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jal_setu/controllers/sources_controller.dart';
import 'package:jal_setu/models/water_source.dart';
import 'package:jal_setu/services/api_service.dart';
import 'package:jal_setu/utils/app_theme.dart';

class SourcesView extends StatelessWidget {
  const SourcesView({super.key, required this.api});
  final ApiService api;

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(SourcesController(api));
    return Scaffold(
      appBar: AppBar(title: const Text('जल स्रोत')),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(Spacing.lg),
            child: TextField(
              decoration: const InputDecoration(
                hintText: 'Search water bodies...',
                prefixIcon: Icon(Icons.search),
              ),
              onChanged: (v) => controller.query.value = v,
            ),
          ),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: Spacing.lg),
            child: Obx(() => Row(
                  children: [
                    _TypeChip(label: 'सभी', selected: controller.selectedType.value == null, onTap: () => controller.selectedType.value = null),
                    _TypeChip(label: 'टैंक', selected: controller.selectedType.value == WaterSourceType.tank, onTap: () => controller.selectedType.value = WaterSourceType.tank),
                    _TypeChip(label: 'हैंडपंप', selected: controller.selectedType.value == WaterSourceType.handpump, onTap: () => controller.selectedType.value = WaterSourceType.handpump),
                    _TypeChip(label: 'बोरवेल', selected: controller.selectedType.value == WaterSourceType.borewell, onTap: () => controller.selectedType.value = WaterSourceType.borewell),
                    _TypeChip(label: 'स्टैंडपोस्ट', selected: controller.selectedType.value == WaterSourceType.standpost, onTap: () => controller.selectedType.value = WaterSourceType.standpost),
                  ],
                )),
          ),
          const SizedBox(height: Spacing.sm),
          Expanded(
            child: Obx(() {
              if (controller.loading.value) return const Center(child: CircularProgressIndicator());
              if (controller.filtered.isEmpty) return const Center(child: Text('No sources found'));
              return ListView.builder(
                itemCount: controller.filtered.length,
                itemBuilder: (context, index) {
                  final s = controller.filtered[index];
                  return _SourceCard(source: s);
                },
              );
            }),
          )
        ],
      ),
    );
  }
}

class _TypeChip extends StatelessWidget {
  const _TypeChip({required this.label, required this.selected, required this.onTap});
  final String label;
  final bool selected;
  final VoidCallback onTap;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: Spacing.sm),
      child: ChoiceChip(
        label: Text(label),
        selected: selected,
        onSelected: (_) => onTap(),
      ),
    );
  }
}

class _SourceCard extends StatelessWidget {
  const _SourceCard({required this.source});
  final WaterSource source;

  IconData get _icon {
    switch (source.type) {
      case WaterSourceType.tank:
        return Icons.water_damage_outlined;
      case WaterSourceType.handpump:
        return Icons.wash_outlined;
      case WaterSourceType.borewell:
        return Icons.waves;
      case WaterSourceType.standpost:
        return Icons.water_drop;
    }
  }

  @override
  Widget build(BuildContext context) {
    final color = source.isActive ? Colors.green : Colors.orange;
    final statusText = source.isActive ? 'सक्रिय' : 'रखरखाव';
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(Spacing.lg),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(children: [
                  Icon(_icon, color: Theme.of(context).colorScheme.primary),
                  const SizedBox(width: Spacing.md),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(source.name, style: Theme.of(context).textTheme.titleMedium),
                      Text(source.ward),
                    ],
                  ),
                ]),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                  decoration: BoxDecoration(color: color.withOpacity(0.15), borderRadius: BorderRadius.circular(20)),
                  child: Text(statusText, style: TextStyle(color: color, fontWeight: FontWeight.w600)),
                ),
              ],
            ),
            const SizedBox(height: Spacing.md),
            Row(
              children: [
                const Icon(Icons.place_outlined, size: 18),
                const SizedBox(width: 6),
                Text('${source.distanceKm} km')
              ],
            ),
            const SizedBox(height: Spacing.md),
            OutlinedButton.icon(onPressed: () {}, icon: const Icon(Icons.near_me), label: const Text('दिशा निर्देश')),
          ],
        ),
      ),
    );
  }
}

