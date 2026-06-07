import 'package:flutter_test/flutter_test.dart';

import 'package:controle_agua/main.dart';

void main() {
  testWidgets('Deve abrir o dashboard do app', (WidgetTester tester) async {
    await tester.pumpWidget(const ControleAguaApp());

    expect(find.text('Controle de Consumo de Água'), findsOneWidget);
    expect(find.text('Abrir lista com SQLite local'), findsOneWidget);
    expect(find.text('Abrir lista com API Render/PostgreSQL'), findsOneWidget);
  });
}
