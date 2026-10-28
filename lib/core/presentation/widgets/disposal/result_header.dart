// import 'package:flutter/material.dart';

// class ResultHeader extends StatelessWidget {
//   final VoidCallback onBack;
//   final String category;
//   final String subtitle;

//   const ResultHeader({
//     super.key,
//     required this.onBack,
//     required this.category,
//     this.subtitle = 'Identify, sort and recycle waste responsibly.',
//   });

//   @override
//   Widget build(BuildContext context) {
//     final theme = Theme.of(context);
//     final colorScheme = theme.colorScheme;

//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         InkWell(
//           onTap: onBack,
//           borderRadius: BorderRadius.circular(20),
//           child: Container(
//             height: 40,
//             width: 40,
//             decoration: BoxDecoration(
//               color: colorScheme.primary.withOpacity(0.12),
//               shape: BoxShape.circle,
//             ),
//             child: Icon(Icons.arrow_back, color: colorScheme.primary, size: 20),
//           ),
//         ),
//         const SizedBox(height: 20),
//         Row(
//           crossAxisAlignment: CrossAxisAlignment.center,
//           children: [
//             Container(
//               height: 60,
//               width: 60,
//               decoration: BoxDecoration(
//                 color: colorScheme.secondary.withOpacity(0.25),
//                 shape: BoxShape.circle,
//               ),
//               child: Icon(
//                 Icons.recycling_rounded,
//                 color: colorScheme.secondary,
//                 size: 34,
//               ),
//             ),
//             const SizedBox(width: 16),
//             Expanded(
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text(
//                     '$category Waste',
//                     style: TextStyle(
//                       fontSize: 22,
//                       fontWeight: FontWeight.w800,
//                       color: colorScheme.primary,
//                     ),
//                   ),
//                   const SizedBox(height: 2),
//                   Text(
//                     subtitle,
//                     style: TextStyle(
//                       fontSize: 13,
//                       fontWeight: FontWeight.w500,
//                       color: colorScheme.primary.withOpacity(0.85),
//                       height: 1.3,
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ],
//     );
//   }
// }

import 'package:flutter/material.dart';

class ResultHeader extends StatelessWidget {
  final VoidCallback onBack;
  final String category;
  final String subtitle;
  final IconData? icon;
  final Color? iconColor;
  final Color? iconBgColor;

  const ResultHeader({
    super.key,
    required this.onBack,
    required this.category,
    this.subtitle = 'Identify, sort and recycle waste responsibly.',
    this.icon,
    this.iconColor,
    this.iconBgColor,
  });

  String _formatCategoryTitle(String cat) {
    if (cat.trim().isEmpty) return 'General';
    final clean = cat.trim();
    return clean[0].toUpperCase() + clean.substring(1).toLowerCase();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final formattedCat = _formatCategoryTitle(category);

    final isOrganic =
        category.trim().toLowerCase().contains('organic') ||
        category.trim().toLowerCase().contains('bio');

    // Category ke hisab se default colors aur icons agar bahar se pass na hue hon
    final effectiveIcon =
        icon ?? (isOrganic ? Icons.eco_rounded : Icons.recycling_rounded);
    final effectiveIconColor =
        iconColor ?? (isOrganic ? colorScheme.primary : colorScheme.secondary);
    final effectiveBgColor =
        iconBgColor ??
        (isOrganic
            ? colorScheme.primaryContainer
            : colorScheme.secondary.withOpacity(0.25));

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
                color: effectiveBgColor,
                shape: BoxShape.circle,
              ),
              child: Icon(effectiveIcon, color: effectiveIconColor, size: 34),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Disposal Guide for $formattedCat Waste',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w800,
                      color: colorScheme.primary,
                      height: 1.25,
                    ),
                  ),
                  const SizedBox(height: 4),
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
