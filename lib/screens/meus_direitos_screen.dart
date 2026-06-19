import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

class MeusDireitosScreen extends StatelessWidget {
  const MeusDireitosScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final direitos = [
      {'icon': Icons.favorite, 'title': 'Direito à vida e saúde', 'desc': 'Você tem direito a cuidados médicos e a viver com segurança.'},
      {'icon': Icons.school, 'title': 'Direito à educação', 'desc': 'Nenhuma situação pode impedir você de estudar.'},
      {'icon': Icons.home, 'title': 'Direito à família', 'desc': 'Você tem direito a viver em família e ser cuidado com amor.'},
      {'icon': Icons.shield, 'title': 'Proteção contra violência', 'desc': 'Ninguém pode te bater, humilhar ou fazer você se sentir mal.'},
      {'icon': Icons.lock, 'title': 'Direito ao sigilo', 'desc': 'Sua denúncia é confidencial. Ninguém saberá que foi você.'},
      {'icon': Icons.sports_esports, 'title': 'Direito ao lazer', 'desc': 'Brincar e descansar são direitos seus garantidos por lei.'},
    ];

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(title: const Text('Meus Direitos')),
      body: ListView.separated(
        padding: const EdgeInsets.all(20),
        itemCount: direitos.length,
        separatorBuilder: (_, __) => const SizedBox(height: 12),
        itemBuilder: (context, i) {
          final d = direitos[i];
          return Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
              boxShadow: [BoxShadow(color: Colors.black.withValues(alpha: 0.05), blurRadius: 8)],
            ),
            child: Row(
              children: [
                Container(
                  width: 52,
                  height: 52,
                  decoration: BoxDecoration(
                    color: AppColors.primaryContainer,
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: Icon(d['icon'] as IconData, color: AppColors.primary, size: 28),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(d['title'] as String,
                          style: Theme.of(context).textTheme.labelLarge),
                      const SizedBox(height: 4),
                      Text(d['desc'] as String,
                          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                color: AppColors.onSurfaceVariant)),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
