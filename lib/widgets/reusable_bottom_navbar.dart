import 'package:flutter/material.dart';

/// Widget réutilisable pour une bottom navigation bar stylisée
class ReusableBottomNavbar extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTap;
  final List<BottomNavigationBarItem> items;
  final Color? backgroundColor;
  final Color? selectedItemColor;
  final Color? unselectedItemColor;
  final TextStyle? selectedLabelStyle;
  final TextStyle? unselectedLabelStyle;

  const ReusableBottomNavbar({
    super.key,
    required this.currentIndex,
    required this.onTap,
    required this.items,
    this.backgroundColor,
    this.selectedItemColor,
    this.unselectedItemColor,
    this.selectedLabelStyle,
    this.unselectedLabelStyle,
  });

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final text = Theme.of(context).textTheme;

    return ClipRRect(
      child: Container(
        decoration: BoxDecoration(
          color: backgroundColor ?? scheme.primary,
          border: Border(top: BorderSide(color: scheme.onSurface.withOpacity(0.2))),
        ),
        child: SafeArea(
          top: false,
          child: BottomNavigationBar(
            currentIndex: currentIndex,
            onTap: onTap,
            backgroundColor: Colors.transparent,
            type: BottomNavigationBarType.fixed,
            selectedItemColor: selectedItemColor ?? scheme.onPrimary,
            unselectedItemColor: unselectedItemColor ?? scheme.onPrimary.withOpacity(0.8),
            showUnselectedLabels: true,
            selectedLabelStyle: selectedLabelStyle ?? text.titleMedium?.copyWith(
              fontFamily: 'Oleo Script Swash Caps',
              color: scheme.onPrimary,
            ),
            unselectedLabelStyle: unselectedLabelStyle ?? text.titleMedium?.copyWith(
              fontFamily: 'Oleo Script Swash Caps',
              color: scheme.onPrimary.withOpacity(0.8),
            ),
            items: items,
          ),
        ),
      ),
    );
  }
}
