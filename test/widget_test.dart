import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:misha_flutter/main.dart';
import 'package:misha_flutter/pages/home_page.dart';
import 'package:misha_flutter/pages/profile_page.dart';

void main() {
  testWidgets('Заставка, регистрация, вход, детализация и профиль', (
    tester,
  ) async {
    await tester.binding.setSurfaceSize(const Size(412, 915));
    addTearDown(() => tester.binding.setSurfaceSize(null));

    await tester.pumpWidget(const MyApp());
    expect(find.text('АНТИВИРУСЫ'), findsOneWidget);
    await tester.pump(const Duration(seconds: 3));
    expect(find.text('АНТИВИРУСЫ'), findsOneWidget);
    await tester.pump(const Duration(seconds: 1));
    await tester.pumpAndSettle();
    expect(find.text('Войти'), findsOneWidget);

    await tester.tap(find.text('Зарегистрируйтесь'));
    await tester.pumpAndSettle();
    expect(find.text('Регистрация'), findsOneWidget);
    await tester.tap(find.text('Войдите'));
    await tester.pumpAndSettle();
    expect(find.text('Войти'), findsOneWidget);

    final fields = find.byType(TextFormField);
    await tester.enterText(fields.at(0), 'user@example.com');
    await tester.enterText(fields.at(1), 'Test1+');
    await tester.tap(find.text('Войти'));
    await tester.pumpAndSettle();
    expect(find.text('Популярные антивирусы'), findsOneWidget);
    expect(
      tester.state<NavigatorState>(find.byType(Navigator)).canPop(),
      isFalse,
    );

    await tester.tap(find.text('Dr.Web'));
    await tester.pumpAndSettle();
    expect(find.byType(BackButton), findsOneWidget);
    expect(
      find.text('Проверка файлов и обнаружение вредоносных программ.'),
      findsOneWidget,
    );
    final logo = tester.widget<Image>(find.byType(Image));
    expect((logo.image as AssetImage).assetName, 'assets/images/drweb.png');

    await tester.tap(find.byIcon(Icons.home));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Dr.Web'));
    await tester.pumpAndSettle();
    await tester.tap(find.byIcon(Icons.person_outline).last);
    await tester.pumpAndSettle();
    expect(find.byType(ProfilePage), findsOneWidget);
    expect(find.text('Носков Михаил Сергеевич'), findsOneWidget);

    await tester.tap(find.byIcon(Icons.arrow_circle_left));
    await tester.pumpAndSettle();
    expect(find.byType(HomePage), findsOneWidget);
    expect(tester.takeException(), isNull);
  });

  testWidgets('Каталог меняет число столбцов после 600 пикселей', (
    tester,
  ) async {
    tester.view.devicePixelRatio = 1;
    tester.view.physicalSize = const Size(600, 420);
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);
    await tester.pumpWidget(const MaterialApp(home: HomePage()));
    final grid = find.byType(GridView);
    expect(
      tester.widget<GridView>(grid).gridDelegate,
      isA<SliverGridDelegateWithFixedCrossAxisCount>().having(
        (delegate) => delegate.crossAxisCount,
        'crossAxisCount',
        1,
      ),
    );

    tester.view.physicalSize = const Size(650, 420);
    await tester.pumpAndSettle();
    expect(
      tester.widget<GridView>(grid).gridDelegate,
      isA<SliverGridDelegateWithFixedCrossAxisCount>().having(
        (delegate) => delegate.crossAxisCount,
        'crossAxisCount',
        2,
      ),
    );
    await tester.ensureVisible(find.text('Norton'));
    await tester.pumpAndSettle();
    expect(find.text('Norton').hitTestable(), findsOneWidget);
    expect(tester.takeException(), isNull);
  });
}
