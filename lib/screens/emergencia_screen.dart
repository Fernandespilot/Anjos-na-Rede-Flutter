import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../theme/app_theme.dart';

class EmergenciaScreen extends StatefulWidget {
  const EmergenciaScreen({super.key});
  @override
  State<EmergenciaScreen> createState() => _EmergenciaScreenState();
}

class _EmergenciaScreenState extends State<EmergenciaScreen> {
  String? _chamando;

  Future<void> _ligar(String numero) async {
    setState(() => _chamando = numero);
    final uri = Uri.parse('tel:$numero');
    if (await canLaunchUrl(uri)) launchUrl(uri);
    await Future.delayed(const Duration(seconds: 2));
    if (mounted) setState(() => _chamando = null);
  }

  @override
  Widget build(BuildContext context) {
    final canais = [
      {'numero': '190', 'nome': 'Polícia Militar', 'sub': 'Crimes em andamento · Violência', 'logo': 'assets/images/logo-pm-mt.png', 'destaque': true},
      {'numero': '192', 'nome': 'SAMU', 'sub': 'Emergências médicas · Ferimentos', 'logo': 'assets/images/logo-samu.png', 'destaque': false},
      {'numero': '193', 'nome': 'Corpo de Bombeiros', 'sub': 'Resgates · Incêndios', 'logo': 'assets/images/logo-bombeiros-mt.png', 'destaque': false},
      {'numero': '100', 'nome': 'Disque Direitos Humanos', 'sub': 'Crianças · Adolescentes', 'logo': 'assets/images/logo-disque-100.webp', 'destaque': false},
      {'numero': '180', 'nome': 'Central da Mulher', 'sub': 'Violência doméstica · Familiar', 'logo': 'assets/images/logo-ligue180.png', 'destaque': false},
      {'numero': '197', 'nome': 'Polícia Civil MT', 'sub': 'Ocorrências · Investigações', 'logo': 'assets/images/logo-policia-civil.jpeg', 'destaque': false},
    ];

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(title: const Text('Canais de Emergência')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Alerta
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: AppColors.criticalCoral.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: AppColors.criticalCoral.withValues(alpha: 0.3), width: 2),
              ),
              child: Row(
                children: [
                  Container(
                    width: 44, height: 44,
                    decoration: const BoxDecoration(color: AppColors.criticalCoral, shape: BoxShape.circle),
                    child: const Icon(Icons.emergency, color: Colors.white),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Situação de Emergência',
                            style: Theme.of(context).textTheme.labelLarge?.copyWith(color: AppColors.criticalCoral, fontSize: 15)),
                        const SizedBox(height: 2),
                        Text('Toque em um canal abaixo para ligar. Todos gratuitos e 24h.',
                            style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: AppColors.onSurfaceVariant)),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),

            // Canal destaque (PM 190)
            _buildDestaqueCard(context, canais[0]),
            const SizedBox(height: 12),

            // Grid dos demais
            GridView.count(
              crossAxisCount: 2,
              crossAxisSpacing: 12,
              mainAxisSpacing: 12,
              childAspectRatio: 0.85,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              children: canais.skip(1).map((c) => _buildCanalCard(context, c)).toList(),
            ),

            const SizedBox(height: 20),
            // Outros números
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [BoxShadow(color: Colors.black.withValues(alpha: 0.05), blurRadius: 8)],
              ),
              child: Column(
                children: [
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(16),
                    decoration: const BoxDecoration(
                      color: AppColors.primary,
                      borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
                    ),
                    child: const Text('Telefones CIOSP — Mato Grosso',
                        style: TextStyle(color: Colors.white, fontWeight: FontWeight.w700, fontSize: 15),
                        textAlign: TextAlign.center),
                  ),
                  ...[
                    {'label': 'Polícia Rodoviária Federal', 'numero': '191'},
                    {'label': 'Defesa Civil', 'numero': '199'},
                    {'label': 'Polícia Civil (outras cidades MT)', 'numero': '181'},
                    {'label': 'Guarda Municipal Várzea Grande', 'numero': '153'},
                  ].map((item) => InkWell(
                    onTap: () => _ligar(item['numero']!),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(item['label']!, style: Theme.of(context).textTheme.bodyMedium),
                          Row(
                            children: [
                              Text(item['numero']!,
                                  style: const TextStyle(fontWeight: FontWeight.w700, color: AppColors.primary, fontSize: 16)),
                              const SizedBox(width: 4),
                              const Icon(Icons.call, color: AppColors.primary, size: 16),
                            ],
                          ),
                        ],
                      ),
                    ),
                  )),
                ],
              ),
            ),
            const SizedBox(height: 80),
          ],
        ),
      ),
    );
  }

  Widget _buildDestaqueCard(BuildContext context, Map<String, dynamic> canal) {
    final ligando = _chamando == canal['numero'];
    return InkWell(
      onTap: () => _ligar(canal['numero'] as String),
      borderRadius: BorderRadius.circular(24),
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(24),
          border: Border.all(color: AppColors.primary, width: 2),
          boxShadow: [BoxShadow(color: Colors.black.withValues(alpha: 0.06), blurRadius: 12)],
        ),
        child: Row(
          children: [
            Container(
              width: 72, height: 72,
              decoration: BoxDecoration(shape: BoxShape.circle,
                  border: Border.all(color: AppColors.primaryContainer, width: 2)),
              clipBehavior: Clip.antiAlias,
              child: Image.asset(canal['logo'] as String, fit: BoxFit.contain),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
                    decoration: BoxDecoration(color: AppColors.primaryContainer.withValues(alpha: 0.5),
                        borderRadius: BorderRadius.circular(20)),
                    child: const Text('Emergência Principal',
                        style: TextStyle(fontSize: 10, fontWeight: FontWeight.w700, color: AppColors.primary)),
                  ),
                  const SizedBox(height: 4),
                  Text('${canal['numero']} — ${canal['nome']}',
                      style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w700, color: AppColors.primary)),
                  Text(canal['sub'] as String,
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: AppColors.onSurfaceVariant)),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              decoration: BoxDecoration(
                color: ligando ? AppColors.safetyGreen : AppColors.primary,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Row(
                children: [
                  Icon(ligando ? Icons.phone_in_talk : Icons.call, color: Colors.white, size: 18),
                  const SizedBox(width: 4),
                  Text(ligando ? 'Ligando...' : 'Ligar',
                      style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w600, fontSize: 12)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCanalCard(BuildContext context, Map<String, dynamic> canal) {
    final ligando = _chamando == canal['numero'];
    return InkWell(
      onTap: () => _ligar(canal['numero'] as String),
      borderRadius: BorderRadius.circular(20),
      child: Container(
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [BoxShadow(color: Colors.black.withValues(alpha: 0.05), blurRadius: 8)],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 64, height: 64,
              decoration: BoxDecoration(shape: BoxShape.circle,
                  border: Border.all(color: const Color(0xFFBFC8CD).withValues(alpha: 0.5))),
              clipBehavior: Clip.antiAlias,
              child: Image.asset(canal['logo'] as String,
                  fit: canal['numero'] == '180' ? BoxFit.cover : BoxFit.contain),
            ),
            const SizedBox(height: 10),
            Text(canal['numero'] as String,
                style: const TextStyle(fontSize: 22, fontWeight: FontWeight.w700, color: AppColors.primary)),
            Text(canal['nome'] as String,
                style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w600, color: AppColors.onSurface),
                textAlign: TextAlign.center),
            Text(canal['sub'] as String,
                style: const TextStyle(fontSize: 9, color: AppColors.onSurfaceVariant),
                textAlign: TextAlign.center, maxLines: 2),
            const SizedBox(height: 8),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 7),
              decoration: BoxDecoration(
                color: ligando ? AppColors.safetyGreen : AppColors.primaryContainer,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(ligando ? Icons.phone_in_talk : Icons.call,
                      color: ligando ? Colors.white : AppColors.onPrimaryContainer, size: 14),
                  const SizedBox(width: 4),
                  Text(ligando ? 'Ligando...' : 'Toque para ligar',
                      style: TextStyle(
                          fontSize: 9,
                          fontWeight: FontWeight.w600,
                          color: ligando ? Colors.white : AppColors.onPrimaryContainer)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
