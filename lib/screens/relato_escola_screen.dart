import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../theme/app_theme.dart';

class RelatoEscolaScreen extends StatefulWidget {
  const RelatoEscolaScreen({super.key});
  @override
  State<RelatoEscolaScreen> createState() => _RelatoEscolaScreenState();
}

class _RelatoEscolaScreenState extends State<RelatoEscolaScreen> {
  String? _tipo;
  final _descController = TextEditingController();
  final _tipos = ['Bullying', 'Briga', 'Exclusão', 'Ameaça', 'Outro'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(title: const Text('Relato Escolar')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Icon(Icons.school, size: 48, color: AppColors.primary),
            const SizedBox(height: 12),
            Text('O que aconteceu na escola?',
                style: Theme.of(context).textTheme.headlineMedium),
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
