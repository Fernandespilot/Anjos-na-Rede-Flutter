import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../theme/app_theme.dart';

class RelatoAgoraScreen extends StatelessWidget {
  const RelatoAgoraScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(title: const Text('Está acontecendo agora?')),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.warning_amber_rounded, size: 80, color: AppColors.criticalCoral),
            const SizedBox(height: 24),
            Text('Você está em perigo agora?',
                style: Theme.of(context).textTheme.headlineMedium,
                textAlign: TextAlign.center),
            const SizedBox(height: 12),
            Text(
              'Se você estiver em perigo imediato, ligue agora para a polícia ou acesse os canais de emergência.',
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(color: AppColors.onSurfaceVariant),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 40),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: () => context.go('/emergencia'),
                icon: const Icon(Icons.emergency),
                label: const Text('Sim, preciso de ajuda agora'),
                style: ElevatedButton.styleFrom(backgroundColor: AppColors.criticalCoral),
              ),
            ),
            const SizedBox(height: 16),
            SizedBox(
              width: double.infinity,
              child: OutlinedButton.icon(
                onPressed: () => context.go('/relato/formulario'),
                icon: const Icon(Icons.edit_note),
                label: const Text('Não, quero registrar algo que passou'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
