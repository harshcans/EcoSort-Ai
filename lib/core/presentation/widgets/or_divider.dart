import 'package:flutter/material.dart';

class OrDivider extends StatelessWidget {
  const OrDivider({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final dividerColor = isDark ? Colors.white24 : Colors.black26;
    final textColor = isDark ? Colors.white70 : Colors.black54;

    return Row(
      children: [
        Expanded(child: Divider(color: dividerColor)),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: Text('or', style: TextStyle(color: textColor, fontSize: 13)),
        ),
        Expanded(child: Divider(color: dividerColor)),
      ],
    );
  }
}