import 'package:flutter/material.dart';

class StatsCounterCard extends StatelessWidget {
  final int totalScans;
  final int recycled;
  final double co2SavedKg;

  const StatsCounterCard({
    super.key,
    required this.totalScans,
    required this.recycled,
    required this.co2SavedKg,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Container(
      decoration: BoxDecoration(
        color: colorScheme.surfaceContainerHighest.withOpacity(0.4),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: colorScheme.outlineVariant.withOpacity(0.5),
          width: 1.5,
        ),
      ),
      child: IntrinsicHeight(
        child: Row(
          children: [
            _buildStatItem(
              context: context,
              icon: Icons.filter_center_focus,
              count: '$totalScans',
              label: 'Total Scans',
            ),
            VerticalDivider(
              color: colorScheme.outlineVariant.withOpacity(0.5),
              thickness: 1.5,
              width: 1,
            ),
            _buildStatItem(
              context: context,
              icon: Icons.recycling_rounded,
              count: '$recycled',
              label: 'Recycled',
            ),
            VerticalDivider(
              color: colorScheme.outlineVariant.withOpacity(0.5),
              thickness: 1.5,
              width: 1,
            ),
            _buildStatItem(
              context: context,
              icon: Icons.energy_savings_leaf_outlined,
              count: '${co2SavedKg.toStringAsFixed(1)}kg',
              label: 'CO₂ Saved',
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatItem({
    required BuildContext context,
    required IconData icon,
    required String count,
    required String label,
  }) {
    final colorScheme = Theme.of(context).colorScheme;

    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 18),
        child: Column(
          children: [
            Icon(icon, color: colorScheme.primary, size: 28),
            const SizedBox(height: 8),
            Text(
              count,
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w800,
                color: colorScheme.primary,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              label,
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: colorScheme.primary.withOpacity(0.85),
              ),
            ),
          ],
        ),
      ),
    );
  }
}