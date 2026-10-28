import 'package:ecosort/core/presentation/widgets/primary_button.dart';
import 'package:ecosort/core/presentation/widgets/splash_animtaion_controller.dart';
import 'package:ecosort/core/routes/app_routes.dart';
import 'package:ecosort/features/auth/presentation/widgets/auth_bottom_art.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
// Apne token storage service ka path ensure kar lena:
import 'package:ecosort/core/services/token_storage_service.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  late final SplashAnimationController _anim;
  bool _isCheckingAuth = true;

  @override
  void initState() {
    super.initState();
    _anim = SplashAnimationController(vsync: this);
    _checkExistingAuth();
  }

  Future<void> _checkExistingAuth() async {
    // Thoda sa delay dete hain taaki smooth lage aur preferences read ho jaye
    await Future.delayed(const Duration(milliseconds: 1200));

    final token = await TokenStorageService.getAccessToken();

    if (!mounted) return;

    // Agar token pehle se phone me save hai -> Seedha App ke Main / Home / Dashboard par bhej do!
    if (token != null && token.trim().isNotEmpty) {
      Navigator.pushReplacementNamed(
        context,
        AppRoutes.home,
      ); // Agar home ka route name alag hai (e.g. AppRoutes.dashboard) toh wo naam rakhna
    } else {
      // Agar token nahi hai, tab Get Started / Login ke buttons dikhao
      setState(() {
        _isCheckingAuth = false;
      });
    }
  }

  @override
  void dispose() {
    _anim.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: const SafeArea(top: false, child: AuthBottomArt()),
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
                      vertical: 12.0,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        const SizedBox(height: 35),

                        // 1. Top Logo
                        SlideTransition(
                          position: _anim.logoSlide,
                          child: FadeTransition(
                            opacity: _anim.logoFade,
                            child: Column(
                              children: [
                                Container(
                                  height: 75,
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
                              ],
                            ),
                          ),
                        ),

                        const SizedBox(height: 40),

                        // 2. Center Illustration
                        SlideTransition(
                          position: _anim.illustrationFloat,
                          child: ScaleTransition(
                            scale: _anim.illustrationScale,
                            child: FadeTransition(
                              opacity: _anim.illustrationFade,
                              child: Container(
                                height: 270,
                                alignment: Alignment.center,
                                child: SvgPicture.asset(
                                  'assets/imageSvg/Group 2 (1).svg',
                                  fit: BoxFit.contain,
                                ),
                              ),
                            ),
                          ),
                        ),

                        const SizedBox(height: 40),

                        // 3. Actions / Loader
                        if (_isCheckingAuth)
                          const Center(
                            child: Padding(
                              padding: EdgeInsets.all(24.0),
                              child: CircularProgressIndicator(),
                            ),
                          )
                        else
                          SlideTransition(
                            position: _anim.actionsSlide,
                            child: FadeTransition(
                              opacity: _anim.actionsFade,
                              child: Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 20,
                                      vertical: 8,
                                    ),
                                    child: PrimaryButton(
                                      text: 'Get Started',
                                      onPressed: () {
                                        Navigator.pushNamed(
                                          context,
                                          AppRoutes.register,
                                        );
                                      },
                                    ),
                                  ),
                                  const SizedBox(height: 8),
                                  const Row(
                                    children: [
                                      Expanded(
                                        child: Divider(color: Colors.black26),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.symmetric(
                                          horizontal: 12,
                                        ),
                                        child: Text(
                                          'or',
                                          style: TextStyle(
                                            color: Colors.black54,
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                        child: Divider(color: Colors.black26),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 14),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        'Already have an account? ',
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodySmall
                                            ?.copyWith(
                                              color: Colors.black87,
                                              fontSize: 14,
                                            ),
                                      ),
                                      GestureDetector(
                                        onTap: () {
                                          Navigator.pushNamed(
                                            context,
                                            AppRoutes.login,
                                          );
                                        },
                                        child: Text(
                                          'Log in',
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodySmall
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
                                ],
                              ),
                            ),
                          ),
                        const SizedBox(height: 8),
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
