import 'package:flutter/material.dart';
import 'theme/app_theme.dart';
import 'screens/login_screen.dart';
import 'screens/register_screen.dart';
import 'screens/password_forget_screen.dart';
import 'screens/form_screen.dart';
import 'screens/historique_screen.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:qr_flutter/qr_flutter.dart';

void main() {
  runApp(const MyApp());
}

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

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final text = Theme.of(context).textTheme;

    Widget buildScannerBody() {
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
        title: Text(
          'Akoele',
          style: text.headlineLarge?.copyWith(
            fontFamily: 'Oleo Script Swash Caps',
            color: scheme.primary,
          ),
        ),
      ),
      body: body,
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
            child: BottomNavigationBar(
              currentIndex: _index,
              onTap: (i) => setState(() => _index = i),
              backgroundColor: Colors.transparent,
              type: BottomNavigationBarType.fixed,
              selectedItemColor: scheme.onPrimary,
              unselectedItemColor: scheme.onPrimary.withOpacity(0.8),
              showUnselectedLabels: true,
              selectedLabelStyle: text.titleMedium?.copyWith(
                fontFamily: 'Oleo Script Swash Caps',
                color: scheme.onPrimary,
              ),
              unselectedLabelStyle: text.titleMedium?.copyWith(
                fontFamily: 'Oleo Script Swash Caps',
                color: scheme.onPrimary.withOpacity(0.8),
              ),
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
          ),
        ),
      ),
    );
  }
}
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    const bool isLoggedIn = false; // TODO: brancher la logique métier plus tard
    return MaterialApp(
      title: 'Akoele',
      theme: AppTheme.light,
      darkTheme: AppTheme.dark,
      themeMode: ThemeMode.system,
      // Use named routes for clearer navigation and to avoid dead code warnings
      initialRoute: isLoggedIn ? '/home' : '/login',
      routes: {
        '/login': (_) => const LoginScreen(),
        '/register': (_) => const RegisterScreen(),
        '/password_forget': (_) => const PasswordForgetScreen(),
        '/home': (_) => const HomeScreen(),
        '/qr_generate': (_) => const QrGeneratorScreen(),
        '/form': (ctx) {
          final arg = ModalRoute.of(ctx)?.settings.arguments as String?;
          return FormScreen(scannedValue: arg);
        },
      },
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  void _showSnackBar() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Text('This is a themed SnackBar'),
        behavior: SnackBarBehavior.floating,
        action: SnackBarAction(label: 'OK', onPressed: () {}),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final text = Theme.of(context).textTheme;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          widget.title,
          style: text.headlineLarge?.copyWith(
            fontFamily: 'Oleo Script Swash Caps',
            color: scheme.primary,
          ),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 12),
              Text(
                'Learn. Grow. Achieve.',
                style: text.titleMedium?.copyWith(color: scheme.onSurfaceVariant),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 32),
              Text(
                'Akoele',
                style: text.displaySmall?.copyWith(
                  fontFamily: 'Oleo Script Swash Caps',
                  fontSize: 56,
                  height: 1.1,
                  color: scheme.primary,
                  letterSpacing: 0.5,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 16),
              Text(
                'Your smart learning companion',
                style: text.bodyLarge?.copyWith(color: scheme.onSurfaceVariant),
                textAlign: TextAlign.center,
              ),
              const Spacer(),
              SizedBox(
                width: double.infinity,
                child: FilledButton(
                  onPressed: () {
                    Navigator.of(context).pushNamed('/login');
                  },
                  child: const Text('Get Started'),
                ),
              ),
              const SizedBox(height: 12),
              SizedBox(
                width: double.infinity,
                child: OutlinedButton(
                  onPressed: _showSnackBar,
                  child: const Text('I already have an account'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
 
