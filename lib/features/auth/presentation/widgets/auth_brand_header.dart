import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AuthBrandHeader extends StatelessWidget {
  final VoidCallback onBack;

  const AuthBrandHeader({super.key, required this.onBack});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Align(
          alignment: Alignment.centerLeft,
          child: InkWell(
            onTap: onBack,
            borderRadius: BorderRadius.circular(20),
            child: Container(
              height: 36,
              width: 36,
              decoration: BoxDecoration(
                color: theme.colorScheme.primary.withOpacity(0.12),
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.arrow_back,
                size: 18,
                color: theme.colorScheme.primary,
              ),
            ),
          ),
        ),
        const SizedBox(height: 0),

        Center(
          child: SvgPicture.asset(
            'assets/imageSvg/Frame 22.svg',
            height: 80,
            fit: BoxFit.contain,
          ),
        ),
        const SizedBox(height: 6),
        Text(
          'Scan it. Sort it. Save the planet.',
          textAlign: TextAlign.center,
          style: TextStyle(
            color: theme.colorScheme.primary,
            fontSize: 16,
            fontWeight: FontWeight.w700,
            letterSpacing: 0.2,
          ),
        ),
      ],
    );
  }
}
