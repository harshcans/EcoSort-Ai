import 'package:flutter/material.dart';

class HistoryCard extends StatelessWidget {
  final String title;
  final String category;
  final double confidence;
  final String timestamp;
  final int points;
  final VoidCallback onTap;

  const HistoryCard({
    super.key,
    required this.title,
    required this.category,
    required this.confidence,
    required this.timestamp,
    this.points = 5,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final config = _getCategoryConfig(category);

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 10,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(18),
          child: Padding(
            padding: const EdgeInsets.all(14),
            child: Row(
              children: [
                // 1. Left Vector Icon Tile
                Container(
                  width: 56,
                  height: 56,
                  decoration: BoxDecoration(
                    color: config.background,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Icon(
                    config.icon,
                    color: config.foreground,
                    size: 28,
                  ),
                ),
                const SizedBox(width: 14),

                // 2. Middle Information
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                          color: Color(0xFF1E293B),
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 6),
                      Row(
                        children: [
                          // Category Pill
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 10,
                              vertical: 3,
                            ),
                            decoration: BoxDecoration(
                              color: config.foreground,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Text(
                              config.label,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 11,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                          const SizedBox(width: 8),

                          // Match Accuracy Pill
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 10,
                              vertical: 3,
                            ),
                            decoration: BoxDecoration(
                              color: config.background,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Text(
                              '${(confidence * 100).toInt()}% match',
                              style: TextStyle(
                                color: config.foreground,
                                fontSize: 11,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 5),
                      Text(
                        timestamp,
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                          color: Colors.grey.shade500,
                        ),
                      ),
                    ],
                  ),
                ),

                // 3. Right: Points Badge & Arrow
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: colorScheme.primary,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        '+$points pts',
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 11,
                        ),
                      ),
                    ),
                    const SizedBox(width: 6),
                    Icon(
                      Icons.chevron_right_rounded,
                      size: 22,
                      color: Colors.grey.shade400,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  _CategoryConfig _getCategoryConfig(String type) {
    final lower = type.toLowerCase();

    if (lower.contains('plastic')) {
      return _CategoryConfig(
        icon: Icons.local_drink_rounded,
        foreground: const Color(0xFF0284C7),
        background: const Color(0xFFE0F2FE),
        label: 'Plastic',
      );
    } else if (lower.contains('paper') || lower.contains('cardboard')) {
      return _CategoryConfig(
        icon: Icons.inventory_2_rounded,
        foreground: const Color(0xFFB45309),
        background: const Color(0xFFFEF3C7),
        label: 'Paper',
      );
    } else if (lower.contains('glass')) {
      return _CategoryConfig(
        icon: Icons.wine_bar_rounded,
        foreground: const Color(0xFF0F766E),
        background: const Color(0xFFCCFBF1),
        label: 'Glass',
      );
    } else if (lower.contains('metal') || lower.contains('can')) {
      return _CategoryConfig(
        icon: Icons.hardware_rounded,
        foreground: const Color(0xFF475569),
        background: const Color(0xFFF1F5F9),
        label: 'Metal',
      );
    } else if (lower.contains('e-waste') || lower.contains('electronic')) {
      return _CategoryConfig(
        icon: Icons.devices_other_rounded,
        foreground: const Color(0xFF7C3AED),
        background: const Color(0xFFEDE9FE),
        label: 'E-Waste',
      );
    }

    return _CategoryConfig(
      icon: Icons.recycling_rounded,
      foreground: const Color(0xFF1E5631),
      background: const Color(0xFFE8F5E9),
      label: 'General',
    );
  }
}

class _CategoryConfig {
  final IconData icon;
  final Color foreground;
  final Color background;
  final String label;

  _CategoryConfig({
    required this.icon,
    required this.foreground,
    required this.background,
    required this.label,
  });
}