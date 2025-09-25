import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

/// Simple QR generator screen using qr_flutter
class QrGeneratorScreen extends StatefulWidget {
  const QrGeneratorScreen({super.key});

  @override
  State<QrGeneratorScreen> createState() => _QrGeneratorScreenState();
}

class _QrGeneratorScreenState extends State<QrGeneratorScreen> {
  final _controller = TextEditingController(text: 'Akoele');

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final text = Theme.of(context).textTheme;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Générer un QR'),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            children: [
              TextField(
                controller: _controller,
                decoration: const InputDecoration(
                  labelText: 'Contenu',
                  hintText: 'Entrez le texte ou l’URL',
                ),
                onChanged: (_) => setState(() {}),
              ),
              const SizedBox(height: 24),
              Expanded(
                child: Center(
                  child: Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: scheme.surface,
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: scheme.outline),
                    ),
                    child: QrImageView(
                      data: _controller.text.isEmpty ? ' ' : _controller.text,
                      version: QrVersions.auto,
                      size: 220,
                      backgroundColor: scheme.surface,
                      eyeStyle: QrEyeStyle(eyeShape: QrEyeShape.square, color: scheme.onSurface),
                      dataModuleStyle: QrDataModuleStyle(dataModuleShape: QrDataModuleShape.square, color: scheme.onSurface),
                    ),
                  ),
                ),
              ),
              SizedBox(
                width: double.infinity,
                child: FilledButton(
                  onPressed: () {},
                  child: const Text('Partager / Enregistrer (à venir)'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
