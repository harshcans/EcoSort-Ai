import 'package:flutter/material.dart';

class StatsUserCard extends StatelessWidget {
  final String name;
  final String email;
  final String badgeText;
  final String quote;

  const StatsUserCard({
    super.key,
    this.name = 'Nikhil kumar',
    this.email = 'nikki@ecosort.com',
    this.badgeText = 'Eco Warrior',
    this.quote = 'Small actions make a big difference',
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            CircleAvatar(
              radius: 34,
              backgroundColor: colorScheme.primary,
              child: Icon(
                Icons.person,
                size: 40,
                color: colorScheme.onPrimary,
              ),
            ),
            const SizedBox(width: 16),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: theme.textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.w800,
                        color: colorScheme.primary,
                      ) ??
                      TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w800,
                        color: colorScheme.primary,
                      ),
                ),
                const SizedBox(height: 2),
                Text(
                  email,
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: colorScheme.secondary,
                  ),
                ),
              ],
            ),
          ],
        ),
        const SizedBox(height: 18),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          decoration: BoxDecoration(
            color: colorScheme.primary.withOpacity(0.12),
            borderRadius: BorderRadius.circular(16),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.auto_awesome,
                color: colorScheme.primary,
                size: 15,
              ),
              const SizedBox(width: 6),
              Text(
                badgeText,
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w700,
                  color: colorScheme.primary,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 10),
        Text(
          quote,
          style: TextStyle(
            color: colorScheme.secondary,
            fontSize: 13,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}