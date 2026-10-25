import 'package:flutter/material.dart';

class ScanControls extends StatelessWidget {
  final VoidCallback onGalleryTap;
  final VoidCallback onShutterTap;
  final VoidCallback onRemoveTap;

  const ScanControls({
    super.key,
    required this.onGalleryTap,
    required this.onShutterTap,
    required this.onRemoveTap,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        // Gallery Button
        InkWell(
          onTap: onGalleryTap,
          borderRadius: BorderRadius.circular(30),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: colorScheme.primary, width: 1.2),
                ),
                child: Icon(
                  Icons.photo_library_outlined,
                  size: 26,
                  color: colorScheme.primary,
                ),
              ),
              const SizedBox(height: 6),
              Text(
                'Gallery',
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                  color: colorScheme.primary,
                ),
              ),
            ],
          ),
        ),

        // Shutter Button
        GestureDetector(
          onTap: onShutterTap,
          child: Container(
            height: 64,
            width: 64,
            padding: const EdgeInsets.all(4),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: colorScheme.primary, width: 2.5),
            ),
            child: Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: colorScheme.primary,
              ),
            ),
          ),
        ),

        InkWell(
          onTap: onRemoveTap,
          borderRadius: BorderRadius.circular(30),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: colorScheme.primary, width: 1.2),
                ),
                child: Icon(
                  Icons.delete_outline_rounded,
                  size: 26,
                  color: colorScheme.primary,
                ),
              ),
              const SizedBox(height: 6),
              Text(
                'Remove',
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                  color: colorScheme.primary,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
