// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;
import 'package:yoursportz/core/api_client.dart' as _i566;
import 'package:yoursportz/domain/authentication/imp_auth_repo.dart' as _i735;
import 'package:yoursportz/domain/home/imp_home_repo.dart' as _i383;
import 'package:yoursportz/domain/post/imp_post_repo.dart' as _i808;
import 'package:yoursportz/domain/profile/imp_profile_repo.dart' as _i114;
import 'package:yoursportz/domain/tournament/imp_tournament_repo.dart' as _i561;
import 'package:yoursportz/infrastructure/authentication/authentication_repository.dart'
    as _i731;
import 'package:yoursportz/infrastructure/home/home_repository.dart' as _i169;
import 'package:yoursportz/infrastructure/post/post_repository.dart' as _i190;
import 'package:yoursportz/infrastructure/profile/profile_repository.dart'
    as _i266;
import 'package:yoursportz/infrastructure/tournament/tournament_repository.dart'
    as _i172;
import 'package:yoursportz/providers/appbase/app_base_provider.dart' as _i406;
import 'package:yoursportz/providers/auth/auth_provider.dart' as _i680;
import 'package:yoursportz/providers/common/common_provider.dart' as _i382;
import 'package:yoursportz/providers/onboarding/onboarding_provider.dart'
    as _i339;
import 'package:yoursportz/providers/splash/splash_provider.dart' as _i229;
import 'package:yoursportz/providers/tournament/tournament_provider.dart'
    as _i175;

extension GetItInjectableX on _i174.GetIt {
// initializes the registration of main-scope dependencies inside of GetIt
  _i174.GetIt init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i526.GetItHelper(
      this,
      environment,
      environmentFilter,
    );
    gh.factory<_i566.APIClient>(() => _i566.APIClient());
    gh.factory<_i229.SplashProvider>(() => _i229.SplashProvider());
    gh.factory<_i680.AuthenticationProvider>(
        () => _i680.AuthenticationProvider());
    gh.factory<_i406.AppBaseProvider>(() => _i406.AppBaseProvider());
    gh.factory<_i382.CommonProvider>(() => _i382.CommonProvider());
    gh.factory<_i339.OnboardingProvider>(() => _i339.OnboardingProvider());
    gh.lazySingleton<_i561.ImpTournamentRepository>(
        () => _i172.TournamentRepository(gh<_i566.APIClient>()));
    gh.lazySingleton<_i114.ImpProfileRepository>(
        () => _i266.ProfileRepo(gh<_i566.APIClient>()));
    gh.lazySingleton<_i735.ImpAuthRepository>(
        () => _i731.AuthenticationRepo(gh<_i566.APIClient>()));
    gh.lazySingleton<_i808.ImpPostRepository>(
        () => _i190.PostRepo(gh<_i566.APIClient>()));
    gh.lazySingleton<_i383.ImpHomeRepository>(
        () => _i169.HomeRepo(gh<_i566.APIClient>()));
    gh.factory<_i175.TournamentProvider>(
        () => _i175.TournamentProvider(gh<_i561.ImpTournamentRepository>()));
    return this;
  }
}
