import 'package:flutter/material.dart';

class HistoryFilterBar extends StatelessWidget {
  final List<String> categories;
  final String selectedCategory;
  final ValueChanged<String> onSelected;

  const HistoryFilterBar({
    super.key,
    required this.categories,
    required this.selectedCategory,
    required this.onSelected,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
      child: Row(
        children: categories.map((cat) {
          final isSelected = selectedCategory.toLowerCase() == cat.toLowerCase();
          return Padding(
            padding: const EdgeInsets.only(right: 10),
            child: InkWell(
              onTap: () => onSelected(cat),
              borderRadius: BorderRadius.circular(24),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                decoration: BoxDecoration(
                  color: isSelected ? colorScheme.primary : Colors.transparent,
                  borderRadius: BorderRadius.circular(24),
                  border: Border.all(
                    color: colorScheme.primary,
                    width: 1.5,
                  ),
                ),
                child: Text(
                  cat,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: isSelected ? FontWeight.w700 : FontWeight.w600,
                    color: isSelected ? colorScheme.onPrimary : colorScheme.primary,
                  ),
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}