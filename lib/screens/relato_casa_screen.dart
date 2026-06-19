import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../theme/app_theme.dart';

class RelatoCasaScreen extends StatefulWidget {
  const RelatoCasaScreen({super.key});
  @override
  State<RelatoCasaScreen> createState() => _RelatoCasaScreenState();
}

class _RelatoCasaScreenState extends State<RelatoCasaScreen> {
  String? _tipo;
  final _descController = TextEditingController();
  final _tipos = ['Violência física', 'Violência verbal', 'Negligência', 'Ameaça', 'Outro'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(title: const Text('Relato em Casa')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Icon(Icons.home, size: 48, color: AppColors.primary),
            const SizedBox(height: 12),
            Text('O que aconteceu em casa?',
                style: Theme.of(context).textTheme.headlineMedium),
            const SizedBox(height: 8),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: AppColors.safetyGreen.withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text('Você está seguro(a) agora? Se não, ligue 190.',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: AppColors.safetyGreen,
                        fontWeight: FontWeight.w600,
                      )),
            ),
            const SizedBox(height: 20),
            Text('Tipo de situação', style: Theme.of(context).textTheme.labelLarge),
            const SizedBox(height: 10),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: _tipos.map((t) => ChoiceChip(
                label: Text(t),
                selected: _tipo == t,
                onSelected: (_) => setState(() => _tipo = t),
                selectedColor: AppColors.primaryContainer,
              )).toList(),
            ),
            const SizedBox(height: 20),
            Text('Descreva o que aconteceu', style: Theme.of(context).textTheme.labelLarge),
            const SizedBox(height: 8),
            TextField(
              controller: _descController,
              maxLines: 5,
              decoration: const InputDecoration(hintText: 'Conte com suas palavras...'),
            ),
            const SizedBox(height: 32),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () => context.go('/relato/sucesso'),
                child: const Text('Enviar Relato'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
