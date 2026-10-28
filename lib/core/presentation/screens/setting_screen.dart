import 'package:ecosort/core/presentation/widgets/setting_tile.dart';
import 'package:ecosort/core/routes/app_routes.dart';
import 'package:ecosort/core/services/token_storage_service.dart';
import 'package:flutter/material.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  void _showLanguageDialog() {
    showDialog(
      context: context,
      builder: (ctx) {
        final theme = Theme.of(ctx);
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          title: const Row(
            children: [
              Icon(Icons.language_rounded, size: 24),
              SizedBox(width: 10),
              Text(
                'Language',
                style: TextStyle(fontWeight: FontWeight.w700, fontSize: 18),
              ),
            ],
          ),
          content: const Text(
            'Only English is available right now.',
            style: TextStyle(fontSize: 14),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(ctx),
              child: Text(
                'OK',
                style: TextStyle(
                  color: theme.colorScheme.primary,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  void _showHelpSupportDialog() {
    showDialog(
      context: context,
      builder: (ctx) {
        final theme = Theme.of(ctx);
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          title: const Row(
            children: [
              Icon(Icons.support_agent_rounded, size: 24),
              SizedBox(width: 10),
              Text(
                'Help & Support',
                style: TextStyle(fontWeight: FontWeight.w700, fontSize: 18),
              ),
            ],
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Have questions or need assistance? Reach out to our team:',
                style: TextStyle(fontSize: 13, color: Colors.black87),
              ),
              const SizedBox(height: 14),
              Row(
                children: [
                  Icon(
                    Icons.email_outlined,
                    size: 18,
                    color: theme.colorScheme.primary,
                  ),
                  const SizedBox(width: 8),
                  const Expanded(
                    child: SelectableText(
                      'officialnikhil71@gmail.com',
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 13,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  Icon(
                    Icons.alternate_email_rounded,
                    size: 18,
                    color: theme.colorScheme.primary,
                  ),
                  const SizedBox(width: 8),
                  const Expanded(
                    child: SelectableText(
                      'support@ecosort.ai',
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 13,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(ctx),
              child: Text(
                'Close',
                style: TextStyle(color: theme.colorScheme.primary),
              ),
            ),
          ],
        );
      },
    );
  }

  void _showPrivacyDialog() {
    showDialog(
      context: context,
      builder: (ctx) {
        final theme = Theme.of(ctx);
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          title: const Row(
            children: [
              Icon(Icons.shield_outlined, size: 24),
              SizedBox(width: 10),
              Text(
                'Privacy Policy',
                style: TextStyle(fontWeight: FontWeight.w700, fontSize: 18),
              ),
            ],
          ),
          content: const SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Data & Permissions',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                ),
                SizedBox(height: 6),
                Text(
                  'EcoSort only uses camera and gallery access to process images for waste classification. Your uploaded photos are securely evaluated and not shared with third parties.',
                  style: TextStyle(fontSize: 13, height: 1.4),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(ctx),
              child: Text(
                'Got It',
                style: TextStyle(
                  color: theme.colorScheme.primary,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  void _showAboutDialog() {
    showDialog(
      context: context,
      builder: (ctx) {
        final theme = Theme.of(ctx);
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          title: const Row(
            children: [
              Icon(Icons.eco_outlined, size: 24, color: Colors.green),
              SizedBox(width: 10),
              Text(
                'About EcoSort',
                style: TextStyle(fontWeight: FontWeight.w700, fontSize: 18),
              ),
            ],
          ),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'EcoSort is an intelligent waste classification application built to simplify recycling and promote sustainable waste management.',
                  style: TextStyle(fontSize: 13, height: 1.4),
                ),
                const SizedBox(height: 16),
                const Divider(),
                const SizedBox(height: 8),
                const Text(
                  'Project Team',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                ),
                const SizedBox(height: 10),
                _buildTeamMemberRow('Team manager', 'Ishan gupta'),
                _buildTeamMemberRow('App Developer', 'Nikhil Kumar'),
                _buildTeamMemberRow('UI/UX Design', 'Anshika Garg'),
                _buildTeamMemberRow('Backend Engineer', 'Harsh Singh'),
                _buildTeamMemberRow('ML Model', 'Pushkar Upadhyay'),
                _buildTeamMemberRow('Web Platform', 'Lovekush Kumar'),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(ctx),
              child: Text(
                'Close',
                style: TextStyle(
                  color: theme.colorScheme.primary,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  static Widget _buildTeamMemberRow(String role, String name) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 3.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 4,
            child: Text(
              role,
              style: const TextStyle(
                fontSize: 12,
                color: Colors.black54,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          const Text(': ', style: TextStyle(color: Colors.black54)),
          Expanded(
            flex: 5,
            child: Text(
              name,
              style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w700),
            ),
          ),
        ],
      ),
    );
  }

  void _showLogoutDialog() {
    showDialog(
      context: context,
      builder: (ctx) {
        final theme = Theme.of(ctx);
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          title: const Text(
            'Log Out',
            style: TextStyle(fontWeight: FontWeight.w700),
          ),
          content: const Text(
            'Are you sure you want to log out of your account?',
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(ctx),
              child: Text(
                'Cancel',
                style: TextStyle(color: theme.colorScheme.primary),
              ),
            ),
            TextButton(
              onPressed: () async {
                Navigator.pop(ctx);
                await TokenStorageService.clearTokens();
                if (mounted) {
                  Navigator.pushNamedAndRemoveUntil(
                    context,
                    AppRoutes.splash,
                    (route) => false,
                  );
                }
              },
              child: const Text(
                'Log Out',
                style: TextStyle(
                  color: Colors.redAccent,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        );
      },
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
                icon: Icons.language_rounded,
                title: 'Languages',
                subtitle: 'English',
                onTap: _showLanguageDialog,
              ),
              SettingsTile(
                icon: Icons.help_outline_rounded,
                title: 'Help and support',
                subtitle: 'FAQs, Contact us',
                onTap: _showHelpSupportDialog,
              ),
              SettingsTile(
                icon: Icons.shield_outlined,
                title: 'Privacy Settings',
                subtitle: 'Data and permissions',
                onTap: _showPrivacyDialog,
              ),
              SettingsTile(
                icon: Icons.info_outline_rounded,
                title: 'About EcoSort',
                subtitle: 'Description & team credits',
                onTap: _showAboutDialog,
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
