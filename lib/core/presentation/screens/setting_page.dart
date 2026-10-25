import 'package:ecosort/core/presentation/widgets/setting_group_card.dart';
import 'package:ecosort/core/presentation/widgets/setting_section_tile.dart';
import 'package:ecosort/core/presentation/widgets/setting_switch_tile.dart';
import 'package:ecosort/core/presentation/widgets/setting_tile.dart';
import 'package:flutter/material.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  bool _notificationsEnabled = true;
  bool _isDarkMode = false;

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

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: AppBar(
        title: const Text('Settings'),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        children: [
          // Section 1: Account
          const SettingsSectionTitle(title: 'Account'),
          SettingsGroupCard(
            children: [
              SettingsTile(
                icon: Icons.person_outline,
                title: 'Edit Profile',
                onTap: () {},
              ),
              const Divider(height: 1, indent: 56),
              SettingsTile(
                icon: Icons.lock_outline,
                title: 'Change Password',
                onTap: () {},
              ),
            ],
          ),

          const SizedBox(height: 24),

          // Section 2: Preferences
          const SettingsSectionTitle(title: 'Preferences'),
          SettingsGroupCard(
            children: [
              SettingsSwitchTile(
                icon: Icons.notifications_outlined,
                title: 'Push Notifications',
                value: _notificationsEnabled,
                onChanged: (val) {
                  setState(() => _notificationsEnabled = val);
                },
              ),
              const Divider(height: 1, indent: 56),
              SettingsSwitchTile(
                icon: Icons.dark_mode_outlined,
                title: 'Dark Mode',
                value: _isDarkMode,
                onChanged: (val) {
                  setState(() => _isDarkMode = val);
                },
              ),
            ],
          ),

          const SizedBox(height: 24),

          // Section 3: Legal & Info
          const SettingsSectionTitle(title: 'Legal & Info'),
          SettingsGroupCard(
            children: [
              SettingsTile(
                icon: Icons.privacy_tip_outlined,
                title: 'Privacy Policy',
                onTap: () {},
              ),
              const Divider(height: 1, indent: 56),
              SettingsTile(
                icon: Icons.description_outlined,
                title: 'Terms of Service',
                onTap: () {},
              ),
              const Divider(height: 1, indent: 56),
              SettingsTile(
                icon: Icons.info_outline,
                title: 'About App',
                onTap: () {},
              ),
            ],
          ),

          const SizedBox(height: 24),

          // Section 4: Action (Logout)
          SettingsGroupCard(
            children: [
              SettingsTile(
                icon: Icons.logout,
                title: 'Log Out',
                textColor: Colors.redAccent,
                iconColor: Colors.redAccent,
                onTap: _showLogoutDialog,
              ),
            ],
          ),
          const SizedBox(height: 40),
        ],
      ),
    );
  }
}
