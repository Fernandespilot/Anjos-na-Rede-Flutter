import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../theme/app_theme.dart';

class RelatoFormularioScreen extends StatefulWidget {
  const RelatoFormularioScreen({super.key});
  @override
  State<RelatoFormularioScreen> createState() => _RelatoFormularioScreenState();
}

class _RelatoFormularioScreenState extends State<RelatoFormularioScreen> {
  int _step = 0;
  String? _local;
  String? _tipo;
  final _descController = TextEditingController();

  final _locais = ['Escola', 'Casa', 'Internet', 'Rua', 'Outro'];
  final _tipos = ['Violência física', 'Bullying', 'Ameaça', 'Abuso', 'Outro'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: Text('Passo ${_step + 1} de 3'),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(4),
          child: LinearProgressIndicator(
            value: (_step + 1) / 3,
            backgroundColor: AppColors.primaryContainer,
            color: AppColors.primary,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (_step == 0) ...[
              Text('Onde aconteceu?', style: Theme.of(context).textTheme.headlineMedium),
              const SizedBox(height: 20),
              Wrap(
                spacing: 10,
                runSpacing: 10,
                children: _locais.map((l) => ChoiceChip(
                  label: Text(l),
                  selected: _local == l,
                  onSelected: (_) => setState(() => _local = l),
                  selectedColor: AppColors.primaryContainer,
                )).toList(),
              ),
            ],
            if (_step == 1) ...[
              Text('O que aconteceu?', style: Theme.of(context).textTheme.headlineMedium),
              const SizedBox(height: 20),
              Wrap(
                spacing: 10,
                runSpacing: 10,
                children: _tipos.map((t) => ChoiceChip(
                  label: Text(t),
                  selected: _tipo == t,
                  onSelected: (_) => setState(() => _tipo = t),
                  selectedColor: AppColors.primaryContainer,
                )).toList(),
              ),
            ],
            if (_step == 2) ...[
              Text('Conte o que aconteceu', style: Theme.of(context).textTheme.headlineMedium),
              const SizedBox(height: 20),
              TextField(
                controller: _descController,
                maxLines: 8,
                decoration: const InputDecoration(hintText: 'Descreva com suas palavras...'),
              ),
            ],
            const Spacer(),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  if (_step < 2) {
                    setState(() => _step++);
                  } else {
                    context.go('/relato/sucesso');
                  }
                },
                child: Text(_step < 2 ? 'Próximo' : 'Enviar Relato'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
