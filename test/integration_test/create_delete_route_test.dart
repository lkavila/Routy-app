import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:integration_test/integration_test.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_config/flutter_config.dart';
import 'package:get_storage/get_storage.dart';
import 'package:routy_app_v102/Presentation/pages/wrapper.dart';
import 'package:routy_app_v102/Presentation/widgets/routes/route_card.dart';

Future<Widget> createHomeScreen() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await FirebaseAuth.instance.signOut();
  await GetStorage.init();
  await FlutterConfig.loadEnvVariables();
  return GetMaterialApp(home: Wrapper());
}

void main() {
  group(' delete, Create and make frecuent a route test', () {
    final binding = IntegrationTestWidgetsFlutterBinding.ensureInitialized()
        as IntegrationTestWidgetsFlutterBinding;

    binding.framePolicy = LiveTestWidgetsFlutterBindingFramePolicy.fullyLive;

    testWidgets('create a route', (tester) async {

      Widget w = await createHomeScreen();
      //final scaffoldKey = GlobalKey<ScaffoldState>();
      await tester.pumpWidget(w);

      expect(find.byKey(Key("login")), findsOneWidget);

      await tester.tap(find.byKey(Key("login_with_google")));

      await tester.pumpAndSettle(Duration(seconds: 2));

      expect(find.byType(TabBarView), findsOneWidget);

      final Finder locateDrawer = find.byTooltip('Open navigation menu');

      await tester.tap(find.byKey(Key("GoToMpap")));
      await tester.pumpAndSettle(Duration(seconds: 5));

      expect(find.byKey(Key("Mapa")), findsOneWidget);

      await tester.pumpAndSettle(Duration(seconds: 7));
      await tester.tap(find.byKey(Key("Mapa")));

      await tester.pumpAndSettle(Duration(seconds: 7));
      await tester.drag(find.byKey(Key("Mapa")), Offset(-10, 290));
      await tester.pumpAndSettle(Duration(seconds: 5));
      await tester.tap(find.byKey(Key("Mapa")));

      await tester.pumpAndSettle(Duration(seconds: 3));
      await tester.tap(find.byKey(Key("Mapa")));

      await tester.pumpAndSettle(Duration(seconds: 7));
      await tester.tap(find.byKey(Key("Ver ruta optima")));
      await tester.pumpAndSettle();

      expect(find.byKey(Key("Not Enough Routes")), findsNothing);
      
      await tester.tap(find.text("No"));
      await tester.pumpAndSettle(Duration(seconds: 10));

      expect(find.byKey(Key("RutaCalculada")), findsOneWidget);

      await tester.pumpAndSettle(Duration(seconds: 2));
      await tester.tap(find.byIcon(Icons.save));

      await tester.pumpAndSettle(Duration(seconds: 3));
            // Open the drawer
      await tester.tap(find.byKey(Key("OpenCustumDrawer")));
      await tester.pump();
      
      expect(find.byType(ListTile), findsNWidgets(6));

      expect(find.byKey(Key("Mis rutas")), findsOneWidget);

      await tester.pumpAndSettle();
      await tester.tap(find.byKey(Key("Mis rutas")));

      await tester.pumpAndSettle(Duration(seconds: 2));
      expect(find.byType(TabBarView), findsOneWidget);

      await tester.pumpAndSettle(Duration(seconds: 2));      
      await tester.tap(find.byIcon(Icons.watch_later_rounded));

      await tester.pumpAndSettle(Duration(seconds: 2));
      await tester.tap(find.byKey(Key("DeleteAllRoutes2")));

      await tester.pumpAndSettle(Duration(seconds: 2)); 
      await tester.tap(find.text("Si"));

      await tester.pumpAndSettle(Duration(seconds: 3)); 

      // Open the drawer
      await tester.tap(locateDrawer);
      await tester.pump();
      
      expect(find.byType(ListTile), findsNWidgets(6));

      expect(find.byKey(Key("Inicio")), findsOneWidget);

      await tester.pumpAndSettle();
      await tester.tap(find.byKey(Key("Inicio")));
      
      await tester.pumpAndSettle(Duration(seconds: 5));
      expect(find.byKey(Key("Mapa")), findsOneWidget);

      await tester.pumpAndSettle(Duration(seconds: 7));
      await tester.drag(find.byKey(Key("Mapa")), Offset(-10, 140));
      await tester.tap(find.byKey(Key("Mapa")));

      await tester.pumpAndSettle(Duration(seconds: 3));
      await tester.tap(find.byKey(Key("Mapa")));

      await tester.pumpAndSettle(Duration(seconds: 5));
      await tester.tap(find.byKey(Key("Ver ruta optima")));
      await tester.pumpAndSettle();

      expect(find.byKey(Key("Not Enough Routes")), findsNothing);
      
      await tester.tap(find.text("No"));
      await tester.pumpAndSettle(Duration(seconds: 5));

      expect(find.byKey(Key("RutaCalculada")), findsOneWidget);

      await tester.pumpAndSettle(Duration(seconds: 2));
      await tester.tap(find.byKey(Key("Elegir vehiculo")));

      await tester.pumpAndSettle(Duration(seconds: 2));
      await tester.tap(find.text("Iniciar ruta"));

      await tester.pumpAndSettle(Duration(seconds: 3));
      expect(find.byKey(Key("En camino")), findsOneWidget);

            // Open the drawer
      await tester.tap(find.byKey(Key("OpenCustumDrawer")));
      await tester.pump();
      
      expect(find.byType(ListTile), findsNWidgets(6));

      expect(find.byKey(Key("Mis rutas")), findsOneWidget);

      await tester.pumpAndSettle();
      await tester.tap(find.byKey(Key("Mis rutas")));

      await tester.pumpAndSettle(Duration(seconds: 2));
      expect(find.byType(TabBarView), findsOneWidget);

      await tester.pumpAndSettle(Duration(seconds: 1));
      await tester.tap(find.byIcon(Icons.watch_later_rounded));

            // Open the drawer
      await tester.tap(locateDrawer);
      await tester.pump();
      
      expect(find.byType(ListTile), findsNWidgets(6));

      expect(find.byKey(Key("Inicio")), findsOneWidget);

      await tester.pumpAndSettle();
      await tester.tap(find.byKey(Key("Inicio")));

      await tester.pumpAndSettle(Duration(seconds: 3));
      await tester.tap(find.byIcon(Icons.cancel));

      await tester.pumpAndSettle(Duration(seconds: 3));
      await tester.tap(find.byKey(Key("Cancelar ruta")));

      await tester.pumpAndSettle(Duration(seconds: 3));
      await tester.tap(find.byIcon(Icons.save));

      await tester.pumpAndSettle(Duration(seconds: 3));
            // Open the drawer
      await tester.tap(find.byKey(Key("OpenCustumDrawer")));
      await tester.pump();
      
      expect(find.byType(ListTile), findsNWidgets(6));

      expect(find.byKey(Key("Mis rutas")), findsOneWidget);

      await tester.pumpAndSettle();
      await tester.tap(find.byKey(Key("Mis rutas")));

      await tester.pumpAndSettle(Duration(seconds: 2));
      expect(find.byType(TabBarView), findsOneWidget);
      expect(find.byType(RouteCard), findsOneWidget);

    });
    
  });
}