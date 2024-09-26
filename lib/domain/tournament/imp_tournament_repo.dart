// Package imports:

import 'package:dio/dio.dart';
import 'package:yoursportz/domain/tournament/tournaments_entity.dart';

abstract class ImpTournamentRepository {
  Future<Response> getTournamentsList({required String phoneNumber});
  Future<Response> updateTournamentData({
    required String bannerImage,
    required String logoImage,
    required String tournamentName,
    required String orgName,
    required String orgContact,
    required String location,
    required String groundName,
    required String numberOfTeams,
    required String numberOfGroup,
    required String startDate,
    required String endDate,
    required String gameTime,
    required String halfTime,
    required String addMoreDetails,
    required String tournamentId,
  });

  Future<Response> addTeamToTournament(
      {required String tournamentId, required List<TeamModel> teamList});
}
