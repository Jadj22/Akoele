import 'package:flutter/material.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final text = Theme.of(context).textTheme;

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 40),

              // Avatar utilisateur
              Container(
                width: 100,
                height: 100,
                decoration: BoxDecoration(
                  color: scheme.primaryContainer,
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: scheme.primary,
                    width: 3,
                  ),
                ),
                child: Icon(
                  Icons.account_circle,
                  size: 60,
                  color: scheme.primary,
                ),
              ),

              const SizedBox(height: 24),

              // Informations utilisateur
              Text(
                'Utilisateur Connecté',
                style: text.headlineMedium?.copyWith(
                  fontFamily: 'Oleo Script Swash Caps',
                  color: scheme.primary,
                ),
              ),

              const SizedBox(height: 8),

              Text(
                'Bienvenue dans votre profil',
                style: text.bodyLarge?.copyWith(
                  color: scheme.onSurfaceVariant,
                ),
                textAlign: TextAlign.center,
              ),

              const SizedBox(height: 48),

              // Bouton de déconnexion
              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  onPressed: () {
                    // Naviguer vers l'écran de connexion et supprimer l'historique
                    Navigator.of(context).pushNamedAndRemoveUntil(
                      '/login',
                      (route) => false, // Supprimer toutes les routes précédentes
                    );
                  },
                  icon: const Icon(Icons.logout),
                  label: const Text('Se Déconnecter'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: scheme.error,
                    foregroundColor: scheme.onError,
                    padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    elevation: 2,
                  ),
                ),
              ),

              const SizedBox(height: 24),

              // Informations de version
              Text(
                'Version 1.0.0',
                style: text.bodySmall?.copyWith(
                  color: scheme.onSurfaceVariant,
                  fontStyle: FontStyle.italic,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
