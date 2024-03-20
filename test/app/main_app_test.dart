import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:formulario_curso/app/main_app.dart';

void main() {
  testWidgets('Na inicialização, o tema do app deve ser o tema escuro', (tester) async {
    await tester.pumpWidget(MainApp());

    expect(find.byIcon(Icons.light_mode_rounded), findsOneWidget);
  });

  testWidgets(
      'Dado que estamos no tema escuro, '
      'ao tocar no botão de trocar de tema, '
      'ele deve ser trocado para o tema claro', (tester) async {
    await tester.pumpWidget(MainApp());

    final lightModeIcon = find.byIcon(Icons.light_mode_rounded);

    expect(lightModeIcon, findsOneWidget);

    await tester.tap(lightModeIcon);

    await tester.pump();

    final darkModeIcon = find.byIcon(Icons.dark_mode_rounded);

    expect(lightModeIcon, findsNothing);
    expect(darkModeIcon, findsOneWidget);
  });

  testWidgets(
      'Dado que inicializo a tela, '
      'ao tocar no botão de continuar, '
      'mensagens de erro para nome, email e telefone devem aparecer', (tester) async {
    await tester.pumpWidget(MainApp());

    const nameMessage = 'Insira o nome';
    const emailMessage = 'Digite um e-mail';
    const phoneMessage = 'Insira o telefone';

    expect(find.text(nameMessage), findsNothing);
    expect(find.text(emailMessage), findsNothing);
    expect(find.text(phoneMessage), findsNothing);

    await tester.tap(find.text('Continuar'));

    await tester.pump();

    expect(find.text(nameMessage), findsOne);
    expect(find.text(emailMessage), findsOne);
    expect(find.text(phoneMessage), findsOne);
  });

  testWidgets(
      'Dado que digitei um nome no campo Email, '
      'ao apagar todo conteúdo, '
      'deve aparecer uma mensagem de erro para o campo Email', (tester) async {
    await tester.pumpWidget(MainApp());

    const emailMessage = 'Digite um e-mail';

    await tester.enterText(find.byKey(const Key('EmailFormField')), 'email');

    await tester.pump();

    await tester.enterText(find.byKey(const Key('EmailFormField')), '');

    await tester.pump();

    expect(find.text(emailMessage), findsOne);
  });

  testWidgets(
      'Dado que digitei um nome no campo Nome, '
      'ao apagar todo conteúdo, '
      'deve aparecer uma mensagem de erro para o campo Nome', (tester) async {
    await tester.pumpWidget(MainApp());

    const nameMessage = 'Insira o nome';

    await tester.enterText(find.byKey(const Key('NameFormField')), 'nome de usuário');

    await tester.pump();

    await tester.enterText(find.byKey(const Key('NameFormField')), '');

    await tester.pump();

    expect(find.text(nameMessage), findsOne);
  });
}
