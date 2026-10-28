import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/presentation/widgets/primary_button.dart';
import '../../../../core/routes/app_routes.dart';
import '../../logic/auth_cubit.dart';
import '../../logic/auth_state.dart';
import '../widgets/auth_bottom_art.dart';
import '../widgets/auth_brand_header.dart';
import '../widgets/login_form_section.dart';
import '../widgets/sign_up_form_section.dart';

enum AuthMode { login, signUp }

class AuthScreen extends StatefulWidget {
  final AuthMode initialMode;

  const AuthScreen({super.key, this.initialMode = AuthMode.login});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  late AuthMode _currentMode;

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _signUpEmailController = TextEditingController();
  final TextEditingController _signUpPasswordController =
      TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  bool _isPasswordVisible = false;
  bool _isConfirmPasswordVisible = false;

  @override
  void initState() {
    super.initState();
    _currentMode = widget.initialMode;
  }

  @override
  void dispose() {
    _nameController.dispose();
    _signUpEmailController.dispose();
    _signUpPasswordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  void _submitSignUp() async {
    final name = _nameController.text.trim();
    final email = _signUpEmailController.text.trim();
    final password = _signUpPasswordController.text.trim();
    final confirmPassword = _confirmPasswordController.text.trim();

    if (name.isEmpty ||
        email.isEmpty ||
        password.isEmpty ||
        confirmPassword.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please fill all required fields'),
          behavior: SnackBarBehavior.floating,
        ),
      );
      return;
    }

    if (password != confirmPassword) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Passwords do not match'),
          behavior: SnackBarBehavior.floating,
        ),
      );
      return;
    }

    await context.read<AuthCubit>().signUp(
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
      bottomNavigationBar: const SafeArea(top: false, child: AuthBottomArt()),
      body: SafeArea(
        child: BlocConsumer<AuthCubit, AuthState>(
          listener: (context, state) {
            if (state is AuthAuthenticated) {
              Navigator.pushReplacementNamed(context, AppRoutes.home);
            } else if (state is AuthError) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(state.message),
                  backgroundColor: Colors.redAccent,
                  behavior: SnackBarBehavior.floating,
                ),
              );
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
                  AuthBrandHeader(
                    onBack: () {
                      if (widget.initialMode == AuthMode.signUp) {
                        if (Navigator.canPop(context)) {
                          Navigator.pop(context);
                        }
                      } else {
                        if (_currentMode != AuthMode.login) {
                          setState(() => _currentMode = AuthMode.login);
                        } else if (Navigator.canPop(context)) {
                          Navigator.pop(context);
                        }
                      }
                    },
                  ),
                  const SizedBox(height: 24),

                  if (_currentMode == AuthMode.login)
                    LoginFormSection(
                      isLoading: isLoading,
                      onToggleToSignUp: () {
                        setState(() => _currentMode = AuthMode.signUp);
                      },
                      onLoginSubmit: (email, password, rememberMe) {
                        context.read<AuthCubit>().login(
                          email: email,
                          password: password,
                        );
                      },
                    )
                  else if (_currentMode == AuthMode.signUp) ...[
                    SignUpFormSection(
                      nameController: _nameController,
                      emailController: _signUpEmailController,
                      passwordController: _signUpPasswordController,
                      confirmPasswordController: _confirmPasswordController,
                      isPasswordVisible: _isPasswordVisible,
                      isConfirmPasswordVisible: _isConfirmPasswordVisible,
                      onTogglePassword: () {
                        setState(
                          () => _isPasswordVisible = !_isPasswordVisible,
                        );
                      },
                      onToggleConfirmPassword: () {
                        setState(
                          () => _isConfirmPasswordVisible =
                              !_isConfirmPasswordVisible,
                        );
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
