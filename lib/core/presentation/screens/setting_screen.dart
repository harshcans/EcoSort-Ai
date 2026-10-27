import 'package:ecosort/core/presentation/widgets/setting_tile.dart';
import 'package:flutter/material.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  void _showLogoutDialog() {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Log Out'),
        content: const Text('Are you sure you want to log out?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(ctx);
              // TODO: AuthCubit logout call yahan aayega
            },
            child: const Text(
              'Log Out',
              style: TextStyle(color: Colors.redAccent),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  const SizedBox(width: 18),
                  Text(
                    'Settings',
                    style: TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.w800,
                      color: colorScheme.primary,
                      letterSpacing: 0.2,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 28),
              SettingsTile(
                icon: Icons.palette_outlined,
                title: 'Appearance',
                subtitle: 'Dark mode,theme',
                onTap: () {
                },
              ),
              SettingsTile(
                icon: Icons.language_rounded,
                title: 'Languages',
                subtitle: 'English',
                onTap: () {},
              ),
              SettingsTile(
                icon: Icons.help_outline_rounded,
                title: 'Help and support',
                subtitle: 'FAQs, Contact us',
                onTap: () {},
              ),
              SettingsTile(
                icon: Icons.shield_outlined,
                title: 'Privacy Settings',
                subtitle: 'Data and permissions',
                onTap: () {},
              ),
              SettingsTile(
                icon: Icons.info_outline_rounded,
                title: 'About Ecosort',
                subtitle: 'Description',
                onTap: () {},
              ),
              const SizedBox(height: 12),
              SettingsTile(
                icon: Icons.logout_rounded,
                title: 'Log Out',
                subtitle: 'Sign out of this session',
                iconColor: Colors.redAccent,
                textColor: Colors.redAccent,
                onTap: _showLogoutDialog,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
