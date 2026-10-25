import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final String svgIcon;
  final IconData fallbackIcon;
  final bool isPassword;
  final bool isPasswordVisible;
  final VoidCallback? onToggleVisibility;
  final TextInputType keyboardType;

  const CustomTextField({
    super.key,
    required this.controller,
    required this.hintText,
    required this.svgIcon,
    required this.fallbackIcon,
    this.isPassword = false,
    this.isPasswordVisible = false,
    this.onToggleVisibility,
    this.keyboardType = TextInputType.text,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final inputTheme = theme.inputDecorationTheme;
    final iconColor = theme.colorScheme.primary;

    return TextFormField(
      controller: controller,
      obscureText: isPassword && !isPasswordVisible,
      keyboardType: keyboardType,
      style: TextStyle(
        color: theme.colorScheme.onSurface,
        fontSize: 14,
        fontWeight: FontWeight.w500,
      ),
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: inputTheme.hintStyle,
        filled: inputTheme.filled,
        fillColor: inputTheme.fillColor,
        contentPadding: inputTheme.contentPadding,
        border: inputTheme.border,
        enabledBorder: inputTheme.enabledBorder,
        focusedBorder: inputTheme.focusedBorder,
        prefixIcon: Padding(
          padding: const EdgeInsets.all(13.0),
          child: SvgPicture.asset(
            svgIcon,
            width: 18,
            height: 18,
            colorFilter: ColorFilter.mode(iconColor, BlendMode.srcIn),
          ),
        ),
        suffixIcon: isPassword
            ? IconButton(
                icon: Icon(
                  isPasswordVisible
                      ? Icons.visibility_off_outlined
                      : Icons.visibility_outlined,
                  color: iconColor,
                  size: 18,
                ),
                onPressed: onToggleVisibility,
              )
            : null,
      ),
    );
  }
}
