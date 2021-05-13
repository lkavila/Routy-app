import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:integration_test/integration_test.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_config/flutter_config.dart';
import 'package:get_storage/get_storage.dart';
import 'package:routy_app_v102/Presentation/pages/wrapper.dart';
import 'package:routy_app_v102/Presentation/widgets/vehicle_card.dart';

Future<Widget> createHomeScreen() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await FirebaseAuth.instance.signOut();
  await GetStorage.init();
  await FlutterConfig.loadEnvVariables();
  return GetMaterialApp(home: Wrapper());
}

void main() {
  group('Vehicle test', () {
    final binding = IntegrationTestWidgetsFlutterBinding.ensureInitialized()
        as IntegrationTestWidgetsFlutterBinding;

    binding.framePolicy = LiveTestWidgetsFlutterBindingFramePolicy.fullyLive;

    testWidgets('delete all cars', (tester) async {

      Widget w = await createHomeScreen();
      await tester.pumpWidget(w);

      expect(find.byKey(Key("login")), findsOneWidget); //en caso de que se necesite loguearse

      await tester.tap(find.byKey(Key("login_with_google")));

      await tester.pumpAndSettle(Duration(seconds: 5));
      
      expect(find.byType(TabBarView), findsOneWidget);

      final Finder locateDrawer = find.byTooltip('Open navigation menu');

      // Open the drawer
      await tester.tap(locateDrawer);
      await tester.pump();
      
      expect(find.byType(ListTile), findsNWidgets(6));

      expect(find.byKey(Key("Mis vehículos")), findsOneWidget);

      await tester.pumpAndSettle();
      await tester.tap(find.byKey(Key("Mis vehículos")));
      await tester.pumpAndSettle();

      expect(find.text('Mis vehículos'), findsOneWidget);

      await tester.pumpAndSettle();
      await tester.tap(find.byKey(Key("Boton eliminar")));

      await tester.pumpAndSettle(Duration(seconds: 2));
      expect(find.text("Si, eliminar"), findsOneWidget);

      await tester.pumpAndSettle(Duration(seconds: 2));
      await tester.tap(find.text("Si, eliminar"));

      await tester.pumpAndSettle(Duration(seconds: 2));
      expect(find.byType(ListView), findsNothing);

    });

    testWidgets('create new car', (tester) async {

      Widget w = await createHomeScreen();
      await tester.pumpWidget(w);

      expect(find.byKey(Key("login")), findsOneWidget); //en caso de que se necesite loguearse

      await tester.tap(find.byKey(Key("login_with_google")));

      await tester.pumpAndSettle(Duration(seconds: 5));
      
      expect(find.byType(TabBarView), findsOneWidget);

      final Finder locateDrawer = find.byTooltip('Open navigation menu');

      // Open the drawer
      await tester.tap(locateDrawer);
      await tester.pump();
      
      expect(find.byType(ListTile), findsNWidgets(6));

      expect(find.byKey(Key("Mis vehículos")), findsOneWidget);

      await tester.pumpAndSettle();
      await tester.tap(find.byKey(Key("Mis vehículos")));
      await tester.pumpAndSettle();

      expect(find.text('Mis vehículos'), findsOneWidget);

      await tester.pumpAndSettle();
      await tester.tap(find.byKey(Key("GoToCrearVehiculo")));

      await tester.pumpAndSettle();
      await tester.enterText(find.byKey(Key("NombreVehículo")), 'A new vehicle');

      await tester.pumpAndSettle();
      await tester.enterText(find.byKey(Key("Combustible")), '5');

      await tester.pumpAndSettle(Duration(seconds: 2));
      await tester.tap(find.byKey(Key("CrearNuevoVehiculo")));

      await tester.pumpAndSettle(Duration(seconds: 2));
      expect(find.byType(VehicleCard), findsOneWidget);

    });

    testWidgets('edit a car', (tester) async {

      Widget w = await createHomeScreen();
      await tester.pumpWidget(w);

      expect(find.byKey(Key("login")), findsOneWidget); //en caso de que se necesite loguearse

      await tester.tap(find.byKey(Key("login_with_google")));

      await tester.pumpAndSettle(Duration(seconds: 5));
      
      expect(find.byType(TabBarView), findsOneWidget);

      final Finder locateDrawer = find.byTooltip('Open navigation menu');

      // Open the drawer
      await tester.tap(locateDrawer);
      await tester.pump();
      
      expect(find.byType(ListTile), findsNWidgets(6));

      expect(find.byKey(Key("Mis vehículos")), findsOneWidget);

      await tester.pumpAndSettle();
      await tester.tap(find.byKey(Key("Mis vehículos")));
      await tester.pumpAndSettle();

      expect(find.text('Mis vehículos'), findsOneWidget);

      await tester.pumpAndSettle();
      await tester.tap(find.byKey(Key("editarVehiculo1")));

      await tester.pumpAndSettle();
      await tester.enterText(find.byKey(Key("NombreEditarVehículo")), 'A new vehicle edited');

      await tester.pumpAndSettle();
      await tester.enterText(find.byKey(Key("EditarCombustible")), '3');

      await tester.pumpAndSettle(Duration(seconds: 2));
      await tester.tap(find.byKey(Key("EditarVehiculo")));

      await tester.pumpAndSettle(Duration(seconds: 2));
      expect(find.byType(VehicleCard), findsOneWidget);

    });
    
  });
}