import 'dart:io';
import 'package:flutter/material.dart';

class HistoryCard extends StatelessWidget {
  final String title;
  final String category;
  final double confidence;
  final String? imagePath;
  final VoidCallback onTap;

  const HistoryCard({
    super.key,
    required this.title,
    required this.category,
    required this.confidence,
    this.imagePath,
    required this.onTap,
  });

  Widget _buildImageWidget(String? path, _CategoryConfig config) {
    if (path != null && path.trim().isNotEmpty) {
      // Local File (Camera / Gallery cached path)
      if (!path.startsWith('http')) {
        final file = File(path);
        if (file.existsSync()) {
          return Image.file(file, width: 70, height: 70, fit: BoxFit.cover);
        }
      } else {
        // Network Image (Render / Cloud storage)
        return Image.network(
          path,
          width: 70,
          height: 70,
          fit: BoxFit.cover,
          errorBuilder: (_, __, ___) =>
              Icon(config.icon, color: config.foreground, size: 34),
        );
      }
    }

    // Default Fallback Icon
    return Icon(config.icon, color: config.foreground, size: 34);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final config = _getCategoryConfig(category, colorScheme);

    return Container(
      margin: const EdgeInsets.only(bottom: 14),
      decoration: BoxDecoration(
        color: theme.cardColor,
        borderRadius: BorderRadius.circular(22),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(22),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
            child: Row(
              children: [
                // 1. Left Thumbnail / Icon Box
                ClipRRect(
                  borderRadius: BorderRadius.circular(18),
                  child: Container(
                    width: 70,
                    height: 70,
                    color: config.background,
                    alignment: Alignment.center,
                    child: _buildImageWidget(imagePath, config),
                  ),
                ),
                const SizedBox(width: 14),

                // 2. Middle Content (Title + Dynamic Badge Pills)
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        title,
                        style: theme.textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.w800,
                          fontSize: 17,
                          letterSpacing: -0.2,
                          color: colorScheme.onSurface,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 8),
                      Wrap(
                        spacing: 8,
                        runSpacing: 4,
                        children: [
                          // Category Filled Badge
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 4,
                            ),
                            decoration: BoxDecoration(
                              color: config.foreground,
                              borderRadius: BorderRadius.circular(14),
                            ),
                            child: Text(
                              config.label,
                              style: theme.textTheme.labelSmall?.copyWith(
                                color: Colors.white,
                                fontWeight: FontWeight.w700,
                                fontSize: 12,
                              ),
                            ),
                          ),

                          // Match Percentage Pastel Badge
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 10,
                              vertical: 4,
                            ),
                            decoration: BoxDecoration(
                              color: config.badgeBackground,
                              borderRadius: BorderRadius.circular(14),
                            ),
                            child: Text(
                              '${(confidence * 100).toInt()}% match',
                              style: theme.textTheme.labelSmall?.copyWith(
                                color: config.foreground,
                                fontWeight: FontWeight.w700,
                                fontSize: 12,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),

                // 3. Right Chevron Indicator
                Padding(
                  padding: const EdgeInsets.only(left: 4.0),
                  child: Icon(
                    Icons.chevron_right_rounded,
                    size: 26,
                    color: colorScheme.onSurface.withOpacity(0.35),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  _CategoryConfig _getCategoryConfig(String type, ColorScheme scheme) {
    final lower = type.toLowerCase();

    if (lower.contains('plastic')) {
      return _CategoryConfig(
        icon: Icons.local_drink_rounded,
        foreground: const Color(0xFF0284C7),
        background: const Color(0xFFE0F2FE),
        badgeBackground: const Color(0xFFBAE6FD),
        label: 'Plastic',
      );
    } else if (lower.contains('paper') || lower.contains('cardboard')) {
      return _CategoryConfig(
        icon: Icons.inventory_2_rounded,
        foreground: const Color(0xFFB45309),
        background: const Color(0xFFFEF3C7),
        badgeBackground: const Color(0xFFFDE68A),
        label: 'Paper',
      );
    } else if (lower.contains('glass')) {
      return _CategoryConfig(
        icon: Icons.wine_bar_rounded,
        foreground: const Color(0xFF0F766E),
        background: const Color(0xFFCCFBF1),
        badgeBackground: const Color(0xFF99F6E4),
        label: 'Glass',
      );
    } else if (lower.contains('metal') || lower.contains('can')) {
      return _CategoryConfig(
        icon: Icons.hardware_rounded,
        foreground: const Color(0xFF475569),
        background: const Color(0xFFF1F5F9),
        badgeBackground: const Color(0xFFE2E8F0),
        label: 'Metal',
      );
    } else if (lower.contains('e-waste') || lower.contains('electronic')) {
      return _CategoryConfig(
        icon: Icons.devices_other_rounded,
        foreground: const Color(0xFF7C3AED),
        background: const Color(0xFFEDE9FE),
        badgeBackground: const Color(0xFFDDD6FE),
        label: 'E-Waste',
      );
    }

    // Default General -> Organic (Green Theme)
    return _CategoryConfig(
      icon: Icons.eco_rounded,
      foreground: const Color(0xFF16A34A),
      background: const Color(0xFFDCFCE7),
      badgeBackground: const Color(0xFFBBF7D0),
      label: 'Organic',
    );
  }
}

class _CategoryConfig {
  final IconData icon;
  final Color foreground;
  final Color background;
  final Color badgeBackground;
  final String label;

  _CategoryConfig({
    required this.icon,
    required this.foreground,
    required this.background,
    required this.badgeBackground,
    required this.label,
  });
}
