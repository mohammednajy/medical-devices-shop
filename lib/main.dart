import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/services.dart';
import 'core/router/router.dart';
import 'core/router/routers_name.dart';
import 'core/router/routes.dart';
import 'core/services/local_services/shared_perf.dart';
import 'core/utils/theme_manager.dart';
import 'firebase_options.dart';
// ignore: depend_on_referenced_packages
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:medical_devices_app/modules/category/controller/category_controller.dart';
import 'package:medical_devices_app/modules/home/controller/home_controller.dart';
import 'package:medical_devices_app/modules/order/controller/order_controller.dart';
import 'package:medical_devices_app/modules/profile/controller/profile_controller.dart';
import 'package:provider/provider.dart';
import 'core/services/remote_services/firebase_init.dart';
// ignore: depend_on_referenced_packages
import 'package:flutter_native_splash/flutter_native_splash.dart';

void main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  await SharedPrefController().init();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  setUp();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitDown,
    DeviceOrientation.portraitUp,
  ]);
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => CategoryController()),
        ChangeNotifierProvider(create: (context) => HomeController()),
        ChangeNotifierProvider(create: (context) => OrderController()),
        ChangeNotifierProvider(create: (context) => ProfileController()),
      ],
      child: const MyApp(),
    ),
  );
  FlutterNativeSplash.remove();
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeManager.lightTheme,
      initialRoute: SharedPrefController().getOnBoarding()
          ? SharedPrefController().getLoggedIn()
              ? RouteName.mainAppView
              : RouteName.auth
          : RouteName.onboarding,
      onGenerateRoute: RouteGenerator.generateRoutes,
      navigatorKey: NavigationManager.navigatorKey,
      supportedLocales: const [
        Locale('en'),
        Locale('ar'),
      ],
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      locale: const Locale('ar'),
    );
  }
}
