import 'package:flutter/material.dart';
import '../../../../core/presentation/widgets/primary_button.dart';
import 'custom_text_field.dart';

class LoginFormSection extends StatefulWidget {
  final VoidCallback onToggleToSignUp;
  final Function(String email, String password, bool rememberMe) onLoginSubmit;
  final bool isLoading;

  const LoginFormSection({
    super.key,
    required this.onToggleToSignUp,
    required this.onLoginSubmit,
    this.isLoading = false,
  });

  @override
  State<LoginFormSection> createState() => _LoginFormSectionState();
}

class _LoginFormSectionState extends State<LoginFormSection> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
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

        CustomTextField(
          controller: _emailController,
          hintText: 'Email Address',
          svgIcon: 'assets/imageSvg/Vector (3).svg',
          fallbackIcon: Icons.email_outlined,
          keyboardType: TextInputType.emailAddress,
        ),
        const SizedBox(height: 16),

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
                side: BorderSide(color: theme.colorScheme.primary, width: 1.5),
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
        const SizedBox(height: 24),

        PrimaryButton(
          text: 'LOGIN',
          isLoading: widget.isLoading,
          onPressed: () {
            final email = _emailController.text.trim();
            final password = _passwordController.text.trim();

            if (email.isEmpty || password.isEmpty) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Please enter your email and password'),
                  behavior: SnackBarBehavior.floating,
                ),
              );
              return;
            }

            widget.onLoginSubmit(email, password, _rememberMe);
          },
        ),

        const SizedBox(height: 18),

        const SizedBox(height: 20),

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
