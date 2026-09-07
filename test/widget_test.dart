// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:servicios_modelo_ui/ui/app.dart';

void main() {
  testWidgets('La app carga y muestra el título principal', (tester) async {
    await tester.pumpWidget(const ProviderScope(child: App()));

    expect(find.text('Mis colores'), findsOneWidget);
    expect(find.text('COLORES DE CABELLO'), findsOneWidget);
    expect(find.text('USUARIOS'), findsOneWidget);
  });
}
