import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class WasteCategoryCard extends StatelessWidget {
  final String category; // Model se aane wala raw keyword

  const WasteCategoryCard({super.key, required this.category});

  (String, bool, String, String, String) _getCategoryConfig(String rawCat) {
    final cat = rawCat.trim().toLowerCase();

    switch (cat) {
      case 'plastic':
        return (
          'assets/imageSvg/Group 26 (4).svg',
          false,
          'Plastic',
          'Inorganic',
          'Recyclable',
        );

      case 'glass':
        return (
          'assets/imageSvg/Group 26 (3).svg',
          false,
          'Glass',
          'Inorganic',
          'Recyclable',
        );

      case 'organic':
      case 'food':
        return (
          'assets/imageSvg/Group_26_dark_green.svg',
          true, // Green circle
          'Organic',
          'Organic',
          'Biodegradable',
        );

      case 'paper':
      case 'cardboard':
        return (
          'assets/imageSvg/Group 26 (1).svg',
          false,
          'Paper',
          'Organic',
          'Recyclable',
        );

      case 'e-waste':
      case 'battery':
      case 'hazardous':
      case 'toxic':
        return (
          'assets/imageSvg/hazardous.svg',
          false,
          'Hazardous',
          'Inorganic',
          'Special Disposal',
        );

      case 'metal':
      case 'can':
        return (
          'assets/imageSvg/Group 26 (2).svg',
          false,
          'Metal',
          'Inorganic',
          'Recyclable',
        );

      default:
        // Agar AI model ka keyword match na ho
        return (
          'assets/imageSvg/waste_icon_purple_small.svg',
          false,
          'Other',
          'Inorganic',
          'Non-Recyclable',
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    final (svgPath, isGreen, title, natureTag, disposalTag) =
        _getCategoryConfig(category);

    // Dynamic circle color: Organic -> Green Container, Baaki sab -> Purple Container
    final Color circleBg = isGreen
        ? colorScheme.primaryContainer
        : colorScheme.secondaryContainer;

    final Color svgTint = isGreen ? colorScheme.primary : colorScheme.secondary;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      decoration: BoxDecoration(
        color: colorScheme.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: colorScheme.primary.withOpacity(0.2),
          width: 1.2,
        ),
      ),
      child: Row(
        children: [
          Container(
            width: 70,
            height: 74,
            padding: const EdgeInsets.all(6),
            decoration: BoxDecoration(color: circleBg, shape: BoxShape.circle),
            child: SvgPicture.asset(
              svgPath,
              colorFilter: ColorFilter.mode(svgTint, BlendMode.srcIn),
            ),
          ),
          const SizedBox(width: 35),

          // Title & Tags
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  title,
                  style: theme.textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.w700,
                    fontSize: 24,
                  ),
                ),
                const SizedBox(height: 6),
                Row(
                  children: [
                    Text(
                      '• $natureTag',
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: colorScheme.onSurface.withOpacity(1),
                        fontWeight: FontWeight.w500,
                        fontSize: 14,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Text(
                      '• $disposalTag',
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: colorScheme.onSurface.withOpacity(1),
                        fontWeight: FontWeight.w500,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
