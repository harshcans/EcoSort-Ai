import 'package:ecosort/core/presentation/widgets/primary_button.dart';
import 'package:ecosort/core/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            return SingleChildScrollView(
              child: ConstrainedBox(
                constraints: BoxConstraints(minHeight: constraints.maxHeight),
                child: IntrinsicHeight(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 24.0,
                      vertical: 16.0,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        const SizedBox(height: 45),
                        Container(
                          height: 80,
                          alignment: Alignment.center,
                          child: SvgPicture.asset(
                            'assets/imageSvg/Frame 22.svg',
                            fit: BoxFit.contain,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'Scan it. Sort it. Save the planet.',
                          textAlign: TextAlign.center,
                          style: Theme.of(context).textTheme.bodyMedium
                              ?.copyWith(
                                fontWeight: FontWeight.w700,
                                letterSpacing: 0.2,
                                fontSize: 16,
                              ),
                        ),
                        SizedBox(height: 50),
                        Container(
                          height: 293,
                          alignment: Alignment.center,
                          child: SvgPicture.asset(
                            'assets/imageSvg/Group 2 (1).svg',
                            fit: BoxFit.contain,
                          ),
                        ),
                        SizedBox(height: 50),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 20,
                            vertical: 8,
                          ),
                          child: PrimaryButton(
                            text: 'Get Started',
                            onPressed: () {
                              Navigator.pushNamed(context, AppRoutes.auth);
                            },
                          ),
                        ),
                        const SizedBox(height: 8),
                        const Row(
                          children: [
                            Expanded(child: Divider(color: Colors.black26)),
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 12),
                              child: Text(
                                'or',
                                style: TextStyle(color: Colors.black54),
                              ),
                            ),
                            Expanded(child: Divider(color: Colors.black26)),
                          ],
                        ),
                        const SizedBox(height: 14),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Already have an account? ',
                              style: Theme.of(context).textTheme.bodySmall
                                  ?.copyWith(
                                    color: Colors.black87,
                                    fontSize: 14,
                                  ),
                            ),
                            GestureDetector(
                              onTap: () {
                                Navigator.pushNamed(context, AppRoutes.auth);
                              },
                              child: Text(
                                'Log in',
                                style: Theme.of(context).textTheme.bodySmall
                                    ?.copyWith(
                                      color: Theme.of(
                                        context,
                                      ).colorScheme.primary,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 14,
                                    ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 12),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
