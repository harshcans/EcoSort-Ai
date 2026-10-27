import 'package:ecosort/features/auth/presentation/widgets/auth_bottom_art.dart';
import 'package:ecosort/features/scan/presentation/widgets/rotating_sparkle_circle.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ScanIdentifyingScreen extends StatelessWidget {
  const ScanIdentifyingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final mascotWidth = MediaQuery.of(context).size.width * 0.72;

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      bottomNavigationBar: const SafeArea(top: false, child: AuthBottomArt()),
      body: SafeArea(
        bottom: false,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 20, top: 16),
              child: SvgPicture.asset(
                'assets/imageSvg/Frame 22.svg',
                height: 40,
              ),
            ),

            const Spacer(),

            Center(
              child: SizedBox(
                width: mascotWidth,
                height: 280,
                child: Stack(
                  clipBehavior: Clip.none,
                  children: [
                    // Mascot SVG
                    SvgPicture.asset(
                      'assets/imageSvg/Group 45.svg',
                      width: mascotWidth,
                      fit: BoxFit.scaleDown,
                    ),

                    Positioned(
                      top: mascotWidth * 0.16,
                      right: mascotWidth * 0.04,
                      child: const RotatingSparkleCircle(
                        size: 45,
                        duration: Duration(seconds: 3),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 10),

            Center(
              child: Column(
                children: const [
                  Text(
                    'Identifying your waste...',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                      color: Color(0xFF235336),
                      letterSpacing: -0.1,
                    ),
                  ),
                  SizedBox(height: 12),
                  Text(
                    'this will onlytake a few seconds.',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: Color(0xFF3B724D),
                    ),
                  ),
                ],
              ),
            ),

            const Spacer(flex: 2),
          ],
        ),
      ),
    );
  }
}
