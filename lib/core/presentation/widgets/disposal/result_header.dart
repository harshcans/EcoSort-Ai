import 'package:flutter/material.dart';

class ResultHeader extends StatelessWidget {
  final VoidCallback onBack;
  final String category;
  final String subtitle;

  const ResultHeader({
    super.key,
    required this.onBack,
    required this.category,
    this.subtitle = 'Identify, sort and recycle waste responsibly.',
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        InkWell(
          onTap: onBack,
          borderRadius: BorderRadius.circular(20),
          child: Container(
            height: 40,
            width: 40,
            decoration: BoxDecoration(
              color: colorScheme.primary.withOpacity(0.12),
              shape: BoxShape.circle,
            ),
            child: Icon(Icons.arrow_back, color: colorScheme.primary, size: 20),
          ),
        ),
        const SizedBox(height: 20),
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              height: 60,
              width: 60,
              decoration: BoxDecoration(
                color: colorScheme.secondary.withOpacity(0.25),
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.recycling_rounded,
                color: colorScheme.secondary,
                size: 34,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '$category Waste',
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.w800,
                      color: colorScheme.primary,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    subtitle,
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w500,
                      color: colorScheme.primary.withOpacity(0.85),
                      height: 1.3,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }
}
