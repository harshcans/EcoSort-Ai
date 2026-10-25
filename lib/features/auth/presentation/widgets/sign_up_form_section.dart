import 'package:ecosort/features/auth/presentation/widgets/custom_text_field.dart';
import 'package:flutter/material.dart';

class SignUpFormSection extends StatelessWidget {
  final TextEditingController nameController;
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final TextEditingController confirmPasswordController;
  final bool isPasswordVisible;
  final bool isConfirmPasswordVisible;
  final VoidCallback onTogglePassword;
  final VoidCallback onToggleConfirmPassword;

  const SignUpFormSection({
    super.key,
    required this.nameController,
    required this.emailController,
    required this.passwordController,
    required this.confirmPasswordController,
    required this.isPasswordVisible,
    required this.isConfirmPasswordVisible,
    required this.onTogglePassword,
    required this.onToggleConfirmPassword,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Left-aligned purple title
        Text(
          'Create Account',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w700,
            color: Theme.of(context).colorScheme.secondary,
          ),
        ),
        const SizedBox(height: 14),

        // 1. Full name
        CustomTextField(
          controller: nameController,
          hintText: 'Full name',
          svgIcon: 'assets/imageSvg/Vector (3).svg',
          fallbackIcon: Icons.person_outline,
          keyboardType: TextInputType.name,
        ),
        const SizedBox(height: 12),

        // 2. Email Address
        CustomTextField(
          controller: emailController,
          hintText: 'Email Address',
          svgIcon: 'assets/imageSvg/Vector (3).svg',
          fallbackIcon: Icons.email_outlined,
          keyboardType: TextInputType.emailAddress,
        ),
        const SizedBox(height: 12),

        // 3. Password
        CustomTextField(
          controller: passwordController,
          hintText: 'Password',
          svgIcon: 'assets/imageSvg/Vector.svg',
          fallbackIcon: Icons.lock_outline,
          isPassword: true,
          isPasswordVisible: isPasswordVisible,
          onToggleVisibility: onTogglePassword,
        ),
        const SizedBox(height: 12),

        // 4. Confirm password
        CustomTextField(
          controller: confirmPasswordController,
          hintText: 'Confirm password',
          svgIcon: 'assets/imageSvg/Vector.svg',
          fallbackIcon: Icons.lock_outline,
          isPassword: true,
          isPasswordVisible: isConfirmPasswordVisible,
          onToggleVisibility: onToggleConfirmPassword,
        ),
      ],
    );
  }
}
