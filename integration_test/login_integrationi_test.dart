import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:foodex_app/app/theme/theme.dart';
import 'package:foodex_app/screen/export_screen.dart';
import 'package:get/get.dart';
import 'package:integration_test/integration_test.dart';
import 'package:provider/provider.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  // test('Demo', () async {
  //   bool expectedResult = true;
  //   String phoneNumber = "9808792437";
  //   String password = "password123";
  //   bool actualResult = await UserAPI().loginUser(phoneNumber, password);

  //   expect(actualResult, expectedResult);
  // });

  testWidgets('Automate Login User Test', (WidgetTester tester) async {
    await tester.pumpWidget(ChangeNotifierProvider(
        create: (context) => ThemeProvider(),
        builder: (context, _) {
          final themeProvider = Provider.of<ThemeProvider>(context);
          return GetMaterialApp(
            debugShowCheckedModeBanner: false,
            themeMode: themeProvider.themeMode,
            theme: MyThemes.lightTheme,
            darkTheme: MyThemes.darkTheme,
            home: const LoginScreen(),
          );
        }));

    await tester.pumpAndSettle(const Duration(seconds: 10));
    String phone = "1234567890";
    String password = "k1234567890";

    Finder phoneKey = find.byKey(const ValueKey("phoneNumberKey"));
    await tester.enterText(phoneKey, phone);

    Finder passwordKey = find.byKey(const ValueKey("passwordKey"));
    await tester.enterText(passwordKey, password);

    Finder btnLogin = find.byType(ElevatedButton);
    await tester.tap(btnLogin);

    await tester.pumpAndSettle(const Duration(seconds: 8));

    Finder dashboard = find.byType(Scaffold);
    expect(dashboard, findsOneWidget);
  });
}
