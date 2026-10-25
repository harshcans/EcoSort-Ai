import 'package:flutter/material.dart';

class ScanTips extends StatelessWidget {
  const ScanTips({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Padding(
      padding: const EdgeInsets.only(top: 30),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Tips for better result',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: colorScheme.secondary,
            ),
          ),
          const SizedBox(height: 12),
          _buildItem(colorScheme, 'Use good lighting'),
          const SizedBox(height: 8),
          _buildItem(colorScheme, 'Keep the item in Focus'),
          const SizedBox(height: 8),
          _buildItem(colorScheme, 'Avoid Cluttered Background'),
        ],
      ),
    );
  }

  Widget _buildItem(ColorScheme colorScheme, String text) {
    return Row(
      children: [
        Icon(Icons.check, color: colorScheme.primary, size: 18),
        const SizedBox(width: 8),
        Text(
          text,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
            color: colorScheme.primary,
          ),
        ),
      ],
    );
  }
}
