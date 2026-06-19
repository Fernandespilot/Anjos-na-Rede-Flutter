import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'theme/app_theme.dart';
import 'screens/splash_screen.dart';
import 'screens/home_screen.dart';
import 'screens/relato_agora_screen.dart';
import 'screens/emergencia_screen.dart';
import 'screens/relato_escola_screen.dart';
import 'screens/relato_casa_screen.dart';
import 'screens/relato_internet_screen.dart';
import 'screens/relato_formulario_screen.dart';
import 'screens/relato_sucesso_screen.dart';
import 'screens/meus_direitos_screen.dart';
import 'screens/acompanhar_screen.dart';
import 'widgets/agent_chat_widget.dart';

void main() {
  runApp(const AnjosApp());
}

final _router = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(path: '/', builder: (_, __) => const SplashScreen()),
    ShellRoute(
      builder: (context, state, child) => ScaffoldWithChat(child: child),
      routes: [
        GoRoute(path: '/home', builder: (_, __) => const HomeScreen()),
        GoRoute(path: '/relato/agora', builder: (_, __) => const RelatoAgoraScreen()),
        GoRoute(path: '/emergencia', builder: (_, __) => const EmergenciaScreen()),
        GoRoute(path: '/relato/escola', builder: (_, __) => const RelatoEscolaScreen()),
        GoRoute(path: '/relato/casa', builder: (_, __) => const RelatoCasaScreen()),
        GoRoute(path: '/relato/internet', builder: (_, __) => const RelatoInternetScreen()),
        GoRoute(path: '/relato/formulario', builder: (_, __) => const RelatoFormularioScreen()),
        GoRoute(path: '/relato/sucesso', builder: (_, __) => const RelatoSucessoScreen()),
        GoRoute(path: '/direitos', builder: (_, __) => const MeusDireitosScreen()),
        GoRoute(path: '/acompanhar', builder: (_, __) => const AcompanharScreen()),
      ],
    ),
  ],
);

class AnjosApp extends StatelessWidget {
  const AnjosApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Anjos da Rede',
      theme: appTheme,
      routerConfig: _router,
      debugShowCheckedModeBanner: false,
    );
  }
}

class ScaffoldWithChat extends StatelessWidget {
  final Widget child;
  const ScaffoldWithChat({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        child,
        const AgentChatWidget(),
      ],
    );
  }
}
