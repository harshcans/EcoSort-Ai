import 'package:flutter/material.dart';
import '../../../../core/presentation/widgets/primary_button.dart';
import 'custom_text_field.dart';

class LoginFormSection extends StatefulWidget {
  final VoidCallback onToggleToSignUp;
  final VoidCallback onForgotPassword;
  final Function(String email, String password, bool rememberMe) onLoginSubmit;
  final bool isLoading;

  const LoginFormSection({
    super.key,
    required this.onToggleToSignUp,
    required this.onForgotPassword,
    required this.onLoginSubmit,
    this.isLoading = false,
  });

  @override
  State<LoginFormSection> createState() => _LoginFormSectionState();
}

class _LoginFormSectionState extends State<LoginFormSection> {
  final TextEditingController _emailController = TextEditingController(
    text: 'test@ecosort.com',
  );
  final TextEditingController _passwordController = TextEditingController(
    text: '123456',
  );
  bool _isPasswordVisible = false;
  bool _rememberMe = false;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          'Welcome Back!',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: theme.colorScheme.primary,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          'Log in to continue your journey.',
          style: TextStyle(fontSize: 13, color: theme.colorScheme.secondary),
        ),
        const SizedBox(height: 20),

        // Email
        CustomTextField(
          controller: _emailController,
          hintText: 'Email Address',
          svgIcon: 'assets/imageSvg/Vector (3).svg',
          fallbackIcon: Icons.email_outlined,
          keyboardType: TextInputType.emailAddress,
        ),
        const SizedBox(height: 16),

        // Password
        CustomTextField(
          controller: _passwordController,
          hintText: 'Password',
          svgIcon: 'assets/imageSvg/Vector.svg',
          fallbackIcon: Icons.lock_outline,
          isPassword: true,
          isPasswordVisible: _isPasswordVisible,
          onToggleVisibility: () {
            setState(() {
              _isPasswordVisible = !_isPasswordVisible;
            });
          },
        ),
        const SizedBox(height: 16),

        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                SizedBox(
                  height: 24,
                  width: 24,
                  child: Checkbox(
                    value: _rememberMe,
                    activeColor: theme.colorScheme.primary,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(4),
                    ),
                    side: BorderSide(
                      color: theme.colorScheme.primary,
                      width: 1.5,
                    ),
                    onChanged: (val) {
                      setState(() => _rememberMe = val ?? false);
                    },
                  ),
                ),
                const SizedBox(width: 8),
                Text(
                  'Remember Me',
                  style: TextStyle(
                    fontSize: 14,
                    color: theme.colorScheme.primary,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
            GestureDetector(
              onTap: widget.onForgotPassword,
              child: Text(
                'Forgot password ?',
                style: TextStyle(
                  fontSize: 13,
                  color: theme.colorScheme.secondary,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 24),

        // Primary Button
        PrimaryButton(
          text: 'LOGIN',
          isLoading: widget.isLoading,
          onPressed: () {
            widget.onLoginSubmit(
              _emailController.text.trim(),
              _passwordController.text.trim(),
              _rememberMe,
            );
          },
        ),
        const SizedBox(height: 16),

        // "or" Divider
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

        // Google Button
        OutlinedButton(
          onPressed: () {},
          style: OutlinedButton.styleFrom(
            side: BorderSide(color: theme.colorScheme.primary.withOpacity(0.3)),
            backgroundColor: theme.colorScheme.surface,
            padding: const EdgeInsets.symmetric(vertical: 14),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(14),
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Continue with Google',
                style: TextStyle(
                  color: theme.colorScheme.primary,
                  fontWeight: FontWeight.w600,
                  fontSize: 14,
                ),
              ),
              const SizedBox(width: 8),
              Icon(
                Icons.arrow_forward,
                size: 16,
                color: theme.colorScheme.primary,
              ),
            ],
          ),
        ),
        const SizedBox(height: 20),

        // Bottom Toggle Link
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Don't have any account ? ",
              style: TextStyle(
                color: theme.colorScheme.primary.withOpacity(0.7),
                fontSize: 14,
              ),
            ),
            GestureDetector(
              onTap: widget.onToggleToSignUp,
              child: Text(
                'Sign up',
                style: TextStyle(
                  color: theme.colorScheme.secondary,
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
