import 'dart:convert';
import 'package:http/http.dart' as http;

class ChatMessage {
  final String role;
  final String content;
  const ChatMessage({required this.role, required this.content});
  Map<String, String> toJson() => {'role': role, 'content': content};
}

class ChatAction {
  final String label;
  final String? to;
  final String? reply;
  const ChatAction({required this.label, this.to, this.reply});

  factory ChatAction.fromJson(Map<String, dynamic> j) =>
      ChatAction(label: j['label'] ?? '', to: j['to'], reply: j['reply']);
}

class GroqResponse {
  final String text;
  final List<ChatAction> actions;
  const GroqResponse({required this.text, required this.actions});
}

class GroqService {
  static const _apiUrl = 'https://api.groq.com/openai/v1/chat/completions';
  static const _model = 'llama-3.1-8b-instant';
  static const _apiKey = String.fromEnvironment('GROQ_API_KEY', defaultValue: '');

  static const _systemPrompt = '''
Você é o **Anjo da Rede**, assistente virtual acolhedor do portal de proteção de crianças e adolescentes do Estado de Mato Grosso (SESP-MT), Brasil.

## Missão principal
Escutar com empatia, acolher sem julgamento e orientar para o caminho certo.

## Como conduzir a conversa
Nas primeiras mensagens, acolha sem direcionar. Valide o sentimento e faça uma pergunta aberta.
Só após entender o contexto, ofereça os próximos passos.

## Personalidade
- Tom: humano, acolhedor, calmo
- Linguagem simples e afetiva, acessível desde os 8 anos
- NUNCA julgue. NUNCA minimize.

## URGÊNCIA (prioridade máxima)
Se mencionar perigo agora, socorro, está batendo → responda com empatia e informe: 190 (Polícia), 192 (SAMU), 100 (Disque Direitos).

## Telas disponíveis (rota Flutter)
- /emergencia → canais de emergência
- /relato/escola → bullying ou problema na escola
- /relato/casa → violência em casa
- /relato/internet → cyberbullying
- /relato/formulario → formulário geral
- /direitos → direitos da criança
- /acompanhar → acompanhar denúncia

## Formato
- Máximo 3 frases por resposta
- Nas primeiras trocas: só texto, sem botões
- Quando direcionar: [ACTIONS]{"actions":[{"label":"emoji texto","to":"/rota"}]}[/ACTIONS]
''';

  static Future<GroqResponse> sendMessage(List<ChatMessage> history) async {
    final messages = [
      {'role': 'system', 'content': _systemPrompt},
      ...history.takeLast(6).map((m) => m.toJson()),
    ];

    final response = await http.post(
      Uri.parse(_apiUrl),
      headers: {
        'Authorization': 'Bearer $_apiKey',
        'Content-Type': 'application/json',
      },
      body: jsonEncode({
        'model': _model,
        'max_tokens': 400,
        'temperature': 0.5,
        'messages': messages,
      }),
    );

    if (response.statusCode != 200) {
      throw Exception('Groq API error: ${response.statusCode}');
    }

    final data = jsonDecode(response.body);
    final raw = data['choices'][0]['message']['content'] as String;

    final actionsMatch = RegExp(r'\[ACTIONS\](.*?)\[/ACTIONS\]', dotAll: true).firstMatch(raw);
    final text = raw.replaceAll(RegExp(r'\[ACTIONS\].*?\[/ACTIONS\]', dotAll: true), '').trim();
    List<ChatAction> actions = [];

    if (actionsMatch != null) {
      try {
        final parsed = jsonDecode(actionsMatch.group(1)!);
        actions = (parsed['actions'] as List).map((a) => ChatAction.fromJson(a)).toList();
      } catch (_) {}
    }

    return GroqResponse(text: text, actions: actions);
  }
}

extension TakeLast<T> on List<T> {
  List<T> takeLast(int n) => length <= n ? this : sublist(length - n);
}
