import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:go_router/go_router.dart';
import '../theme/app_theme.dart';

class RelatoSucessoScreen extends StatelessWidget {
  const RelatoSucessoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final protocol = 'ANJ${DateTime.now().millisecondsSinceEpoch.toString().substring(7)}';

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(32),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 100,
                height: 100,
                decoration: const BoxDecoration(
                  color: AppColors.safetyGreen,
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.check, size: 56, color: Colors.white),
              ).animate().scale(duration: 600.ms, curve: Curves.elasticOut),
              const SizedBox(height: 24),
              Text('Relato enviado!',
                  style: Theme.of(context).textTheme.headlineMedium,
                  textAlign: TextAlign.center)
                  .animate().fadeIn(delay: 400.ms),
              const SizedBox(height: 12),
              Text(
                'Seu relato foi registrado com segurança. Uma equipe especializada irá analisar.',
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      color: AppColors.onSurfaceVariant,
                    ),
                textAlign: TextAlign.center,
              ).animate().fadeIn(delay: 500.ms),
              const SizedBox(height: 32),
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: AppColors.primaryContainer,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Column(
                  children: [
                    const Icon(Icons.receipt_long, color: AppColors.primary, size: 32),
                    const SizedBox(height: 8),
                    const Text('Número do protocolo', style: TextStyle(fontWeight: FontWeight.w600)),
                    const SizedBox(height: 4),
                    Text(protocol,
                        style: const TextStyle(
                            fontSize: 20, fontWeight: FontWeight.w700, color: AppColors.primary)),
                  ],
                ),
              ).animate().fadeIn(delay: 700.ms),
              const SizedBox(height: 40),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () => context.go('/home'),
                  child: const Text('Voltar ao início'),
                ),
              ),
              const SizedBox(height: 12),
              TextButton(
                onPressed: () => context.go('/acompanhar'),
                child: const Text('Acompanhar meu relato'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
