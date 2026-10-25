import 'package:ecosort/core/routes/app_routes.dart';
import 'package:ecosort/features/auth/logic/auth_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import '../../../../core/presentation/widgets/primary_button.dart';
import 'custom_text_field.dart';

class ForgotPasswordSection extends StatefulWidget {
  final VoidCallback onBackToLogin;
  final Function(String email) onSendOtp;
  final bool isLoading;

  const ForgotPasswordSection({
    super.key,
    required this.onBackToLogin,
    required this.onSendOtp,
    this.isLoading = false,
  });

  @override
  State<ForgotPasswordSection> createState() => _ForgotPasswordSectionState();
}

class _ForgotPasswordSectionState extends State<ForgotPasswordSection> {
  final TextEditingController _emailController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  void _handleSubmit() async {
    final email = _emailController.text.trim();
    if (email.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter your email address')),
      );
      return;
    }

    final success = await context.read<AuthCubit>().sendOtp(email);

    if (success && mounted) {
      Navigator.pushNamed(context, AppRoutes.otp, arguments: email);
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Center(
          child: SvgPicture.asset(
            'assets/imageSvg/Group 15.svg',
            height: 187,
            fit: BoxFit.contain,
            errorBuilder: (context, error, stackTrace) {
              return Icon(
                Icons.lock_reset_rounded,
                size: 100,
                color: theme.colorScheme.primary,
              );
            },
          ),
        ),
        const SizedBox(height: 16),

        // Title
        Padding(
          padding: const EdgeInsets.only(left: 22),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Forgot Password ?',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                  color: theme.colorScheme.primary,
                ),
              ),
              const SizedBox(height: 6),
              Text(
                '''No worries ! Enter your email address and''',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 13,
                  height: 1.4,
                  color: theme.colorScheme.secondary,
                  fontWeight: FontWeight.w400,
                ),
              ),
              Text(
                "we’ll send you a OTP . ",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 13,
                  height: 1.4,
                  color: theme.colorScheme.secondary,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 24),

        CustomTextField(
          controller: _emailController,
          hintText: 'Email Address',
          svgIcon: 'assets/imageSvg/Vector (3).svg',
          fallbackIcon: Icons.email_outlined,
          keyboardType: TextInputType.emailAddress,
        ),
        const SizedBox(height: 24),

        PrimaryButton(
          text: 'Send OTP',
          isLoading: widget.isLoading,
          onPressed: _handleSubmit,
        ),
        const SizedBox(height: 16),

        Row(
          children: [
            Expanded(
              child: Divider(
                color: theme.colorScheme.primary.withOpacity(1),
                thickness: 1,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: Text(
                'or',
                style: TextStyle(
                  fontSize: 14,
                  color: theme.colorScheme.primary.withOpacity(1),
                ),
              ),
            ),
            Expanded(
              child: Divider(
                color: theme.colorScheme.primary.withOpacity(1),
                thickness: 1,
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),

        // Back to Login Link
        GestureDetector(
          onTap: widget.onBackToLogin,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.arrow_back,
                size: 16,
                color: theme.colorScheme.primary,
              ),
              const SizedBox(width: 6),
              Text(
                'Back to Login',
                style: TextStyle(
                  color: theme.colorScheme.primary,
                  fontWeight: FontWeight.w700,
                  fontSize: 14,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 24),
      ],
    );
  }
}
