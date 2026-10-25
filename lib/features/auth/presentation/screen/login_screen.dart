import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/presentation/widgets/primary_button.dart';
import '../../../../core/routes/app_routes.dart';
import '../../logic/auth_cubit.dart';
import '../../logic/auth_state.dart';
import '../widgets/auth_bottom_art.dart';
import '../widgets/auth_brand_header.dart';
import '../widgets/forgot_password_section.dart';
import '../widgets/login_form_section.dart';
import '../widgets/sign_up_form_section.dart';

// 3 Screens ka Mode
enum AuthMode { login, signUp, forgotPassword }

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  // Shuruat Login Screen se hogi
  AuthMode _currentMode = AuthMode.login;

  // Sign Up Controllers
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _signUpEmailController = TextEditingController(
    text: 'test@ecosort.com',
  );
  final TextEditingController _signUpPasswordController = TextEditingController(
    text: '123456',
  );
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  bool _isPasswordVisible = false;
  bool _isConfirmPasswordVisible = false;

  @override
  void dispose() {
    _nameController.dispose();
    _signUpEmailController.dispose();
    _signUpPasswordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  void _submitSignUp() {
    final name = _nameController.text.trim();
    final email = _signUpEmailController.text.trim();
    final password = _signUpPasswordController.text.trim();
    final confirmPassword = _confirmPasswordController.text.trim();

    if (name.isEmpty ||
        email.isEmpty ||
        password.isEmpty ||
        confirmPassword.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please fill all required fields')),
      );
      return;
    }

    if (password != confirmPassword) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Passwords do not match')));
      return;
    }

    context.read<AuthCubit>().signUp(
      name: name,
      email: email,
      password: password,
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      resizeToAvoidBottomInset: true,
      bottomNavigationBar: SafeArea(top: false, child: const AuthBottomArt()),
      body: SafeArea(
        child: BlocConsumer<AuthCubit, AuthState>(
          listener: (context, state) {
            if (state is AuthAuthenticated) {
              Navigator.pushReplacementNamed(context, AppRoutes.home);
            } else if (state is AuthError) {
              ScaffoldMessenger.of(
                context,
              ).showSnackBar(SnackBar(content: Text(state.message)));
            }       
          },
          builder: (context, state) {
            final isLoading = state is AuthLoading;

            return SingleChildScrollView(
              keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // Common Brand Header
                  AuthBrandHeader(
                    onBack: () {
                      if (_currentMode != AuthMode.login) {
                        setState(() => _currentMode = AuthMode.login);
                      } else if (Navigator.canPop(context)) {
                        Navigator.pop(context);
                      }
                    },
                  ),

                  const SizedBox(height: 24),

                  // 1. LOGIN SECTION
                  if (_currentMode == AuthMode.login)
                    LoginFormSection(
                      isLoading: isLoading,
                      onToggleToSignUp: () {
                        setState(() => _currentMode = AuthMode.signUp);
                      },
                      onForgotPassword: () {
                        setState(() => _currentMode = AuthMode.forgotPassword);
                      },
                      onLoginSubmit: (email, password, rememberMe) {
                        context.read<AuthCubit>().login(
                          email: email,
                          password: password,
                        );
                      },
                    )
                  // 2. FORGOT PASSWORD SECTION
                  else if (_currentMode == AuthMode.forgotPassword)
                    ForgotPasswordSection(
                      isLoading: isLoading,
                      onBackToLogin: () {
                        setState(() => _currentMode = AuthMode.login);
                      },
                      onSendOtp: (email) {
                        // Abhi OTP ko goli mar, bas print ya notification check kar le
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('OTP sent to $email')),
                        );
                      },
                    )
                  // 3. SIGN UP SECTION
                  else if (_currentMode == AuthMode.signUp) ...[
                    SignUpFormSection(
                      nameController: _nameController,
                      emailController: _signUpEmailController,
                      passwordController: _signUpPasswordController,
                      confirmPasswordController: _confirmPasswordController,
                      isPasswordVisible: _isPasswordVisible,
                      isConfirmPasswordVisible: _isConfirmPasswordVisible,
                      onTogglePassword: () {
                        setState(() {
                          _isPasswordVisible = !_isPasswordVisible;
                        });
                      },
                      onToggleConfirmPassword: () {
                        setState(() {
                          _isConfirmPasswordVisible =
                              !_isConfirmPasswordVisible;
                        });
                      },
                    ),
                    const SizedBox(height: 24),

                    PrimaryButton(
                      text: 'Create Account',
                      isLoading: isLoading,
                      onPressed: _submitSignUp,
                    ),
                    const SizedBox(height: 28),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Already have an account? ',
                          style: TextStyle(
                            color: theme.colorScheme.onSurface.withOpacity(0.8),
                            fontSize: 14,
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            setState(() => _currentMode = AuthMode.login);
                          },
                          child: Text(
                            'Log in',
                            style: TextStyle(
                              color: theme.colorScheme.primary,
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],

                  const SizedBox(height: 24),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
