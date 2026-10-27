import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class WasteSuccessCard extends StatelessWidget {
  final String title;

  const WasteSuccessCard({
    super.key,
    this.title = 'Waste detect\nsuccessfully!!',
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      decoration: BoxDecoration(
        color: colorScheme.surfaceContainerHighest.withOpacity(0.4),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(
          color: colorScheme.outlineVariant.withOpacity(0.5),
          width: 1.5,
        ),
      ),
      child: Row(
        children: [
          SizedBox(
            height: 120,
            width: 130,
            child: Stack(
              alignment: Alignment.center,
              children: [
                SizedBox(
                  height: 120,
                  width: 110,
                  child: SvgPicture.asset(
                    'assets/imageSvg/Group 22 (1).svg',
                    fit: BoxFit.contain,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 18),
          Expanded(
            child: Text(
              title,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w800,
                color: colorScheme.primary,
                height: 1.25,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
