import 'package:flutter/material.dart';

class ScanModeToggle extends StatelessWidget {
  final bool isCameraSelected;
  final ValueChanged<bool> onToggle;

  const ScanModeToggle({
    super.key,
    required this.isCameraSelected,
    required this.onToggle,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Container(
      height: 45,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: colorScheme.primary, width: 1.2),
      ),
      child: Row(
        children: [
          Expanded(
            child: GestureDetector(
              onTap: () => onToggle(true),
              child: Container(
                decoration: BoxDecoration(
                  color: isCameraSelected
                      ? colorScheme.primary
                      : Colors.transparent,
                  borderRadius: BorderRadius.circular(18),
                ),
                alignment: Alignment.center,
                child: Text(
                  'Camera',
                  style: TextStyle(
                    color: isCameraSelected
                        ? colorScheme.surface
                        : colorScheme.primary,
                    fontWeight: FontWeight.w600,
                    fontSize: 18,
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            child: GestureDetector(
              onTap: () => onToggle(false),
              child: Container(
                decoration: BoxDecoration(
                  color: !isCameraSelected
                      ? colorScheme.primary
                      : Colors.transparent,
                  borderRadius: BorderRadius.circular(18),
                ),
                alignment: Alignment.center,
                child: Text(
                  'Gallery',
                  style: TextStyle(
                    color: !isCameraSelected
                        ? colorScheme.surface
                        : colorScheme.primary,
                    fontWeight: FontWeight.w600,
                    fontSize: 18,
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
