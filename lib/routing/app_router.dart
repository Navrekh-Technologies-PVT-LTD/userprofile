import 'package:auto_route/auto_route.dart';

import 'app_router.gr.dart';

@AutoRouterConfig(replaceInRouteName: 'Screen,Route')
class AppRouter extends $AppRouter {
  @override
  List<AutoRoute> get routes => [
        AutoRoute(page: SplashRoute.page, path: "/splashRoute", initial: true),
        AutoRoute(page: OnboardingRoute.page, path: "/onboardingRoute"),
        AutoRoute(page: OtpRoute.page, path: "/otpRoute"),
        AutoRoute(page: LoginRoute.page, path: "/loginRoute"),
        AutoRoute(page: UserDetailsRoute.page, path: "/userDetailsRoute"),
        AutoRoute(page: ChangeLanguageRoute.page, path: "/changeLanguageRoute"),
        AutoRoute(
            page: AddTeamsToTournamentRoute.page,
            path: "/addTeamsToTournamentRoute"),
        AutoRoute(
            page: OngoingTournamentRoute.page, path: "/ongoingTournamentRoute"),
        AutoRoute(
            page: TournamentRulesRoute.page, path: "/tournamentRulesRoute"),
        AutoRoute(
            page: CreateTournamentRoute.page, path: "/createTournamentRoute"),
        AutoRoute(
            page: OngoingTournamentRoute.page, path: "/OngoingTournamentRoute"),
        AutoRoute(
          page: AppBaseRoute.page,
          path: "/appBaseRoute",
          children: [
            AutoRoute(page: HomeRoute.page, path: "homeRoute"),
            AutoRoute(page: SearchRoute.page, path: "searchRoute"),
            AutoRoute(page: MyFootballRoute.page, path: "myFootballRoute"),
            AutoRoute(page: ProfileRoute.page, path: "profileRoute"),
            AutoRoute(page: ClipsRoute.page, path: "clipsRoute"),
          ],
        ),
      ];
}
