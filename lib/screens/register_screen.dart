import 'package:flutter/material.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  final _lastNameController = TextEditingController(); // Nom
  final _firstNameController = TextEditingController(); // Prénom
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _obscure = true;
  bool _acceptTerms = false;

  @override
  void dispose() {
    _lastNameController.dispose();
    _firstNameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _passwordController.dispose();
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
              // Header brand bar
              Container(
                padding: const EdgeInsets.fromLTRB(24, 28, 24, 28),
                decoration: BoxDecoration(color: scheme.primary),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      'Inscription',
                      style: text.headlineLarge?.copyWith(
                        fontFamily: 'Oleo Script Swash Caps',
                        color: scheme.onPrimary,
                      ),
                    ),
                  ],
                ),
              ),

              // Form section (underline style like mockup)
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
                        labelStyle: TextStyle(color: scheme.onSurface, fontStyle: FontStyle.italic, fontWeight: FontWeight.w700),
                        hintStyle: TextStyle(color: scheme.onSurface),
                        contentPadding: const EdgeInsets.symmetric(vertical: 8),
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Nom *', style: text.titleMedium?.copyWith(color: scheme.onSurface, fontStyle: FontStyle.italic, fontWeight: FontWeight.w700)),
                        TextFormField(
                          controller: _lastNameController,
                          textInputAction: TextInputAction.next,
                          decoration: const InputDecoration(),
                          validator: (v) => (v == null || v.isEmpty) ? 'Veuillez saisir votre nom' : null,
                        ),
                        const SizedBox(height: 16),

                        Text('Prénom *', style: text.titleMedium?.copyWith(color: scheme.onSurface, fontStyle: FontStyle.italic, fontWeight: FontWeight.w700)),
                        TextFormField(
                          controller: _firstNameController,
                          textInputAction: TextInputAction.next,
                          decoration: const InputDecoration(),
                          validator: (v) => (v == null || v.isEmpty) ? 'Veuillez saisir votre prénom' : null,
                        ),
                        const SizedBox(height: 16),

                        Text('Email *', style: text.titleMedium?.copyWith(color: scheme.onSurface, fontStyle: FontStyle.italic, fontWeight: FontWeight.w700)),
                        TextFormField(
                          controller: _emailController,
                          keyboardType: TextInputType.emailAddress,
                          textInputAction: TextInputAction.next,
                          decoration: const InputDecoration(),
                          validator: (v) {
                            if (v == null || v.isEmpty) return 'Veuillez saisir votre email';
                            final ok = RegExp(r"^[^@\s]+@[^@\s]+\.[^@\s]+$").hasMatch(v);
                            return ok ? null : 'Email invalide';
                          },
                        ),
                        const SizedBox(height: 16),

                        Text('Téléphone *', style: text.titleMedium?.copyWith(color: scheme.onSurface, fontStyle: FontStyle.italic, fontWeight: FontWeight.w700)),
                        TextFormField(
                          controller: _phoneController,
                          keyboardType: TextInputType.phone,
                          textInputAction: TextInputAction.next,
                          decoration: const InputDecoration(),
                          validator: (v) => (v == null || v.isEmpty) ? 'Veuillez saisir votre numéro' : null,
                        ),
                        const SizedBox(height: 16),

                        Text('Mot de passe *', style: text.titleMedium?.copyWith(color: scheme.onSurface, fontStyle: FontStyle.italic, fontWeight: FontWeight.w700)),
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

                        const SizedBox(height: 16),
                        Row(
                          children: [
                            Checkbox(
                              value: _acceptTerms,
                              onChanged: (v) => setState(() => _acceptTerms = v ?? false),
                            ),
                            Expanded(
                              child: Text(
                                "J'accepte les CGU et la politique de confidentialité",
                                style: text.bodySmall?.copyWith(color: scheme.onSurfaceVariant),
                              ),
                            ),
                          ],
                        ),

                        const SizedBox(height: 12),
                        Align(
                          alignment: Alignment.center,
                          child: SizedBox(
                            width: 220,
                            child: TextButton(
                              style: TextButton.styleFrom(
                                backgroundColor: scheme.surfaceContainerHighest,
                                foregroundColor: scheme.onSurface,
                                padding: const EdgeInsets.symmetric(vertical: 14),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                  side: BorderSide(color: scheme.primary),
                                ),
                              ),
                              onPressed: () {
                                if (!(_formKey.currentState?.validate() ?? false)) return;
                                if (!_acceptTerms) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(content: Text('Veuillez accepter les CGU')),
                                  );
                                  return;
                                }
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(content: Text('Inscription...')),
                                );
                              },
                              child: Text(
                                "S’inscrire",
                                style: text.titleMedium?.copyWith(fontFamily: 'Oleo Script Swash Caps', fontSize: 20),
                              ),
                            ),
                          ),
                        ),

                        const SizedBox(height: 16),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text('Déjà un compte ? ', style: text.bodyMedium?.copyWith(color: scheme.onSurface)),
                            TextButton(
                              onPressed: () => Navigator.pop(context),
                              child: Text('Se connecter', style: text.bodyMedium?.copyWith(color: scheme.primary)),
                            ),
                          ],
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

