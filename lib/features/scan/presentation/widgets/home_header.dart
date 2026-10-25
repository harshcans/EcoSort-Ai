import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class HomeHeader extends StatelessWidget {
  final VoidCallback? onNotificationTap;
  final VoidCallback? onProfileTap;

  const HomeHeader({super.key, this.onNotificationTap, this.onProfileTap});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        SvgPicture.asset('assets/imageSvg/Frame 22.svg', height: 38, width: 40),
        const SizedBox(width: 8),
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            InkWell(
              borderRadius: BorderRadius.circular(20),
              onTap: onNotificationTap,
              child: Padding(
                padding: const EdgeInsets.all(6),
                child: SvgPicture.asset(
                  'assets/imageSvg/akar-icons_bell (1).svg',
                  height: 29,
                  width: 24,
                  colorFilter: ColorFilter.mode(
                    colorScheme.primary,
                    BlendMode.srcIn,
                  ),
                ),
              ),
            ),
            const SizedBox(width: 8),
            InkWell(
              borderRadius: BorderRadius.circular(20),
              onTap: onProfileTap,
              child: Padding(
                padding: const EdgeInsets.all(6),
                child: SvgPicture.asset(
                  'assets/imageSvg/andrsrxn_user-circle.svg',
                  height: 29,
                  width: 24,
                  colorFilter: ColorFilter.mode(
                    colorScheme.primary,
                    BlendMode.srcIn,
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
