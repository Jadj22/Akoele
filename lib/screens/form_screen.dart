import 'package:flutter/material.dart';

class FormScreen extends StatefulWidget {
  const FormScreen({super.key, this.scannedValue});

  final String? scannedValue;

  @override
  State<FormScreen> createState() => _FormScreenState();
}

class _FormScreenState extends State<FormScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nom = TextEditingController();
  final _prenom = TextEditingController();
  final _contact = TextEditingController();
  final _societe = TextEditingController();
  final _objet = TextEditingController();

  @override
  void initState() {
    super.initState();
    // If QR carried a value, prefill the first field as an example.
    if (widget.scannedValue != null && widget.scannedValue!.isNotEmpty) {
      _objet.text = widget.scannedValue!;
    }
  }

  @override
  void dispose() {
    _nom.dispose();
    _prenom.dispose();
    _contact.dispose();
    _societe.dispose();
    _objet.dispose();
    super.dispose();
  }

  Widget _label(BuildContext context, String text, {bool required = false}) {
    final scheme = Theme.of(context).colorScheme;
    return Padding(
      padding: const EdgeInsets.only(top: 16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            text,
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontFamily: 'Oleo Script Swash Caps',
                  color: scheme.onSurface,
                ),
          ),
          if (required)
            const Padding(
              padding: EdgeInsets.only(left: 4),
              child: Text('*', style: TextStyle(color: Colors.red)),
            ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final text = Theme.of(context).textTheme;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: scheme.primary,
        foregroundColor: scheme.onPrimary,
        centerTitle: true,
        title: Text(
          'Formulaire',
          style: text.headlineSmall?.copyWith(
            fontFamily: 'Oleo Script Swash Caps',
          ),
        ),
      ),
      bottomNavigationBar: ClipRRect(
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(24),
          topRight: Radius.circular(24),
        ),
        child: Container(
          decoration: BoxDecoration(
            color: scheme.primary,
            border: Border(top: BorderSide(color: scheme.onSurface.withOpacity(0.2))),
          ),
          child: SafeArea(
            top: false,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(16, 10, 16, 6),
                  child: SizedBox(
                    width: double.infinity,
                    child: TextButton(
                      onPressed: () {
                        if (_formKey.currentState?.validate() ?? false) {
                          Navigator.of(context).pop({
                            'nom': _nom.text,
                            'prenom': _prenom.text,
                            'contact': _contact.text,
                            'societe': _societe.text,
                            'objet': _objet.text,
                          });
                        }
                      },
                      style: TextButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        backgroundColor: const Color(0xFFEFEFEF),
                        foregroundColor: Theme.of(context).colorScheme.onSurface,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                          side: BorderSide(color: Theme.of(context).colorScheme.onSurface.withOpacity(0.25)),
                        ),
                      ),
                      child: Text(
                        'Confirmer',
                        style: text.titleMedium?.copyWith(
                          fontFamily: 'Oleo Script Swash Caps',
                          fontSize: 20,
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 12),
              ],
            ),
          ),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
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
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 12),
                  _label(context, 'Nom', required: true),
                  const SizedBox(height: 2),
                  const SizedBox(height: 2),
                  TextFormField(
                    controller: _nom,
                    decoration: const InputDecoration(),
                    validator: (v) => (v == null || v.trim().isEmpty) ? 'Champ requis' : null,
                  ),
                  _label(context, 'Prenom', required: true),
                  TextFormField(
                    controller: _prenom,
                    decoration: const InputDecoration(),
                    validator: (v) => (v == null || v.trim().isEmpty) ? 'Champ requis' : null,
                  ),
                  _label(context, 'Telephone/mail', required: true),
                  TextFormField(
                    controller: _contact,
                    decoration: const InputDecoration(),
                    keyboardType: TextInputType.emailAddress,
                    validator: (v) => (v == null || v.trim().isEmpty) ? 'Champ requis' : null,
                  ),
                  _label(context, 'Société', required: true),
                  TextFormField(
                    controller: _societe,
                    decoration: const InputDecoration(),
                    validator: (v) => (v == null || v.trim().isEmpty) ? 'Champ requis' : null,
                  ),
                  _label(context, 'Objet de visite', required: true),
                  TextFormField(
                    controller: _objet,
                    decoration: const InputDecoration(),
                    validator: (v) => (v == null || v.trim().isEmpty) ? 'Champ requis' : null,
                  ),
                  const SizedBox(height: 120),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
