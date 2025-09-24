import 'package:flutter/material.dart';

class HistoriqueScreen extends StatefulWidget {
  const HistoriqueScreen({super.key, required this.historyItems});

  final List<Map<String, String>> historyItems;

  @override
  State<HistoriqueScreen> createState() => _HistoriqueScreenState();
}

class _HistoriqueScreenState extends State<HistoriqueScreen> {
  void _deleteItem(int index) {
    setState(() {
      widget.historyItems.removeAt(index);
    });
  }

  void _viewItem(int index) {
    final item = widget.historyItems[index];
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(item['type']!),
        content: Text(item['content']!),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(),
            child: const Text('Fermer'),
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
          'Historique',
          style: text.headlineSmall?.copyWith(
            fontFamily: 'Oleo Script Swash Caps',
          ),
        ),
      ),
      body: SafeArea(
        child: widget.historyItems.isEmpty
            ? Center(
                child: Text(
                  'Aucun historique disponible',
                  style: text.bodyLarge?.copyWith(color: scheme.onSurfaceVariant),
                ),
              )
            : ListView.builder(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                itemCount: widget.historyItems.length,
                itemBuilder: (ctx, index) {
                  final item = widget.historyItems[index];
                  return Card(
                    margin: const EdgeInsets.only(bottom: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Row(
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  item['type']!,
                                  style: text.titleMedium?.copyWith(
                                    fontFamily: 'Oleo Script Swash Caps',
                                    color: scheme.primary,
                                  ),
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  item['content']!,
                                  style: text.bodyMedium?.copyWith(
                                    color: scheme.onSurface,
                                  ),
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  item['date']!,
                                  style: text.bodySmall?.copyWith(
                                    color: scheme.onSurfaceVariant,
                                    fontStyle: FontStyle.italic,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(width: 16),
                          Column(
                            children: [
                              IconButton(
                                onPressed: () => _viewItem(index),
                                icon: Icon(
                                  Icons.visibility,
                                  color: scheme.primary,
                                ),
                                tooltip: 'Voir détails',
                              ),
                              IconButton(
                                onPressed: () => _deleteItem(index),
                                icon: Icon(
                                  Icons.delete,
                                  color: scheme.error,
                                ),
                                tooltip: 'Supprimer',
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
      ),
    );
  }
}
