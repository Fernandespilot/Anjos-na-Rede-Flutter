import 'package:flutter_test/flutter_test.dart';
import 'package:anjos_da_rede/main.dart';

void main() {
  testWidgets('App smoke test', (WidgetTester tester) async {
    await tester.pumpWidget(const AnjosApp());
    expect(find.byType(AnjosApp), findsOneWidget);
  });
}
