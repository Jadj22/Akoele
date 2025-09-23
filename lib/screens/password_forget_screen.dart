import 'package:flutter/material.dart';

class PasswordForgetScreen extends StatefulWidget {
  const PasswordForgetScreen({super.key});

  @override
  State<PasswordForgetScreen> createState() => _PasswordForgetScreenState();
}

class _PasswordForgetScreenState extends State<PasswordForgetScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final text = Theme.of(context).textTheme;

    return Scaffold(
      backgroundColor: scheme.surface,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Header
              Container(
                padding: const EdgeInsets.fromLTRB(24, 28, 24, 28),
                color: scheme.primary,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      'Mot de passe oublié',
                      style: text.headlineLarge?.copyWith(
                        fontFamily: 'Oleo Script Swash Caps',
                        color: scheme.onPrimary,
                      ),
                    ),
                  ],
                ),
              ),

              // Body
              Padding(
                padding: const EdgeInsets.all(20),
                child: Form(
                  key: _formKey,
                  child: Theme(
                    data: Theme.of(context).copyWith(
                      inputDecorationTheme: InputDecorationTheme(
                        filled: false,
                        border: UnderlineInputBorder(
                          borderSide: BorderSide(color: scheme.onSurface),
                        ),
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: scheme.onSurface),
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: scheme.onSurface, width: 1.5),
                        ),
                        hintStyle: TextStyle(color: scheme.onSurface),
                        labelStyle: TextStyle(color: scheme.onSurface, fontStyle: FontStyle.italic, fontWeight: FontWeight.w700),
                        contentPadding: const EdgeInsets.symmetric(vertical: 8),
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Saisissez votre mail pour recevoir un lien de réinitialisation',
                          style: text.bodyLarge?.copyWith(
                            color: scheme.onSurface,
                            fontStyle: FontStyle.italic,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        const SizedBox(height: 24),

                        Text('Email:', style: text.titleMedium?.copyWith(color: scheme.onSurface, fontStyle: FontStyle.italic, fontWeight: FontWeight.w700)),
                        TextFormField(
                          controller: _emailController,
                          keyboardType: TextInputType.emailAddress,
                          decoration: const InputDecoration(),
                          validator: (v) {
                            if (v == null || v.isEmpty) return 'Veuillez saisir votre email';
                            final ok = RegExp(r"^[^@\s]+@[^@\s]+\.[^@\s]+$").hasMatch(v);
                            return ok ? null : 'Email invalide';
                          },
                        ),

                        const SizedBox(height: 40),
                        // Se connecter button (primary, grey background as in mock)
                        Align(
                          alignment: Alignment.center,
                          child: SizedBox(
                            width: 220,
                            child: TextButton(
                              style: TextButton.styleFrom(
                                backgroundColor: scheme.surfaceContainerHighest,
                                foregroundColor: scheme.onSurface,
                                padding: const EdgeInsets.symmetric(vertical: 14),
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                              ),
                              onPressed: () {
                                if (_formKey.currentState?.validate() ?? false) {
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(const SnackBar(content: Text('Lien envoyé')))
                                      .closed
                                      .whenComplete(() {
                                    Navigator.of(context).pushReplacementNamed('/login');
                                  });
                                }
                              },
                              child: Text(
                                'Se connecter',
                                style: text.titleMedium?.copyWith(fontFamily: 'Oleo Script Swash Caps', fontSize: 20),
                              ),
                            ),
                          ),
                        ),

                        const SizedBox(height: 28),
                        Row(
                          children: [
                            Expanded(child: Divider(color: scheme.onSurface)),
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 8.0),
                              child: Text('ou', style: TextStyle(color: scheme.onSurface)),
                            ),
                            Expanded(child: Divider(color: scheme.onSurface)),
                          ],
                        ),

                        const SizedBox(height: 28),
                        Center(
                          child: TextButton(
                            onPressed: () {
                              Navigator.of(context).pushNamed('/register');
                            },
                            child: Text(
                              "S’inscrire",
                              style: text.titleLarge?.copyWith(
                                fontFamily: 'Oleo Script Swash Caps',
                                color: scheme.primary,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

