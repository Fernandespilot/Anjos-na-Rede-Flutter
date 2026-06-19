import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

class AcompanharScreen extends StatefulWidget {
  const AcompanharScreen({super.key});
  @override
  State<AcompanharScreen> createState() => _AcompanharScreenState();
}

class _AcompanharScreenState extends State<AcompanharScreen> {
  final _controller = TextEditingController();
  bool _searched = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(title: const Text('Acompanhar Denúncia')),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Icon(Icons.manage_search, size: 48, color: AppColors.primary),
            const SizedBox(height: 12),
            Text('Digite seu protocolo', style: Theme.of(context).textTheme.headlineMedium),
            const SizedBox(height: 20),
            TextField(
              controller: _controller,
              decoration: const InputDecoration(
                hintText: 'Ex: ANJ1234567',
                prefixIcon: Icon(Icons.receipt_long),
              ),
            ),
            const SizedBox(height: 16),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () => setState(() => _searched = true),
                child: const Text('Buscar'),
              ),
            ),
            if (_searched) ...[
              const SizedBox(height: 32),
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [BoxShadow(color: Colors.black.withValues(alpha: 0.05), blurRadius: 8)],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        const Icon(Icons.check_circle, color: AppColors.safetyGreen),
                        const SizedBox(width: 8),
                        Text('Protocolo encontrado',
                            style: Theme.of(context).textTheme.labelLarge),
                      ],
                    ),
                    const Divider(height: 24),
                    _StatusRow('Recebido', true),
                    _StatusRow('Em análise', true),
                    _StatusRow('Em atendimento', false),
                    _StatusRow('Concluído', false),
                  ],
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

class _StatusRow extends StatelessWidget {
  final String label;
  final bool done;
  const _StatusRow(this.label, this.done);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        children: [
          Icon(done ? Icons.check_circle : Icons.radio_button_unchecked,
              color: done ? AppColors.safetyGreen : AppColors.onSurfaceVariant, size: 20),
          const SizedBox(width: 12),
          Text(label,
              style: TextStyle(
                  color: done ? AppColors.onSurface : AppColors.onSurfaceVariant,
                  fontWeight: done ? FontWeight.w600 : FontWeight.normal)),
        ],
      ),
    );
  }
}
