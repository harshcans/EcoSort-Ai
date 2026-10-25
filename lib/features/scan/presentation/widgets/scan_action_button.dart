import 'package:flutter/material.dart';

class ScanActionButtons extends StatelessWidget {
  final VoidCallback onDisposalGuideTap;
  final VoidCallback onScanWasteTap;

  const ScanActionButtons({
    super.key,
    required this.onDisposalGuideTap,
    required this.onScanWasteTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Column(
      children: [
        // Primary Button: Uses Theme's elevatedButtonTheme directly
        SizedBox(
          width: double.infinity,
          height: 50,
          child: ElevatedButton(
            onPressed: onDisposalGuideTap,
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Disposal Guide'),
                SizedBox(width: 8),
                Icon(Icons.arrow_forward_rounded, size: 18),
              ],
            ),
          ),
        ),

        const SizedBox(height: 12),

        // Secondary Button: Border and text dynamically bound to theme primary
        SizedBox(
          width: double.infinity,
          height: 50,
          child: OutlinedButton(
            onPressed: onScanWasteTap,
            style: OutlinedButton.styleFrom(
              side: BorderSide(
                color: colorScheme.primary,
                width: 1.2,
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(28),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.camera_alt_outlined,
                  color: colorScheme.primary,
                  size: 18,
                ),
                const SizedBox(width: 8),
                Text(
                  'Scan Waste',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: colorScheme.primary,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}