import 'package:flutter/material.dart';
import 'register_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _obscure = true;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final text = Theme.of(context).textTheme;

    return Scaffold(
      backgroundColor: scheme.surface,
      appBar: AppBar(
        backgroundColor: scheme.primary,
        foregroundColor: scheme.onPrimary,
        centerTitle: true,
        title: Text(
          'Connexion',
          style: text.headlineSmall?.copyWith(
            fontFamily: 'Oleo Script Swash Caps',
          ),
        ),
        elevation: 0,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
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
                  labelStyle: TextStyle(color: scheme.onSurface, fontStyle: FontStyle.italic, fontWeight: FontWeight.w700),
                  hintStyle: TextStyle(color: scheme.onSurface),
                  contentPadding: const EdgeInsets.symmetric(vertical: 8),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 12),
                  // Email
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
                  const SizedBox(height: 24),
                  // Password
                  Text('Mot de passe:', style: text.titleMedium?.copyWith(color: scheme.onSurface, fontStyle: FontStyle.italic, fontWeight: FontWeight.w700)),
                  TextFormField(
                    controller: _passwordController,
                    obscureText: _obscure,
                    decoration: InputDecoration(
                      suffixIcon: IconButton(
                        onPressed: () => setState(() => _obscure = !_obscure),
                        icon: Icon(_obscure ? Icons.visibility_off_outlined : Icons.visibility_outlined, color: scheme.onSurfaceVariant),
                      ),
                    ),
                    validator: (v) => (v == null || v.length < 6) ? '6 caractères minimum' : null,
                  ),

                  const SizedBox(height: 40),
                  // Primary login button centered, grey DDDDDD with black text
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
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text('Connexion...')),
                            ).closed.whenComplete(() {
                              Navigator.of(context).pushReplacementNamed('/home');
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
                        child: Text('OU', style: TextStyle(color: scheme.onSurface)),
                      ),
                      Expanded(child: Divider(color: scheme.onSurface)),
                    ],
                  ),

                  const SizedBox(height: 28),
                  Center(
                    child: TextButton(
                      onPressed: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(builder: (_) => const RegisterScreen()),
                        );
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
      ),
    );
  }
}

