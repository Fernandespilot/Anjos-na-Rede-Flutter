import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../theme/app_theme.dart';

class EmergenciaScreen extends StatelessWidget {
  const EmergenciaScreen({super.key});

  void _call(String number) async {
    final uri = Uri.parse('tel:$number');
    if (await canLaunchUrl(uri)) launchUrl(uri);
  }

  @override
  Widget build(BuildContext context) {
    final contacts = [
      {'name': 'Polícia Militar', 'number': '190', 'icon': Icons.local_police, 'color': const Color(0xFF1565C0)},
      {'name': 'SAMU', 'number': '192', 'icon': Icons.local_hospital, 'color': const Color(0xFFC62828)},
      {'name': 'Bombeiros', 'number': '193', 'icon': Icons.fire_truck, 'color': const Color(0xFFE65100)},
      {'name': 'Disque 100', 'number': '100', 'icon': Icons.child_care, 'color': AppColors.primary},
      {'name': 'Ligue 180', 'number': '180', 'icon': Icons.support_agent, 'color': const Color(0xFF6A1B9A)},
      {'name': 'Polícia Civil', 'number': '197', 'icon': Icons.gavel, 'color': const Color(0xFF37474F)},
    ];

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(title: const Text('Canais de Emergência')),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: AppColors.criticalCoral.withOpacity(0.1),
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: AppColors.criticalCoral.withOpacity(0.3)),
              ),
              child: Row(
                children: [
                  const Icon(Icons.emergency, color: AppColors.criticalCoral),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      'Toque no número para ligar imediatamente',
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            color: AppColors.criticalCoral,
                            fontWeight: FontWeight.w600,
                          ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 12,
                  mainAxisSpacing: 12,
                  childAspectRatio: 1.3,
                ),
                itemCount: contacts.length,
                itemBuilder: (context, i) {
                  final c = contacts[i];
                  return InkWell(
                    onTap: () => _call(c['number'] as String),
                    borderRadius: BorderRadius.circular(20),
                    child: Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(
                              color: Colors.black.withOpacity(0.06),
                              blurRadius: 12,
                              offset: const Offset(0, 4)),
                        ],
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(c['icon'] as IconData, color: c['color'] as Color, size: 36),
                          const SizedBox(height: 8),
                          Text(c['name'] as String,
                              style: Theme.of(context)
                                  .textTheme
                                  .labelLarge
                                  ?.copyWith(fontSize: 12),
                              textAlign: TextAlign.center),
                          const SizedBox(height: 4),
                          Text(c['number'] as String,
                              style: TextStyle(
                                  fontSize: 22,
                                  fontWeight: FontWeight.w700,
                                  color: c['color'] as Color)),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
