import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'historique_screen.dart';
import '../widgets/reusable_bottom_navbar.dart';

/// HomeScreen with bottom navigation styled per interface mock
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _index = 0;
  final MobileScannerController _scannerController = MobileScannerController(autoStart: false);
  Barcode? _lastBarcode;
  bool _torchOn = false;
  bool _isScanning = false; // local mirrored state
  bool _navigatingToForm = false;
  final List<Map<String, String>> _historyItems = [
    {
      'date': '2023-10-15 14:30',
      'content': 'QR Code scanné: https://example.com',
      'type': 'QR Scan'
    },
    {
      'date': '2023-10-14 10:15',
      'content': 'Formulaire soumis: John Doe, Visite entreprise',
      'type': 'Form Submission'
    },
  ];

  @override
  void initState() {
    super.initState();
    // Removed listener to deprecated controller.state; we'll manage _isScanning locally.
  }

  @override
  void dispose() {
    _scannerController.dispose();
    super.dispose();
  }

  Widget buildScannerBody() {
    final scheme = Theme.of(context).colorScheme;
    final text = Theme.of(context).textTheme;

    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 8),
            Text(
              'Scanner pour vous enregistrer',
              style: text.titleLarge?.copyWith(
                fontFamily: 'Oleo Script Swash Caps',
                color: scheme.onSurface,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 24),
            // Real scanner view
            Expanded(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: Stack(
                  children: [
                    MobileScanner(
                      controller: _scannerController,
                      onDetect: (capture) {
                        final codes = capture.barcodes;
                        if (codes.isNotEmpty && !_navigatingToForm) {
                          final value = codes.first.displayValue ?? codes.first.rawValue ?? '';
                          setState(() => _lastBarcode = codes.first);
                          _navigatingToForm = true;
                          _scannerController.stop();
                          _isScanning = false;
                          // Add to history
                          setState(() {
                            _historyItems.insert(0, {
                              'date': DateTime.now().toString().substring(0, 16),
                              'content': 'QR Code scanné: $value',
                              'type': 'QR Scan'
                            });
                          });
                          if (mounted) {
                            Navigator.of(context).pushNamed(
                              '/form',
                              arguments: value,
                            ).then((result) {
                              // Handle form submission result
                              if (result != null && result is Map<String, String>) {
                                setState(() {
                                  _historyItems.insert(0, {
                                    'date': DateTime.now().toString().substring(0, 16),
                                    'content': 'Formulaire soumis: ${result['nom']}, ${result['objet']}',
                                    'type': 'Form Submission'
                                  });
                                });
                              }
                              // Allow scanning again when returning
                              _navigatingToForm = false;
                            });
                          }
                        }
                      },
                    ),
                    // Simple focus frame overlay
                    IgnorePointer(
                      child: Center(
                        child: Container(
                          width: 220,
                          height: 220,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(16),
                            border: Border.all(color: scheme.onSurface, width: 3),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 8),
            SizedBox(
              width: 260,
              child: TextButton(
                style: TextButton.styleFrom(
                  backgroundColor: scheme.surfaceContainerHighest,
                  foregroundColor: scheme.onSurface,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                ),
                onPressed: () async {
                  if (_isScanning) {
                    await _scannerController.stop();
                    if (mounted) setState(() => _isScanning = false);
                  } else {
                    await _scannerController.start();
                    if (mounted) setState(() => _isScanning = true);
                  }
                },
                child: Text(
                  _isScanning ? 'Arrêter' : 'Scanner',
                  style: text.titleMedium?.copyWith(
                    fontFamily: 'Oleo Script Swash Caps',
                    fontSize: 20,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 12),
            if (_lastBarcode != null)
              Text(
                'Dernier code: ${_lastBarcode!.displayValue ?? _lastBarcode!.rawValue ?? ''}',
                style: text.bodyMedium,
                textAlign: TextAlign.center,
              ),
            const SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  tooltip: 'Torch',
                  onPressed: () async {
                    await _scannerController.toggleTorch();
                    if (mounted) setState(() => _torchOn = !_torchOn);
                  },
                  icon: Icon(_torchOn ? Icons.flash_on : Icons.flash_off),
                ),
                const SizedBox(width: 16),
                IconButton(
                  tooltip: 'Inverser caméra',
                  onPressed: () => _scannerController.switchCamera(),
                  icon: const Icon(Icons.cameraswitch),
                ),
                const SizedBox(width: 16),
                OutlinedButton(
                  onPressed: () => Navigator.of(context).pushNamed('/qr_generate'),
                  child: const Text('Générer QR'),
                ),
              ],
            ),
            const SizedBox(height: 16),
            // Test button to open the form screen directly without scanning
            SizedBox(
              width: 260,
              child: OutlinedButton(
                onPressed: () => Navigator.of(context).pushNamed('/form'),
                child: const Text('Ouvrir Formulaire (test)'),
              ),
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final text = Theme.of(context).textTheme;

    Widget body;
    switch (_index) {
      case 0:
        body = buildScannerBody();
        break;
      case 1:
        body = HistoriqueScreen(historyItems: _historyItems);
        break;
      case 2:
        body = const Center(child: Text('Favoris'));
        break;
      case 3:
      default:
        body = const Center(child: Text('Profil'));
    }

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: scheme.primary,
        foregroundColor: scheme.onPrimary,
        title: Text(
          'Akoele',
          style: text.headlineLarge?.copyWith(
            fontFamily: 'Oleo Script Swash Caps',
            color: scheme.onPrimary,
          ),
        ),
      ),
      body: body,
      bottomNavigationBar: ReusableBottomNavbar(
        currentIndex: _index,
        onTap: (i) => setState(() => _index = i),
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.qr_code_scanner),
            label: 'Scanner',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.receipt_long),
            label: 'Historique',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.bookmark_border),
            label: 'Favoris',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_circle_outlined),
            label: 'Profil',
          ),
        ],
      ),
    );
  }
}
