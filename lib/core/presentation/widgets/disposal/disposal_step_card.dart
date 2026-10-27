import 'package:flutter/material.dart';

class DisposalStepCard extends StatelessWidget {
  final String stepNumber;
  final String title;
  final String description;
  final IconData icon;

  const DisposalStepCard({
    super.key,
    required this.stepNumber,
    required this.title,
    required this.description,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Padding(
      padding: const EdgeInsets.only(bottom: 20.0),
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Container(
            margin: const EdgeInsets.only(left: 12),
            padding: const EdgeInsets.fromLTRB(26, 14, 16, 14),
            decoration: BoxDecoration(
              color: colorScheme.surfaceContainerHighest.withOpacity(0.4),
              borderRadius: BorderRadius.circular(20),
              border: Border.all(
                color: colorScheme.outlineVariant.withOpacity(0.5),
                width: 1.5,
              ),
            ),
            child: Row(
              children: [
                Container(
                  height: 48,
                  width: 48,
                  decoration: BoxDecoration(
                    color: colorScheme.surface,
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: colorScheme.outlineVariant.withOpacity(0.4),
                    ),
                  ),
                  child: Icon(
                    icon,
                    color: colorScheme.primary,
                    size: 24,
                  ),
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w700,
                          color: colorScheme.primary,
                        ),
                      ),
                      const SizedBox(height: 3),
                      Text(
                        description,
                        style: TextStyle(
                          fontSize: 11.5,
                          height: 1.3,
                          fontWeight: FontWeight.w500,
                          color: colorScheme.primary.withOpacity(0.8),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            left: 0,
            top: 22,
            child: Container(
              height: 28,
              width: 28,
              decoration: BoxDecoration(
                color: colorScheme.primary,
                shape: BoxShape.circle,
                border: Border.all(
                  color: theme.scaffoldBackgroundColor,
                  width: 2,
                ),
              ),
              child: Center(
                child: Text(
                  stepNumber,
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w800,
                    color: colorScheme.onPrimary,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}