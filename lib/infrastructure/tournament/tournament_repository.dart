import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:yoursportz/core/api_client.dart';
import 'package:yoursportz/domain/tournament/imp_tournament_repo.dart';
import 'package:yoursportz/domain/tournament/tournaments_entity.dart';
import 'package:yoursportz/utils/logger.dart';

@LazySingleton(as: ImpTournamentRepository)
class TournamentRepository extends ImpTournamentRepository {
  final APIClient apiClient;

  TournamentRepository(this.apiClient);

  @override
  Future<Response> getTournamentsList({required String phoneNumber}) async {
    final response = await apiClient.post(
      "/tournament/get-by-phone",
      data: {"phone": phoneNumber},
    );
    logger.i("/tournament/get-by-phone : $response");
    return response;
  }

  @override
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
  }) async {
    final response = await apiClient.put("/tournament/update", data: {
      'logoUrl': logoImage,
      'bannerUrl': bannerImage,
      'tournamentName': tournamentName,
      'organizerName': orgName,
      'organizerPhone': orgContact,
      'city': location,
      'groundNames': [groundName],
      'numberOfTeams': numberOfTeams,
      'numberOfGroups': numberOfGroup,
      'startDate': startDate,
      'endDate': endDate == "End date" ? "null" : endDate,
      'gameTime': gameTime,
      'firstHalf': halfTime,
      'additionalDetails': addMoreDetails,
      'tournamentId': tournamentId,
    });
    logger.i("/tournament/update : $response");
    return response;
  }

  @override
  Future<Response> addTeamToTournament(
      {required String tournamentId, required List<TeamModel> teamList}) async {
    final response = await apiClient
        .post("/tournament/add-teams", data: {"tournamentId": tournamentId, "teams": teamList});
    logger.i("/tournament/add-teams : $response");
    return response;
  }
}
