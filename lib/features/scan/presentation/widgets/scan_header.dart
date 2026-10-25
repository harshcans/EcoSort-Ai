import 'package:flutter/material.dart';

class ScanHeader extends StatelessWidget {
  final VoidCallback? onBackTap;

  const ScanHeader({super.key, this.onBackTap});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Row(
      children: [
        InkWell(
          borderRadius: BorderRadius.circular(20),
          onTap: onBackTap ?? () => Navigator.maybePop(context),
          child: Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: colorScheme.primaryContainer.withValues(alpha: 1),
              shape: BoxShape.circle,
            ),
            child: Icon(Icons.arrow_back, color: colorScheme.primary, size: 25),
          ),
        ),
        const SizedBox(width: 14),
        Text(
          'Scan Waste',
          style: TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.bold,
            color: colorScheme.primary,
          ),
        ),
      ],
    );
  }
}
