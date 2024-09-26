// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i18;
import 'package:flutter/material.dart' as _i19;
import 'package:yoursportz/domain/tournament/tournaments_entity.dart' as _i20;
import 'package:yoursportz/presentation/appbase/app_base_screen.dart' as _i2;
import 'package:yoursportz/presentation/auth/login_screen.dart' as _i7;
import 'package:yoursportz/presentation/auth/otp_screen.dart' as _i11;
import 'package:yoursportz/presentation/auth/user_details_screen.dart' as _i17;
import 'package:yoursportz/presentation/clips/clips_screen.dart' as _i4;
import 'package:yoursportz/presentation/home/home_screen.dart' as _i6;
import 'package:yoursportz/presentation/myfootball/my_football_screen.dart'
    as _i8;
import 'package:yoursportz/presentation/onboarding/onboarding_screen.dart'
    as _i9;
import 'package:yoursportz/presentation/onboarding/select_language.dart'
    as _i14;
import 'package:yoursportz/presentation/profile/change_language_screen.dart'
    as _i3;
import 'package:yoursportz/presentation/profile/profile_screen.dart' as _i12;
import 'package:yoursportz/presentation/search/search_screen.dart' as _i13;
import 'package:yoursportz/presentation/splash/splash_screen.dart' as _i15;
import 'package:yoursportz/presentation/tournament/start-tournament/add_teams_tournament.dart'
    as _i1;
import 'package:yoursportz/presentation/tournament/start-tournament/create_tournament_screen.dart'
    as _i5;
import 'package:yoursportz/presentation/tournament/start-tournament/ongoing_tournaments.dart'
    as _i10;
import 'package:yoursportz/presentation/tournament/start-tournament/tournament_rules.dart'
    as _i16;

abstract class $AppRouter extends _i18.RootStackRouter {
  $AppRouter({super.navigatorKey});

  @override
  final Map<String, _i18.PageFactory> pagesMap = {
    AddTeamsToTournamentRoute.name: (routeData) {
      final args = routeData.argsAs<AddTeamsToTournamentRouteArgs>();
      return _i18.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i1.AddTeamsToTournamentScreen(
          key: args.key,
          phone: args.phone,
          tournamentId: args.tournamentId,
          numberofteams: args.numberofteams,
          tournamentData: args.tournamentData,
        ),
      );
    },
    AppBaseRoute.name: (routeData) {
      final args = routeData.argsAs<AppBaseRouteArgs>();
      return _i18.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i2.AppBaseScreen(
          key: args.key,
          phone: args.phone,
        ),
      );
    },
    ChangeLanguageRoute.name: (routeData) {
      return _i18.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i3.ChangeLanguageScreen(),
      );
    },
    ClipsRoute.name: (routeData) {
      return _i18.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i4.ClipsScreen(),
      );
    },
    CreateTournamentRoute.name: (routeData) {
      final args = routeData.argsAs<CreateTournamentRouteArgs>();
      return _i18.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i5.CreateTournamentScreen(
          key: args.key,
          phone: args.phone,
          isEdit: args.isEdit,
          tournamentId: args.tournamentId,
        ),
      );
    },
    HomeRoute.name: (routeData) {
      return _i18.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i6.HomeScreen(),
      );
    },
    LoginRoute.name: (routeData) {
      return _i18.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i7.LoginScreen(),
      );
    },
    MyFootballRoute.name: (routeData) {
      return _i18.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i8.MyFootballScreen(),
      );
    },
    OnboardingRoute.name: (routeData) {
      return _i18.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i9.OnboardingScreen(),
      );
    },
    OngoingTournamentRoute.name: (routeData) {
      final args = routeData.argsAs<OngoingTournamentRouteArgs>();
      return _i18.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i10.OngoingTournamentScreen(
          key: args.key,
          phone: args.phone,
        ),
      );
    },
    OtpRoute.name: (routeData) {
      final args = routeData.argsAs<OtpRouteArgs>();
      return _i18.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i11.OtpScreen(
          key: args.key,
          countryCode: args.countryCode,
          phone: args.phone,
        ),
      );
    },
    ProfileRoute.name: (routeData) {
      final args = routeData.argsAs<ProfileRouteArgs>();
      return _i18.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i12.ProfileScreen(
          key: args.key,
          phone: args.phone,
        ),
      );
    },
    SearchRoute.name: (routeData) {
      return _i18.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i13.SearchScreen(),
      );
    },
    SelectLanguageRoute.name: (routeData) {
      return _i18.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i14.SelectLanguageScreen(),
      );
    },
    SplashRoute.name: (routeData) {
      return _i18.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i15.SplashScreen(),
      );
    },
    TournamentRulesRoute.name: (routeData) {
      final args = routeData.argsAs<TournamentRulesRouteArgs>();
      return _i18.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i16.TournamentRulesScreen(
          key: args.key,
          phone: args.phone,
          tournamentId: args.tournamentId,
          numberofteams: args.numberofteams,
        ),
      );
    },
    UserDetailsRoute.name: (routeData) {
      final args = routeData.argsAs<UserDetailsRouteArgs>();
      return _i18.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i17.UserDetailsScreen(
          key: args.key,
          language: args.language,
          phone: args.phone,
        ),
      );
    },
  };
}

/// generated route for
/// [_i1.AddTeamsToTournamentScreen]
class AddTeamsToTournamentRoute
    extends _i18.PageRouteInfo<AddTeamsToTournamentRouteArgs> {
  AddTeamsToTournamentRoute({
    _i19.Key? key,
    required String phone,
    required String tournamentId,
    required String numberofteams,
    required _i20.TournamentData tournamentData,
    List<_i18.PageRouteInfo>? children,
  }) : super(
          AddTeamsToTournamentRoute.name,
          args: AddTeamsToTournamentRouteArgs(
            key: key,
            phone: phone,
            tournamentId: tournamentId,
            numberofteams: numberofteams,
            tournamentData: tournamentData,
          ),
          initialChildren: children,
        );

  static const String name = 'AddTeamsToTournamentRoute';

  static const _i18.PageInfo<AddTeamsToTournamentRouteArgs> page =
      _i18.PageInfo<AddTeamsToTournamentRouteArgs>(name);
}

class AddTeamsToTournamentRouteArgs {
  const AddTeamsToTournamentRouteArgs({
    this.key,
    required this.phone,
    required this.tournamentId,
    required this.numberofteams,
    required this.tournamentData,
  });

  final _i19.Key? key;

  final String phone;

  final String tournamentId;

  final String numberofteams;

  final _i20.TournamentData tournamentData;

  @override
  String toString() {
    return 'AddTeamsToTournamentRouteArgs{key: $key, phone: $phone, tournamentId: $tournamentId, numberofteams: $numberofteams, tournamentData: $tournamentData}';
  }
}

/// generated route for
/// [_i2.AppBaseScreen]
class AppBaseRoute extends _i18.PageRouteInfo<AppBaseRouteArgs> {
  AppBaseRoute({
    _i19.Key? key,
    required String phone,
    List<_i18.PageRouteInfo>? children,
  }) : super(
          AppBaseRoute.name,
          args: AppBaseRouteArgs(
            key: key,
            phone: phone,
          ),
          initialChildren: children,
        );

  static const String name = 'AppBaseRoute';

  static const _i18.PageInfo<AppBaseRouteArgs> page =
      _i18.PageInfo<AppBaseRouteArgs>(name);
}

class AppBaseRouteArgs {
  const AppBaseRouteArgs({
    this.key,
    required this.phone,
  });

  final _i19.Key? key;

  final String phone;

  @override
  String toString() {
    return 'AppBaseRouteArgs{key: $key, phone: $phone}';
  }
}

/// generated route for
/// [_i3.ChangeLanguageScreen]
class ChangeLanguageRoute extends _i18.PageRouteInfo<void> {
  const ChangeLanguageRoute({List<_i18.PageRouteInfo>? children})
      : super(
          ChangeLanguageRoute.name,
          initialChildren: children,
        );

  static const String name = 'ChangeLanguageRoute';

  static const _i18.PageInfo<void> page = _i18.PageInfo<void>(name);
}

/// generated route for
/// [_i4.ClipsScreen]
class ClipsRoute extends _i18.PageRouteInfo<void> {
  const ClipsRoute({List<_i18.PageRouteInfo>? children})
      : super(
          ClipsRoute.name,
          initialChildren: children,
        );

  static const String name = 'ClipsRoute';

  static const _i18.PageInfo<void> page = _i18.PageInfo<void>(name);
}

/// generated route for
/// [_i5.CreateTournamentScreen]
class CreateTournamentRoute
    extends _i18.PageRouteInfo<CreateTournamentRouteArgs> {
  CreateTournamentRoute({
    _i19.Key? key,
    required String phone,
    bool isEdit = false,
    String? tournamentId,
    List<_i18.PageRouteInfo>? children,
  }) : super(
          CreateTournamentRoute.name,
          args: CreateTournamentRouteArgs(
            key: key,
            phone: phone,
            isEdit: isEdit,
            tournamentId: tournamentId,
          ),
          initialChildren: children,
        );

  static const String name = 'CreateTournamentRoute';

  static const _i18.PageInfo<CreateTournamentRouteArgs> page =
      _i18.PageInfo<CreateTournamentRouteArgs>(name);
}

class CreateTournamentRouteArgs {
  const CreateTournamentRouteArgs({
    this.key,
    required this.phone,
    this.isEdit = false,
    this.tournamentId,
  });

  final _i19.Key? key;

  final String phone;

  final bool isEdit;

  final String? tournamentId;

  @override
  String toString() {
    return 'CreateTournamentRouteArgs{key: $key, phone: $phone, isEdit: $isEdit, tournamentId: $tournamentId}';
  }
}

/// generated route for
/// [_i6.HomeScreen]
class HomeRoute extends _i18.PageRouteInfo<void> {
  const HomeRoute({List<_i18.PageRouteInfo>? children})
      : super(
          HomeRoute.name,
          initialChildren: children,
        );

  static const String name = 'HomeRoute';

  static const _i18.PageInfo<void> page = _i18.PageInfo<void>(name);
}

/// generated route for
/// [_i7.LoginScreen]
class LoginRoute extends _i18.PageRouteInfo<void> {
  const LoginRoute({List<_i18.PageRouteInfo>? children})
      : super(
          LoginRoute.name,
          initialChildren: children,
        );

  static const String name = 'LoginRoute';

  static const _i18.PageInfo<void> page = _i18.PageInfo<void>(name);
}

/// generated route for
/// [_i8.MyFootballScreen]
class MyFootballRoute extends _i18.PageRouteInfo<void> {
  const MyFootballRoute({List<_i18.PageRouteInfo>? children})
      : super(
          MyFootballRoute.name,
          initialChildren: children,
        );

  static const String name = 'MyFootballRoute';

  static const _i18.PageInfo<void> page = _i18.PageInfo<void>(name);
}

/// generated route for
/// [_i9.OnboardingScreen]
class OnboardingRoute extends _i18.PageRouteInfo<void> {
  const OnboardingRoute({List<_i18.PageRouteInfo>? children})
      : super(
          OnboardingRoute.name,
          initialChildren: children,
        );

  static const String name = 'OnboardingRoute';

  static const _i18.PageInfo<void> page = _i18.PageInfo<void>(name);
}

/// generated route for
/// [_i10.OngoingTournamentScreen]
class OngoingTournamentRoute
    extends _i18.PageRouteInfo<OngoingTournamentRouteArgs> {
  OngoingTournamentRoute({
    _i19.Key? key,
    required String phone,
    List<_i18.PageRouteInfo>? children,
  }) : super(
          OngoingTournamentRoute.name,
          args: OngoingTournamentRouteArgs(
            key: key,
            phone: phone,
          ),
          initialChildren: children,
        );

  static const String name = 'OngoingTournamentRoute';

  static const _i18.PageInfo<OngoingTournamentRouteArgs> page =
      _i18.PageInfo<OngoingTournamentRouteArgs>(name);
}

class OngoingTournamentRouteArgs {
  const OngoingTournamentRouteArgs({
    this.key,
    required this.phone,
  });

  final _i19.Key? key;

  final String phone;

  @override
  String toString() {
    return 'OngoingTournamentRouteArgs{key: $key, phone: $phone}';
  }
}

/// generated route for
/// [_i11.OtpScreen]
class OtpRoute extends _i18.PageRouteInfo<OtpRouteArgs> {
  OtpRoute({
    _i19.Key? key,
    required String countryCode,
    required String phone,
    List<_i18.PageRouteInfo>? children,
  }) : super(
          OtpRoute.name,
          args: OtpRouteArgs(
            key: key,
            countryCode: countryCode,
            phone: phone,
          ),
          initialChildren: children,
        );

  static const String name = 'OtpRoute';

  static const _i18.PageInfo<OtpRouteArgs> page =
      _i18.PageInfo<OtpRouteArgs>(name);
}

class OtpRouteArgs {
  const OtpRouteArgs({
    this.key,
    required this.countryCode,
    required this.phone,
  });

  final _i19.Key? key;

  final String countryCode;

  final String phone;

  @override
  String toString() {
    return 'OtpRouteArgs{key: $key, countryCode: $countryCode, phone: $phone}';
  }
}

/// generated route for
/// [_i12.ProfileScreen]
class ProfileRoute extends _i18.PageRouteInfo<ProfileRouteArgs> {
  ProfileRoute({
    _i19.Key? key,
    required String phone,
    List<_i18.PageRouteInfo>? children,
  }) : super(
          ProfileRoute.name,
          args: ProfileRouteArgs(
            key: key,
            phone: phone,
          ),
          initialChildren: children,
        );

  static const String name = 'ProfileRoute';

  static const _i18.PageInfo<ProfileRouteArgs> page =
      _i18.PageInfo<ProfileRouteArgs>(name);
}

class ProfileRouteArgs {
  const ProfileRouteArgs({
    this.key,
    required this.phone,
  });

  final _i19.Key? key;

  final String phone;

  @override
  String toString() {
    return 'ProfileRouteArgs{key: $key, phone: $phone}';
  }
}

/// generated route for
/// [_i13.SearchScreen]
class SearchRoute extends _i18.PageRouteInfo<void> {
  const SearchRoute({List<_i18.PageRouteInfo>? children})
      : super(
          SearchRoute.name,
          initialChildren: children,
        );

  static const String name = 'SearchRoute';

  static const _i18.PageInfo<void> page = _i18.PageInfo<void>(name);
}

/// generated route for
/// [_i14.SelectLanguageScreen]
class SelectLanguageRoute extends _i18.PageRouteInfo<void> {
  const SelectLanguageRoute({List<_i18.PageRouteInfo>? children})
      : super(
          SelectLanguageRoute.name,
          initialChildren: children,
        );

  static const String name = 'SelectLanguageRoute';

  static const _i18.PageInfo<void> page = _i18.PageInfo<void>(name);
}

/// generated route for
/// [_i15.SplashScreen]
class SplashRoute extends _i18.PageRouteInfo<void> {
  const SplashRoute({List<_i18.PageRouteInfo>? children})
      : super(
          SplashRoute.name,
          initialChildren: children,
        );

  static const String name = 'SplashRoute';

  static const _i18.PageInfo<void> page = _i18.PageInfo<void>(name);
}

/// generated route for
/// [_i16.TournamentRulesScreen]
class TournamentRulesRoute
    extends _i18.PageRouteInfo<TournamentRulesRouteArgs> {
  TournamentRulesRoute({
    _i19.Key? key,
    required String phone,
    required String tournamentId,
    required String numberofteams,
    List<_i18.PageRouteInfo>? children,
  }) : super(
          TournamentRulesRoute.name,
          args: TournamentRulesRouteArgs(
            key: key,
            phone: phone,
            tournamentId: tournamentId,
            numberofteams: numberofteams,
          ),
          initialChildren: children,
        );

  static const String name = 'TournamentRulesRoute';

  static const _i18.PageInfo<TournamentRulesRouteArgs> page =
      _i18.PageInfo<TournamentRulesRouteArgs>(name);
}

class TournamentRulesRouteArgs {
  const TournamentRulesRouteArgs({
    this.key,
    required this.phone,
    required this.tournamentId,
    required this.numberofteams,
  });

  final _i19.Key? key;

  final String phone;

  final String tournamentId;

  final String numberofteams;

  @override
  String toString() {
    return 'TournamentRulesRouteArgs{key: $key, phone: $phone, tournamentId: $tournamentId, numberofteams: $numberofteams}';
  }
}

/// generated route for
/// [_i17.UserDetailsScreen]
class UserDetailsRoute extends _i18.PageRouteInfo<UserDetailsRouteArgs> {
  UserDetailsRoute({
    _i19.Key? key,
    required String language,
    required String phone,
    List<_i18.PageRouteInfo>? children,
  }) : super(
          UserDetailsRoute.name,
          args: UserDetailsRouteArgs(
            key: key,
            language: language,
            phone: phone,
          ),
          initialChildren: children,
        );

  static const String name = 'UserDetailsRoute';

  static const _i18.PageInfo<UserDetailsRouteArgs> page =
      _i18.PageInfo<UserDetailsRouteArgs>(name);
}

class UserDetailsRouteArgs {
  const UserDetailsRouteArgs({
    this.key,
    required this.language,
    required this.phone,
  });

  final _i19.Key? key;

  final String language;

  final String phone;

  @override
  String toString() {
    return 'UserDetailsRouteArgs{key: $key, language: $language, phone: $phone}';
  }
}
