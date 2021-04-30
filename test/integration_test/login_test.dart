import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:integration_test/integration_test.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_config/flutter_config.dart';
import 'package:get_storage/get_storage.dart';
import 'package:routy_app_v102/Presentation/pages/wrapper.dart';
import 'package:routy_app_v102/Presentation/widgets/hidden_drawer_menu.dart';

Future<Widget> createHomeScreen() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await GetStorage.init();
  await FlutterConfig.loadEnvVariables();
  return GetMaterialApp(home: Wrapper());
}

void main() {
  group('Integration test', () {
    final binding = IntegrationTestWidgetsFlutterBinding.ensureInitialized()
        as IntegrationTestWidgetsFlutterBinding;

    binding.framePolicy = LiveTestWidgetsFlutterBindingFramePolicy.fullyLive;

    testWidgets('login with google', (tester) async {

      Widget w = await createHomeScreen();
      //final scaffoldKey = GlobalKey<ScaffoldState>();
      await tester.pumpWidget(w);

      expect(find.byKey(Key("login")), findsOneWidget);

      await tester.tap(find.byKey(Key("login_with_google")));

      await tester.pumpAndSettle(Duration(seconds: 5));

      expect(find.byType(TabBarView), findsOneWidget);

      final Finder locateDrawer = find.byTooltip('Open navigation menu');

      // Open the drawer
      await tester.tap(locateDrawer);
      await tester.pump();
      
      expect(find.byType(ListTile), findsNWidgets(6));

      expect(find.byKey(Key("LogOut")), findsOneWidget);

      await tester.tap(find.byKey(Key("LogOut")));

      await tester.pumpAndSettle(Duration(seconds: 5));

      expect(find.byKey(Key("login")), findsOneWidget);

      await tester.tap(find.byKey(Key("login_with_facebook")));

      await tester.pumpAndSettle(Duration(seconds: 5));

      expect(find.byType(TabBarView), findsOneWidget);
 /*     await tester.pumpWidget(
        GetMaterialApp(
          home: 
            Scaffold(
            key: scaffoldKey,
            drawer: DrawerMenu(),
        )));

      scaffoldKey.currentState.openDrawer();

      await tester.pump();
      print("drawer abierto");
      expect(find.byType(ListTile), findsNWidgets(6));
      print("6");
      expect(find.byKey(Key("LogOut")), findsOneWidget);
      print("Encontro logout");
      await tester.tap(find.byKey(Key("LogOut")));
      print("tap on logout");
      await tester.pumpAndSettle(Duration(seconds: 5));
*/

    });
/*
    testWidgets('Login with facebook', (tester) async {
      Widget w = await createHomeScreen();
      await tester.pumpWidget(w);


    });
*/
  });
}