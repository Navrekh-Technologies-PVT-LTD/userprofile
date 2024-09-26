import 'package:provider/provider.dart';
import 'package:yoursportz/injection/injection.dart';
import 'package:yoursportz/providers/appbase/app_base_provider.dart';
import 'package:yoursportz/providers/auth/auth_provider.dart';
import 'package:yoursportz/providers/common/common_provider.dart';
import 'package:yoursportz/providers/onboarding/onboarding_provider.dart';
import 'package:yoursportz/providers/splash/splash_provider.dart';
import 'package:yoursportz/providers/tournament/start_match_vm.dart';
import 'package:yoursportz/providers/tournament/tournament_provider.dart';

final providers = [
  ChangeNotifierProvider<SplashProvider>(
    create: (context) => getIt<SplashProvider>(),
    lazy: false,
  ),
  ChangeNotifierProvider<AppBaseProvider>(
    create: (context) => getIt<AppBaseProvider>(),
    lazy: false,
  ),
  ChangeNotifierProvider<OnboardingProvider>(
    create: (context) => getIt<OnboardingProvider>(),
    lazy: false,
  ),
  ChangeNotifierProvider<CommonProvider>(
    create: (context) => getIt<CommonProvider>(),
    lazy: false,
  ),
  ChangeNotifierProvider<AuthenticationProvider>(
    create: (context) => getIt<AuthenticationProvider>(),
    lazy: false,
  ),
  ChangeNotifierProvider<TournamentProvider>(
    create: (context) => getIt<TournamentProvider>(),
    lazy: false,
  ),
  ChangeNotifierProvider<StartMatchVM>(create: (context) => StartMatchVM()),
];
