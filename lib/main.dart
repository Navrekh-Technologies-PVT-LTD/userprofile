import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive/hive.dart';
import 'package:injectable/injectable.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:yoursportz/core/prefs.dart';
import 'package:yoursportz/firebase_options.dart';
import 'package:yoursportz/gen/codegen_loader.g.dart';
import 'package:yoursportz/injection/injection.dart';
import 'package:yoursportz/providers/provider.dart';
import 'package:yoursportz/routing/app_router.dart';

void main() async {
  configureInjection(Environment.test);
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  await setupLocator();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  var directory = await getApplicationDocumentsDirectory();
  Hive.init(directory.path);
  await Hive.openBox('CurrentUser');

  runApp(
    EasyLocalization(
      supportedLocales: const [
        Locale('ar'), // Arabic
        Locale('pt', 'BR'), // Brazilian Portuguese
        Locale('en'), // English
        Locale('fr'), // French
        Locale('hi'), // Hindi
        Locale('pt'), // Portuguese
        Locale('es'), // Spanish
        Locale('ur'), // Urdu
      ],
      path: 'assets/languages',
      fallbackLocale: const Locale('en'),
      assetLoader: const CodegenLoader(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final _appRouter = AppRouter();

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: List.from(providers),
      child: ScreenUtilInit(
        designSize: const Size(375, 812),
        minTextAdapt: true,
        builder: (context, child) {
          return MaterialApp.router(
            localizationsDelegates: context.localizationDelegates,
            supportedLocales: context.supportedLocales,
            locale: context.locale,
            debugShowCheckedModeBanner: false,
            routerDelegate: _appRouter.delegate(),
            routeInformationParser: _appRouter.defaultRouteParser(),
            title: "YourSportz",
          );
        },
      ),
    );
  }
}
