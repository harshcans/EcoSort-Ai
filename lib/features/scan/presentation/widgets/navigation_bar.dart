// import 'package:ecosort/features/scan/presentation/screens/scan_screen.dart';
import 'package:flutter/material.dart';
import '../screens/home_screen.dart';

class MainNavigationShell extends StatefulWidget {
  const MainNavigationShell({super.key});

  @override
  State<MainNavigationShell> createState() => _MainNavigationShellState();
}

class _MainNavigationShellState extends State<MainNavigationShell> {
  int _currentIndex = 0;

  // Chaaro tabs ki screens list
  final List<Widget> _screens = const [
    HomeScreen(),
    Center(child: Text('Stats Screen')),
    Center(child: Text('Stats Screen')),

    Center(child: Text('Settings Screen')),
  ];

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      body: IndexedStack(index: _currentIndex, children: _screens),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: colorScheme.surface,
          border: Border(
            top: BorderSide(
              color: colorScheme.primary.withOpacity(0.18),
              width: 1.0,
            ),
          ),
        ),
        child: SafeArea(
          top: false,
          child: SizedBox(
            height: 62,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildNavItem(
                  index: 0,
                  label: 'Home',
                  icon: Icons.home_rounded,
                  activeColor: colorScheme.primary,
                  inactiveColor: colorScheme.primary.withOpacity(0.5),
                ),
                _buildNavItem(
                  index: 1,
                  label: 'History',
                  icon: Icons.access_time_rounded,
                  activeColor: colorScheme.primary,
                  inactiveColor: colorScheme.primary.withOpacity(0.5),
                ),
                _buildNavItem(
                  index: 2,
                  label: 'Info',
                  icon: Icons.bar_chart_rounded,
                  activeColor: colorScheme.primary,
                  inactiveColor: colorScheme.primary.withOpacity(0.5),
                ),
                _buildNavItem(
                  index: 3,
                  label: 'Settings',
                  icon: Icons.settings_outlined,
                  activeColor: colorScheme.primary,
                  inactiveColor: colorScheme.primary.withOpacity(0.5),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildNavItem({
    required int index,
    required String label,
    required IconData icon,
    required Color activeColor,
    required Color inactiveColor,
  }) {
    final bool isSelected = _currentIndex == index;
    final Color itemColor = isSelected ? activeColor : inactiveColor;

    return Expanded(
      child: InkWell(
        onTap: () {
          setState(() {
            _currentIndex = index;
          });
        },
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 30, color: itemColor),
            const SizedBox(height: 3),
            Text(
              label,
              style: TextStyle(
                fontSize: 11,
                fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
                color: itemColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
