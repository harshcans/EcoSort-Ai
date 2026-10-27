import 'package:flutter/material.dart';

class StatsCategoryChart extends StatelessWidget {
  final Map<String, int> categoryCounts;
  final int totalScans;

  const StatsCategoryChart({
    super.key,
    required this.categoryCounts,
    required this.totalScans,
  });

  double _getBarHeight(int count) {
    if (totalScans == 0) return 6.0;
    final height = (count / totalScans) * 110;
    return height < 6.0 ? 6.0 : height;
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    final categories = [
      {'name': 'Plastic', 'color': colorScheme.secondary},
      {'name': 'Paper', 'color': colorScheme.secondary.withOpacity(0.4)},
      {'name': 'Glass', 'color': colorScheme.tertiary.withOpacity(0.8)},
      {'name': 'Metal', 'color': colorScheme.primary.withOpacity(0.6)},
      {'name': 'Organic', 'color': colorScheme.primary.withOpacity(0.4)},
      {'name': 'E-Waste', 'color': colorScheme.secondary.withOpacity(0.8)},
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Waste by category',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: colorScheme.primary,
          ),
        ),
        const SizedBox(height: 14),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 24),
          decoration: BoxDecoration(
            color: colorScheme.surfaceContainerHighest.withOpacity(0.4),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: colorScheme.outlineVariant.withOpacity(0.5),
              width: 1.5,
            ),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: 140,
                width: 140,
                child: Stack(
                  alignment: Alignment.bottomLeft,
                  children: [
                    Container(
                      height: 135,
                      width: 8,
                      color: colorScheme.outlineVariant.withOpacity(0.4),
                    ),
                    Container(
                      height: 8,
                      width: 135,
                      color: colorScheme.outlineVariant.withOpacity(0.4),
                    ),
                    Positioned(
                      bottom: 8,
                      left: 14,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: categories.map((cat) {
                          final name = cat['name'] as String;
                          final color = cat['color'] as Color;
                          final count = categoryCounts[name] ?? 0;
                          return Padding(
                            padding: const EdgeInsets.only(right: 8.0),
                            child: AnimatedContainer(
                              duration: const Duration(milliseconds: 500),
                              width: 10,
                              height: _getBarHeight(count),
                              decoration: BoxDecoration(
                                color: color,
                                borderRadius: const BorderRadius.vertical(
                                  top: Radius.circular(2),
                                ),
                              ),
                            ),
                          );
                        }).toList(),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 20),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: categories.map((cat) {
                    final name = cat['name'] as String;
                    final color = cat['color'] as Color;
                    final count = categoryCounts[name] ?? 0;
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 8.0),
                      child: Row(
                        children: [
                          Container(
                            width: 8,
                            height: 8,
                            decoration: BoxDecoration(
                              color: color,
                              shape: BoxShape.circle,
                            ),
                          ),
                          const SizedBox(width: 8),
                          Text(
                            '$name ($count)',
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              color: colorScheme.primary,
                            ),
                          ),
                        ],
                      ),
                    );
                  }).toList(),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
