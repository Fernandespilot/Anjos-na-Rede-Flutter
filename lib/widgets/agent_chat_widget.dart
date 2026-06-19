import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../theme/app_theme.dart';
import '../services/groq_service.dart';

class AgentChatWidget extends StatefulWidget {
  const AgentChatWidget({super.key});

  @override
  State<AgentChatWidget> createState() => _AgentChatWidgetState();
}

class _AgentChatWidgetState extends State<AgentChatWidget> {
  bool _open = false;
  final _controller = TextEditingController();
  final _scrollController = ScrollController();
  bool _loading = false;

  final List<_Msg> _messages = [
    _Msg(
      isAgent: true,
      text: 'Olá! Sou o Anjo da Rede 💙 Estou aqui para te ajudar. O que está acontecendo?',
      actions: [
        ChatAction(label: '🚨 Preciso de ajuda agora', to: '/emergencia'),
        ChatAction(label: '📝 Quero registrar algo', reply: 'quero registrar algo que aconteceu'),
        ChatAction(label: '📖 Meus direitos', to: '/direitos'),
      ],
    ),
  ];

  final List<ChatMessage> _history = [];

  void _scrollToBottom() {
    Future.delayed(const Duration(milliseconds: 100), () {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  Future<void> _send(String text) async {
    final trimmed = text.trim();
    if (trimmed.isEmpty || _loading) return;

    setState(() {
      _messages.add(_Msg(isAgent: false, text: trimmed));
      _loading = true;
    });
    _controller.clear();
    _scrollToBottom();

    _history.add(ChatMessage(role: 'user', content: trimmed));

    try {
      final response = await GroqService.sendMessage(_history);
      _history.add(ChatMessage(role: 'assistant', content: response.text));
      setState(() {
        _messages.add(_Msg(isAgent: true, text: response.text, actions: response.actions));
        _loading = false;
      });
    } catch (_) {
      setState(() {
        _messages.add(_Msg(isAgent: true, text: 'Estou aqui com você. Pode me contar o que aconteceu?'));
        _loading = false;
      });
    }
    _scrollToBottom();
  }

  void _handleAction(ChatAction action) {
    if (action.to != null) {
      setState(() => _open = false);
      context.go(action.to!);
    } else if (action.reply != null) {
      _send(action.reply!);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 16,
      right: 16,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisSize: MainAxisSize.min,
        children: [
          if (_open)
            Container(
              width: 320,
              height: 480,
              margin: const EdgeInsets.only(bottom: 8),
              decoration: BoxDecoration(
                color: AppColors.background,
                borderRadius: BorderRadius.circular(24),
                boxShadow: [
                  BoxShadow(color: Colors.black.withOpacity(0.15), blurRadius: 24, offset: const Offset(0, 8)),
                ],
              ),
              child: Column(
                children: [
                  // Header
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                    decoration: const BoxDecoration(
                      color: AppColors.primary,
                      borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
                    ),
                    child: Row(
                      children: [
                        const CircleAvatar(
                          radius: 18,
                          backgroundColor: Colors.white24,
                          child: Icon(Icons.support_agent, color: Colors.white, size: 20),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text('Anjo da Rede',
                                  style: TextStyle(color: Colors.white, fontWeight: FontWeight.w700, fontSize: 14)),
                              Row(
                                children: [
                                  Container(width: 8, height: 8, decoration: const BoxDecoration(color: AppColors.safetyGreen, shape: BoxShape.circle)),
                                  const SizedBox(width: 4),
                                  const Text('Assistente com IA', style: TextStyle(color: Colors.white70, fontSize: 11)),
                                ],
                              ),
                            ],
                          ),
                        ),
                        IconButton(
                          icon: const Icon(Icons.close, color: Colors.white, size: 20),
                          onPressed: () => setState(() => _open = false),
                        ),
                      ],
                    ),
                  ),
                  // Messages
                  Expanded(
                    child: ListView.builder(
                      controller: _scrollController,
                      padding: const EdgeInsets.all(12),
                      itemCount: _messages.length + (_loading ? 1 : 0),
                      itemBuilder: (context, i) {
                        if (_loading && i == _messages.length) {
                          return const Align(
                            alignment: Alignment.centerLeft,
                            child: Padding(
                              padding: EdgeInsets.symmetric(vertical: 4),
                              child: _TypingIndicator(),
                            ),
                          );
                        }
                        final msg = _messages[i];
                        return _MessageBubble(msg: msg, onAction: _handleAction);
                      },
                    ),
                  ),
                  // Input
                  Container(
                    padding: const EdgeInsets.all(10),
                    decoration: const BoxDecoration(
                      border: Border(top: BorderSide(color: Color(0xFFCFD8DC))),
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: TextField(
                            controller: _controller,
                            onSubmitted: _send,
                            decoration: InputDecoration(
                              hintText: 'Digite uma mensagem...',
                              hintStyle: const TextStyle(fontSize: 13),
                              contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                              filled: true,
                              fillColor: const Color(0xFFEEF2F5),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20),
                                borderSide: BorderSide.none,
                              ),
                            ),
                            style: const TextStyle(fontSize: 13),
                          ),
                        ),
                        const SizedBox(width: 8),
                        GestureDetector(
                          onTap: () => _send(_controller.text),
                          child: Container(
                            width: 38,
                            height: 38,
                            decoration: const BoxDecoration(
                              color: AppColors.primary,
                              shape: BoxShape.circle,
                            ),
                            child: const Icon(Icons.send, color: Colors.white, size: 18),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          // FAB
          FloatingActionButton(
            onPressed: () => setState(() => _open = !_open),
            backgroundColor: AppColors.primary,
            child: Icon(_open ? Icons.close : Icons.support_agent, color: Colors.white),
          ),
        ],
      ),
    );
  }
}

class _Msg {
  final bool isAgent;
  final String text;
  final List<ChatAction> actions;
  _Msg({required this.isAgent, required this.text, this.actions = const []});
}

class _MessageBubble extends StatelessWidget {
  final _Msg msg;
  final void Function(ChatAction) onAction;
  const _MessageBubble({required this.msg, required this.onAction});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Column(
        crossAxisAlignment: msg.isAgent ? CrossAxisAlignment.start : CrossAxisAlignment.end,
        children: [
          Container(
            constraints: const BoxConstraints(maxWidth: 240),
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
            decoration: BoxDecoration(
              color: msg.isAgent ? const Color(0xFFEEF2F5) : AppColors.primary,
              borderRadius: BorderRadius.only(
                topLeft: const Radius.circular(18),
                topRight: const Radius.circular(18),
                bottomLeft: Radius.circular(msg.isAgent ? 4 : 18),
                bottomRight: Radius.circular(msg.isAgent ? 18 : 4),
              ),
            ),
            child: Text(
              msg.text,
              style: TextStyle(
                fontSize: 13,
                color: msg.isAgent ? AppColors.onSurface : Colors.white,
              ),
            ),
          ),
          if (msg.actions.isNotEmpty) ...[
            const SizedBox(height: 6),
            Wrap(
              spacing: 6,
              runSpacing: 6,
              children: msg.actions.map((a) => GestureDetector(
                onTap: () => onAction(a),
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: AppColors.primaryContainer,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(a.label,
                      style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w600, color: AppColors.primary)),
                ),
              )).toList(),
            ),
          ],
        ],
      ),
    );
  }
}

class _TypingIndicator extends StatefulWidget {
  const _TypingIndicator();
  @override
  State<_TypingIndicator> createState() => _TypingIndicatorState();
}

class _TypingIndicatorState extends State<_TypingIndicator> with SingleTickerProviderStateMixin {
  late AnimationController _ctrl;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(vsync: this, duration: const Duration(milliseconds: 900))..repeat();
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
      decoration: BoxDecoration(
        color: const Color(0xFFEEF2F5),
        borderRadius: BorderRadius.circular(18),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: List.generate(3, (i) => AnimatedBuilder(
          animation: _ctrl,
          builder: (_, __) {
            final offset = ((_ctrl.value + i * 0.33) % 1.0);
            final y = offset < 0.5 ? offset * 2 : (1 - offset) * 2;
            return Container(
              margin: const EdgeInsets.symmetric(horizontal: 2),
              width: 7,
              height: 7,
              decoration: const BoxDecoration(color: AppColors.primary, shape: BoxShape.circle),
              transform: Matrix4.translationValues(0, -4 * y, 0),
            );
          },
        )),
      ),
    );
  }
}
