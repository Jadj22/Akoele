import 'package:flutter/material.dart';
import 'reusable_bottom_navbar.dart';

/// Exemple d'utilisation du widget ReusableBottomNavbar dans un autre écran
class ExampleScreenWithNavbar extends StatefulWidget {
  const ExampleScreenWithNavbar({super.key});

  @override
  State<ExampleScreenWithNavbar> createState() => _ExampleScreenWithNavbarState();
}

class _ExampleScreenWithNavbarState extends State<ExampleScreenWithNavbar> {
  int _currentIndex = 0;

  // Liste des écrans pour cet exemple
  final List<Widget> _screens = [
    const Center(child: Text('Accueil', style: TextStyle(fontSize: 24))),
    const Center(child: Text('Recherche', style: TextStyle(fontSize: 24))),
    const Center(child: Text('Messages', style: TextStyle(fontSize: 24))),
    const Center(child: Text('Paramètres', style: TextStyle(fontSize: 24))),
  ];

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Exemple avec Navbar'),
        centerTitle: true,
      ),
      body: _screens[_currentIndex],
      bottomNavigationBar: ReusableBottomNavbar(
        currentIndex: _currentIndex,
        onTap: (index) => setState(() => _currentIndex = index),
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Accueil',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: 'Recherche',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.message),
            label: 'Messages',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Paramètres',
          ),
        ],
        // Personnalisation optionnelle
        backgroundColor: scheme.primary,
        selectedItemColor: scheme.onPrimary,
        unselectedItemColor: scheme.onPrimary.withOpacity(0.8),
      ),
    );
  }
}

/// Autre exemple avec une navbar personnalisée
class CustomNavbarExample extends StatefulWidget {
  const CustomNavbarExample({super.key});

  @override
  State<CustomNavbarExample> createState() => _CustomNavbarExampleState();
}

class _CustomNavbarExampleState extends State<CustomNavbarExample> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    final text = Theme.of(context).textTheme;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Navbar Personnalisée'),
        centerTitle: true,
      ),
      body: Center(
        child: Text(
          'Écran ${_currentIndex + 1}',
          style: text.headlineLarge,
        ),
      ),
      bottomNavigationBar: ReusableBottomNavbar(
        currentIndex: _currentIndex,
        onTap: (index) => setState(() => _currentIndex = index),
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.star),
            label: 'Favoris',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            label: 'Préférés',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.bookmark),
            label: 'Signets',
          ),
        ],
        // Personnalisation complète
        backgroundColor: Colors.purple,
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.white70,
        selectedLabelStyle: text.titleMedium?.copyWith(
          fontFamily: 'Oleo Script Swash Caps',
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),
        unselectedLabelStyle: text.titleMedium?.copyWith(
          fontFamily: 'Oleo Script Swash Caps',
          color: Colors.white70,
        ),
      ),
    );
  }
}
