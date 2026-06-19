import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:go_router/go_router.dart';
import '../theme/app_theme.dart';
import '../widgets/action_card.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 16),
              // Header
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Anjos da Rede',
                    style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                          color: AppColors.primary,
                          fontWeight: FontWeight.w700,
                        ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.admin_panel_settings_outlined),
                    color: AppColors.onSurfaceVariant,
                    onPressed: () {},
                  ),
                ],
              ),
              const SizedBox(height: 24),
              // Hero section
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [Color(0xFFE0F4FF), Color(0xFFB2DFDB)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(28),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Você não está\nsozinho.',
                      style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                            fontWeight: FontWeight.w700,
                          ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Estamos aqui.',
                      style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                            color: AppColors.primary,
                            fontWeight: FontWeight.w700,
                          ),
                    ),
                    const SizedBox(height: 12),
                    Text(
                      'Este é um espaço seguro para você falar, denunciar e se proteger. Tudo com total sigilo.',
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            color: AppColors.onSurfaceVariant,
                          ),
                    ),
                    const SizedBox(height: 16),
                    Center(
                      child: Image.asset(
                        'assets/images/anjo.png',
                        height: 120,
                        errorBuilder: (_, __, ___) => const Icon(
                          Icons.volunteer_activism,
                          size: 80,
                          color: AppColors.primary,
                        ),
                      ),
                    ),
                  ],
                ),
              ).animate().fadeIn().slideY(begin: 0.1),
              const SizedBox(height: 24),
              // Action cards
              Text(
                'O que você precisa?',
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              const SizedBox(height: 16),
              ActionCard(
                title: 'Quero Conversar',
                subtitle: 'Fale com um anjo da rede agora mesmo',
                color: AppColors.goldSoft,
                icon: Icons.chat_bubble_outline,
                imagePath: 'assets/images/quero conversar.png',
                buttonLabel: 'Entrar no chat',
                onTap: () {},
                delay: 100,
              ),
              const SizedBox(height: 12),
              ActionCard(
                title: 'Relatar Algo',
                subtitle: 'Conte o que está acontecendo com você',
                color: AppColors.skyBlueLight,
                icon: Icons.campaign_outlined,
                imagePath: 'assets/images/relato.png',
                buttonLabel: 'Fazer relato',
                onTap: () => context.go('/relato/agora'),
                delay: 200,
              ),
              const SizedBox(height: 12),
              ActionCard(
                title: 'Meus Direitos',
                subtitle: 'Conheça seus direitos e como se proteger',
                color: const Color(0xFFD8F3DC),
                icon: Icons.menu_book_outlined,
                imagePath: 'assets/images/meus direitos.png',
                buttonLabel: 'Saber mais',
                onTap: () => context.go('/direitos'),
                delay: 300,
              ),
              const SizedBox(height: 24),
              // Secondary cards
              Row(
                children: [
                  Expanded(
                    child: _SecondaryCard(
                      title: 'Acompanhar Denúncia',
                      subtitle: 'Veja o status do seu relato',
                      icon: Icons.manage_search,
                      onTap: () => context.go('/acompanhar'),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: _SecondaryCard(
                      title: 'Rede de Proteção',
                      subtitle: 'Órgãos oficiais de ajuda',
                      icon: Icons.hub_outlined,
                      onTap: () => context.go('/emergencia'),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 80),
            ],
          ),
        ),
      ),
    );
  }
}

class _SecondaryCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final IconData icon;
  final VoidCallback onTap;

  const _SecondaryCard({
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(20),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.06),
              blurRadius: 12,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(icon, color: AppColors.primary, size: 28),
            const SizedBox(height: 12),
            Text(title,
                style: Theme.of(context).textTheme.labelLarge?.copyWith(fontSize: 13)),
            const SizedBox(height: 4),
            Text(subtitle,
                style: Theme.of(context)
                    .textTheme
                    .bodyMedium
                    ?.copyWith(color: AppColors.onSurfaceVariant, fontSize: 12)),
          ],
        ),
      ),
    );
  }
}
