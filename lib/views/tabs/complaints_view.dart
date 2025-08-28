import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:jal_setu/controllers/complaints_controller.dart';
import 'package:jal_setu/models/complaint.dart';
import 'package:jal_setu/services/api_service.dart';
import 'package:jal_setu/utils/app_theme.dart';
import 'package:jal_setu/utils/validators.dart';

class ComplaintsView extends StatelessWidget {
  const ComplaintsView({super.key, required this.api});
  final ApiService api;

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ComplaintsController(api));
    return Scaffold(
      appBar: AppBar(
        title: const Text('मेरी शिकायतें'),
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: Spacing.md),
            child: ElevatedButton.icon(
              onPressed: () => Get.to(() => NewComplaintPage(controller: controller)),
              icon: const Icon(Icons.add),
              label: const Text('नई शिकायत'),
            ),
          ),
        ],
      ),
      body: Obx(() {
        if (controller.loading.value) return const Center(child: CircularProgressIndicator());
        final items = controller.complaints;
        return ListView.builder(
          itemCount: items.length,
          itemBuilder: (context, index) => _ComplaintCard(item: items[index]),
        );
      }),
    );
  }
}

class _ComplaintCard extends StatelessWidget {
  const _ComplaintCard({required this.item});
  final Complaint item;
  @override
  Widget build(BuildContext context) {
    final created = DateFormat('y-MM-dd').format(item.createdAt);
    final status = _statusPill(item.status);
    final pr = _priorityPill(item.priority);
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(Spacing.lg),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('#${item.id}', style: Theme.of(context).textTheme.titleMedium),
                Row(children: [pr, const SizedBox(width: 8), status]),
              ],
            ),
            const SizedBox(height: 8),
            Text(item.title, style: Theme.of(context).textTheme.titleLarge),
            const SizedBox(height: 4),
            Text(item.description),
            const SizedBox(height: 8),
            Row(children: [const Icon(Icons.place_outlined, size: 16), const SizedBox(width: 4), Text(item.ward)]),
            const SizedBox(height: 8),
            Row(children: [const Icon(Icons.calendar_today, size: 16), const SizedBox(width: 4), Text(created)]),
          ],
        ),
      ),
    );
  }

  Widget _statusPill(ComplaintStatus status) {
    late Color color;
    late String label;
    switch (status) {
      case ComplaintStatus.received:
        color = Colors.blue;
        label = 'प्राप्त';
        break;
      case ComplaintStatus.assigned:
        color = Colors.orange;
        label = 'सौंपा गया';
        break;
      case ComplaintStatus.inProgress:
        color = Colors.amber;
        label = 'प्रगति में';
        break;
      case ComplaintStatus.resolved:
        color = Colors.green;
        label = 'हल हो गया';
        break;
      case ComplaintStatus.closed:
        color = Colors.grey;
        label = 'बंद';
        break;
    }
    return _pill(label, color);
  }

  Widget _priorityPill(ComplaintPriority p) {
    switch (p) {
      case ComplaintPriority.low:
        return _pill('low', Colors.blueGrey);
      case ComplaintPriority.medium:
        return _pill('medium', Colors.orange);
      case ComplaintPriority.high:
        return _pill('high', Colors.red);
    }
  }

  Widget _pill(String text, Color color) => Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
        decoration: BoxDecoration(color: color.withOpacity(0.15), borderRadius: BorderRadius.circular(18)),
        child: Text(text, style: TextStyle(color: color, fontWeight: FontWeight.w600)),
      );
}

class NewComplaintPage extends StatefulWidget {
  const NewComplaintPage({super.key, required this.controller});
  final ComplaintsController controller;
  @override
  State<NewComplaintPage> createState() => _NewComplaintPageState();
}

class _NewComplaintPageState extends State<NewComplaintPage> {
  final _formKey = GlobalKey<FormState>();
  final titleCtrl = TextEditingController();
  final descCtrl = TextEditingController();
  final wardCtrl = TextEditingController(text: 'Ward 12, Barmer');
  ComplaintPriority priority = ComplaintPriority.medium;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('नई शिकायत')),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(Spacing.lg),
          children: [
            TextFormField(
              controller: titleCtrl,
              decoration: const InputDecoration(
                labelText: 'शीर्षक',
                prefixIcon: Icon(Icons.title),
              ),
              validator: Validators.requiredField,
            ),
            const SizedBox(height: Spacing.md),
            TextFormField(
              controller: descCtrl,
              decoration: const InputDecoration(
                labelText: 'विवरण',
                prefixIcon: Icon(Icons.description_outlined),
              ),
              minLines: 3,
              maxLines: 5,
              validator: Validators.requiredField,
            ),
            const SizedBox(height: Spacing.md),
            TextFormField(
              controller: wardCtrl,
              decoration: const InputDecoration(
                labelText: 'वार्ड',
                prefixIcon: Icon(Icons.place_outlined),
              ),
              validator: Validators.requiredField,
            ),
            const SizedBox(height: Spacing.md),
            DropdownButtonFormField<ComplaintPriority>(
              value: priority,
              decoration: const InputDecoration(labelText: 'प्राथमिकता', prefixIcon: Icon(Icons.flag_outlined)),
              items: const [
                DropdownMenuItem(value: ComplaintPriority.low, child: Text('Low')),
                DropdownMenuItem(value: ComplaintPriority.medium, child: Text('Medium')),
                DropdownMenuItem(value: ComplaintPriority.high, child: Text('High')),
              ],
              onChanged: (v) => setState(() => priority = v ?? ComplaintPriority.medium),
            ),
            const SizedBox(height: Spacing.lg),
            Obx(() => ElevatedButton(
                  onPressed: widget.controller.loading.value
                      ? null
                      : () async {
                          if (_formKey.currentState!.validate()) {
                            await widget.controller.submit(ComplaintInput(
                              title: titleCtrl.text.trim(),
                              description: descCtrl.text.trim(),
                              ward: wardCtrl.text.trim(),
                              priority: priority,
                            ));
                            if (mounted) Get.back();
                            Get.snackbar('सफल', 'शिकायत दर्ज हो गई');
                          }
                        },
                  child: widget.controller.loading.value
                      ? const SizedBox(height: 20, width: 20, child: CircularProgressIndicator(strokeWidth: 2))
                      : const Text('सबमिट करें'),
                )),
          ],
        ),
      ),
    );
  }
}

