import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class PrimaryButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final String label;
  final IconData? icon;
  const PrimaryButton({super.key, required this.onPressed, required this.label, this.icon});

  @override
  Widget build(BuildContext context) {
    final btn = FilledButton.icon(
      onPressed: onPressed,
      icon: Icon(icon ?? Icons.check),
      label: Text(label),
    );
    return btn.animate().scale(begin: const Offset(0.98, 0.98), end: const Offset(1, 1), duration: const Duration(milliseconds: 250));
  }
}

