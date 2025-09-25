import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'historique_screen.dart';
import 'profile_screen.dart';
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

  Widget _buildAnimatedCorner(double width, double height, {
    bool isTopRight = false,
    bool isBottomLeft = false,
    bool isBottomRight = false,
  }) {
    final scheme = Theme.of(context).colorScheme;
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: scheme.primary,
        borderRadius: BorderRadius.only(
          topLeft: isBottomRight ? Radius.zero : const Radius.circular(8),
          topRight: isBottomLeft ? Radius.zero : const Radius.circular(8),
          bottomLeft: isTopRight ? Radius.zero : const Radius.circular(8),
          bottomRight: isBottomRight ? Radius.zero : const Radius.circular(8),
        ),
      ),
    );
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
            // Enhanced scanner view
            Expanded(
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 4),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: scheme.shadow.withOpacity(0.3),
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
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
                                if (result != null && result is Map<String, String>) {
                                  setState(() {
                                    _historyItems.insert(0, {
                                      'date': DateTime.now().toString().substring(0, 16),
                                      'content': 'Formulaire soumis: ${result['nom']}, ${result['objet']}',
                                      'type': 'Form Submission'
                                    });
                                  });
                                }
                                _navigatingToForm = false;
                              });
                            }
                          }
                        },
                      ),

                      // Enhanced focus frame
                      IgnorePointer(
                        child: Center(
                          child: Container(
                            width: 240,
                            height: 240,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(
                                color: _isScanning ? scheme.primary : scheme.onSurface.withOpacity(0.5),
                                width: _isScanning ? 4 : 3,
                              ),
                              boxShadow: _isScanning ? [
                                BoxShadow(
                                  color: scheme.primary.withOpacity(0.3),
                                  blurRadius: 15,
                                  spreadRadius: 2,
                                ),
                              ] : null,
                            ),
                            child: Stack(
                              children: [
                                if (_isScanning) ...[
                                  Positioned(
                                    top: 0,
                                    left: 0,
                                    child: _buildAnimatedCorner(20, 20),
                                  ),
                                  Positioned(
                                    top: 0,
                                    right: 0,
                                    child: _buildAnimatedCorner(20, 20, isTopRight: true),
                                  ),
                                  Positioned(
                                    bottom: 0,
                                    left: 0,
                                    child: _buildAnimatedCorner(20, 20, isBottomLeft: true),
                                  ),
                                  Positioned(
                                    bottom: 0,
                                    right: 0,
                                    child: _buildAnimatedCorner(20, 20, isBottomRight: true),
                                  ),
                                ],

                                if (_isScanning)
                                  Center(
                                    child: Container(
                                      width: 200,
                                      height: 2,
                                      decoration: BoxDecoration(
                                        color: scheme.primary,
                                        boxShadow: [
                                          BoxShadow(
                                            color: scheme.primary.withOpacity(0.5),
                                            blurRadius: 8,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                              ],
                            ),
                          ),
                        ),
                      ),

                      // Status indicator
                      if (_isScanning)
                        Positioned(
                          top: 20,
                          right: 20,
                          child: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                            decoration: BoxDecoration(
                              color: scheme.primary.withOpacity(0.9),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Container(
                                  width: 8,
                                  height: 8,
                                  decoration: BoxDecoration(
                                    color: scheme.onPrimary,
                                    shape: BoxShape.circle,
                                  ),
                                ),
                                const SizedBox(width: 8),
                                Text(
                                  'Scanning...',
                                  style: text.bodySmall?.copyWith(
                                    color: scheme.onPrimary,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                    ],
                  ),
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

    // Titre dynamique selon l'écran sélectionné
    String getAppBarTitle() {
      switch (_index) {
        case 0:
          return 'Scanner';
        case 1:
          return 'Historique';
        case 2:
          return 'Favoris';
        case 3:
          return 'Profil';
        default:
          return 'Akoele';
      }
    }

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
        body = const ProfileScreen();
    }

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: scheme.primary,
        foregroundColor: scheme.onPrimary,
        title: Text(
          getAppBarTitle(),
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
