import 'package:flutter/material.dart';
import 'theme/app_theme.dart';

void main() {
  runApp(const MyApp());
}
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Akoele Theme Demo',
      theme: AppTheme.light,
      darkTheme: AppTheme.dark,
      themeMode: ThemeMode.system,
      home: const MyHomePage(title: 'Theme Samples'),
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
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final text = Theme.of(context).textTheme;
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // Text styles
          Text('Text Styles', style: text.titleLarge),
          const SizedBox(height: 8),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: scheme.surface,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: scheme.outline),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('displayLarge', style: text.displayLarge),
                Text('displayMedium', style: text.displayMedium),
                Text('displaySmall', style: text.displaySmall),
                Text('headlineLarge', style: text.headlineLarge),
                Text('headlineMedium', style: text.headlineMedium),
                Text('headlineSmall', style: text.headlineSmall),
                Text('titleLarge', style: text.titleLarge),
                Text('titleMedium', style: text.titleMedium),
                Text('titleSmall', style: text.titleSmall),
                Text('bodyLarge', style: text.bodyLarge),
                Text('bodyMedium', style: text.bodyMedium),
                Text('bodySmall', style: text.bodySmall),
                Text('labelLarge', style: text.labelLarge),
                Text('labelMedium', style: text.labelMedium),
                Text('labelSmall', style: text.labelSmall),
              ],
            ),
          ),
          const SizedBox(height: 24),

          // Buttons
          Text('Buttons', style: text.titleLarge),
          const SizedBox(height: 8),
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Wrap(
                spacing: 12,
                runSpacing: 12,
                children: [
                  ElevatedButton(onPressed: () {}, child: const Text('Elevated')),
                  FilledButton(onPressed: () {}, child: const Text('Filled')),
                  OutlinedButton(onPressed: () {}, child: const Text('Outlined')),
                  ElevatedButton(
                    onPressed: null,
                    child: const Text('Disabled'),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 24),

          // Inputs
          Text('Inputs', style: text.titleLarge),
          const SizedBox(height: 8),
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: const [
                  TextField(decoration: InputDecoration(labelText: 'Label', hintText: 'Hint text')),
                  SizedBox(height: 12),
                  TextField(decoration: InputDecoration(prefixIcon: Icon(Icons.search), hintText: 'Search')),
                ],
              ),
            ),
          ),
          const SizedBox(height: 24),

          // Chips
          Text('Chips', style: text.titleLarge),
          const SizedBox(height: 8),
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Wrap(
                spacing: 8,
                children: const [
                  Chip(label: Text('Default')),
                  Chip(avatar: CircleAvatar(child: Text('A')), label: Text('Avatar')),
                  Chip(label: Text('Selected')),
                ],
              ),
            ),
          ),
          const SizedBox(height: 24),

          // Card & Colors
          Text('Card & Colors', style: text.titleLarge),
          const SizedBox(height: 8),
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Primary', style: text.titleMedium?.copyWith(color: scheme.onPrimary)),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      _ColorSwatchBox(color: scheme.primary, label: 'primary'),
                      _ColorSwatchBox(color: scheme.secondary, label: 'secondary'),
                      _ColorSwatchBox(color: scheme.tertiary, label: 'tertiary'),
                      _ColorSwatchBox(color: scheme.error, label: 'error'),
                    ],
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 24),

          // Counter demo (for state & FAB)
          Text('Counter Demo', style: text.titleLarge),
          const SizedBox(height: 8),
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  Text('Count: ', style: text.titleMedium),
                  Text('$_counter', style: text.headlineMedium),
                ],
              ),
            ),
          ),
          const SizedBox(height: 80),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}

class _ColorSwatchBox extends StatelessWidget {
  final Color color;
  final String label;
  const _ColorSwatchBox({required this.color, required this.label});

  @override
  Widget build(BuildContext context) {
    final on = ThemeData.estimateBrightnessForColor(color) == Brightness.dark
        ? Colors.white
        : Colors.black;
    return Container(
      width: 72,
      height: 56,
      margin: const EdgeInsets.only(right: 8),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(8),
      ),
      alignment: Alignment.center,
      child: Text(label, style: TextStyle(color: on, fontWeight: FontWeight.w600)),
    );
  }
}
