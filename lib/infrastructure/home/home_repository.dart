import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:injectable/injectable.dart';
import 'package:yoursportz/core/api_client.dart';
import 'package:yoursportz/core/prefs.dart';
import 'package:yoursportz/domain/home/imp_home_repo.dart';
import 'package:yoursportz/injection/injection.dart';
import 'package:yoursportz/utils/logger.dart';

@LazySingleton(as: ImpHomeRepository)
class HomeRepo extends ImpHomeRepository {
  final APIClient apiClient;

  HomeRepo(this.apiClient);

  @override
  Future<Response> addVision2047({
    String? income1Year,
    String? income2Year,
    String? income5Year,
    String? income2047Year,
    String? education1year,
    String? education2year,
    String? education5year,
    String? career1Year,
    String? career2Year,
    String? career5Year,
    String? career2047Year,
    String? sportGoal,
    String? futureContribution,
    required bool isUpdate,
    required String userId,
  }) async {
    final accountType = getIt<AppPrefs>().accountType.getValue().toLowerCase();
    Map<String, String?> data;
    if (!isUpdate) {
      data = accountType == "individual"
          ? {
              "income1year": income1Year,
              "income2year": income2Year,
              "income5year": income5Year,
              "income2047": income2047Year,
              "education1year": education1year,
              "education2year": education2year,
              "education5year": education5year,
              "career1year": career1Year,
              "career2year": career2Year,
              "career5year": career5Year,
              "career2047": career2047Year,
              "sportsGoal": sportGoal,
              "futureContributionforCountry": futureContribution,
            }
          : {
              "yourGoal": sportGoal,
              "futureContributionforCountry": futureContribution
            };
    } else {
      data = accountType == "individual"
          ? {
              "income1year": income1Year,
              "income2year": income2Year,
              "income5year": income5Year,
              "income2047": income2047Year,
              "education1year": education1year,
              "education2year": education2year,
              "education5year": education5year,
              "career1year": career1Year,
              "career2year": career2Year,
              "career5year": career5Year,
              "career2047": career2047Year,
              "sportsGoal": sportGoal,
              "futureContributionforCountry": futureContribution,
              "visionId": userId,
            }
          : {
              "yourGoal": sportGoal,
              "futureContributionforCountry": futureContribution,
              "visionId": userId,
            };
    }

    try {
      final response = !isUpdate
          ? await apiClient.post(
              "/vision2047/$accountType",
              data: data,
            )
          : await apiClient.put(
              "/vision2047/update/$accountType",
              data: data,
            );
      logger.w(isUpdate
          ? "/vision2047/update/$accountType :$response "
          : "/vision2047/$accountType : $response");
      return response;
    } on DioException catch (exception) {
      logger.w(isUpdate
          ? "/vision2047/update/$accountType : ${exception.response}"
          : "/vision2047/$accountType : ${exception.response}");
      return exception.response!;
    }
  }

  @override
  Future<Response> getBanners() async {
    try {
      final response = await apiClient.get("/banners");
      logger.i("/banners : $response");
      return response;
    } on DioException catch (exception) {
      logger.i("/banners : ${exception.response}");
      return exception.response!;
    }
  }

  @override
  Future<Response> getPost(String? timeStamp) async {
    try {
      final response = await apiClient.get("/posts?beforeTimeStamp=$timeStamp");
      logger.i("/posts?beforeTimeStamp=$timeStamp : $response");
      return response;
    } on DioException catch (exception) {
      logger.i("/posts?beforeTimeStamp=$timeStamp : ${exception.response}");
      return exception.response!;
    }
  }

  @override
  Future<Response> likeUnlikePost({required String postId}) async {
    try {
      final response = await apiClient.put("/posts/likeUnlike/$postId");
      logger.i("/posts/likeUnlike/$postId : $response");
      return response;
    } on DioException catch (exception) {
      logger.i("/posts/likeUnlike/$postId : ${exception.response}");
      return exception.response!;
    }
  }

  @override
  Future<Response> likeUnlikeIdea({required String postId}) async {
    try {
      final response =
          await apiClient.put("/banners/innovationPostslikeUnlike/$postId");
      logger.i("/banners/innovationPostslikeUnlike/$postId : $response");
      return response;
    } on DioException catch (exception) {
      logger.i(
          "/banners/innovationPostslikeUnlike/$postId : ${exception.response}");
      return exception.response!;
    }
  }

  @override
  Future<Response> likeUnlikeChallenges({required String postId}) async {
    try {
      final response =
          await apiClient.post("/banners/bannerChallenges/likeUnlike/$postId");
      logger.i("/banners/bannerChallenges/likeUnlike/$postId : $response");
      return response;
    } on DioException catch (exception) {
      logger.i(
          "/banners/bannerChallenges/likeUnlike/$postId : ${exception.response}");
      return exception.response!;
    }
  }

  @override
  Future<Response> likeUnlikePostComment(
      {required String postId, required bool isReel}) async {
    try {
      final response = await apiClient.put(isReel
          ? "/reelsComment/likeUnlike/$postId"
          : "/comments/likeUnlike/$postId");
      logger.i("/comments/likeUnlike/$postId : $response");
      return response;
    } on DioException catch (exception) {
      logger.i("/comments/likeUnlike/$postId : ${exception.response}");
      return exception.response!;
    }
  }

  @override
  Future<Response> saveUnsavePost({required String postId}) async {
    try {
      final response = await apiClient.post("/posts/save/$postId");
      logger.i("/posts/saveUnsave/$postId : $response");
      return response;
    } on DioException catch (exception) {
      logger.i("/posts/saveUnsave/$postId : ${exception.response}");
      return exception.response!;
    }
  }

  @override
  Future<Response> saveUnsaveIdea({required String postId}) async {
    try {
      final response = await apiClient.post("/banners/saveInnovation/$postId");
      logger.i("/banners/saveInnovation/$postId : $response");
      return response;
    } on DioException catch (exception) {
      logger.i("/banners/saveInnovation/$postId : ${exception.response}");
      return exception.response!;
    }
  }

  @override
  Future<Response> saveUnsaveChallenge({required String postId}) async {
    try {
      final response = await apiClient.post("/banners/savedChallenges/$postId");
      logger.i("/banners/savedChallenges/$postId : $response");
      return response;
    } on DioException catch (exception) {
      logger.i("/banners/savedChallenges/$postId : ${exception.response}");
      return exception.response!;
    }
  }

  @override
  Future<Response> addPostComment(
      {required String postId,
      required String comment,
      required bool isIdea,
      required bool isChallenge,
      required bool isReel}) async {
    try {
      log(isIdea.toString());
      final response = await apiClient.post(
        isIdea
            ? "/banners/innovationComments"
            : isChallenge
                ? "/banners/bannerChallenges/reply"
                : isReel
                    ? "/reelsComment"
                    : "/comments/",
        data: isChallenge
            ? {"parentChallengeId": postId, "challengeText": comment}
            : isReel
                ? {"reelId": postId, "comment": comment}
                : {"postId": postId, "comment": comment},
      );
      logger.i("/comments/ : $response");
      return response;
    } on DioException catch (exception) {
      logger.i("/comments/ : ${exception.response}");
      return exception.response!;
    }
  }

  @override
  Future<Response> getComments({
    required String postId,
    String? timeStamp,
    required bool isIdea,
    required bool isChallenge,
    required bool isReel,
  }) async {
    try {
      final response = await apiClient.get(
        isIdea
            ? "/banners/commentsOnInnovationPosts/$postId"
            : isChallenge
                ? "/banners/repliesOnBannerChallenge/$postId"
                : isReel
                    ? "/reelsComment/$postId"
                    : "/comments/$postId?beforeTimeStamp=$timeStamp",
      );
      isIdea
          ? logger.i("/banners/commentsOnInnovationPosts/$postId : $response")
          : logger.i("/comments/$postId : $response");
      return response;
    } on DioException catch (exception) {
      logger.i("/comments/$postId : ${exception.response}");
      return exception.response!;
    }
  }

  @override
  Future<http.Response> createMeeting() async {
    try {
      final response = await http.post(
        Uri.parse("https://api.videosdk.live/v2/rooms"),
        headers: {
          'Authorization': dotenv.env['VIDEO_SDK_TOKEN'].toString(),
        },
      );
      logger.i("/rooms : $response");
      return response;
    } on DioException catch (exception) {
      logger.i("/rooms : ${exception.response}");
      return exception.response!.data;
    }
  }

  @override
  Future<Response> getInnovationIdeaPost(String? timeStamp) async {
    try {
      final response = await apiClient
          .get("/banners/allInnovationPost?beforeTimeStamp=$timeStamp");
      logger.i("/banners/allInnovationPost : $response");
      return response;
    } on DioException catch (exception) {
      logger.i("/banners/allInnovationPost : ${exception.response}");
      return exception.response!;
    }
  }

  @override
  Future<Response> getChallengesPost() async {
    try {
      final response = await apiClient.get("/banners/bannerChallenges");
      logger.i("/banners/bannerChallenges : $response");
      return response;
    } on DioException catch (exception) {
      logger.i("/banners/bannerChallenges : ${exception.response}");
      return exception.response!;
    }
  }

  @override
  Future<dynamic> createLivestreamRequest({
    required String fullName,
    required String phoneNumber,
    required String datetime,
    required String meetingId,
    required String sessionId,
    required String message,
    required String filePath,
  }) async {
    try {
      logger.i(meetingId);
      logger.i(sessionId);
      logger.i(dotenv.env['BASE_URL']);
      var headers = {'Authorization': getIt<AppPrefs>().token.getValue()};
      var request = http.MultipartRequest(
          'POST', Uri.parse('${dotenv.env['BASE_URL']}banners/createGoLive'));
      request.fields.addAll({
        'fullName': fullName,
        'phone': phoneNumber,
        'message': message,
        'datetime': datetime,
        'meetingId': meetingId,
        'sessionId': sessionId
      });
      request.files.add(await http.MultipartFile.fromPath('file', filePath));
      request.headers.addAll(headers);

      final response = await http.Response.fromStream(await request.send());
      logger.w("/banners/createGoLive : ${response.body}");
      return response;
    } catch (exception) {
      logger.e("/banners/createGoLive : $exception");
      return exception;
    }
  }

  @override
  Future<Response> getLiveStream() async {
    try {
      final response = await apiClient.get("/banners/allLiveEvents");
      logger.i("/banners/allLiveEvents : $response");
      return response;
    } on DioException catch (exception) {
      logger.i("/banners/allLiveEvents : ${exception.response}");
      return exception.response!;
    }
  }

  @override
  Future<Response> getAllChats() async {
    try {
      final response = await apiClient.get("/chat/getAllChatUsers");
      logger.i("/chat/getAllChatUsers : $response");
      return response;
    } on DioException catch (exception) {
      logger.i("/chat/getAllChatUsers : ${exception.response}");
      return exception.response!;
    }
  }

  @override
  Future<Response> getUserChats(
      {required String chatId, String? timeStamp}) async {
    try {
      final response = await apiClient
          .get("/chat/getMessages/$chatId?beforeTimeStamp=$timeStamp");
      logger.i(
          "/chat/getMessages/$chatId?beforeTimeStamp=$timeStamp : $response");
      return response;
    } on DioException catch (exception) {
      logger.i(
          "/chat/getMessages/$chatId?beforeTimeStamp=$timeStamp : ${exception.response}");
      return exception.response!;
    }
  }

  @override
  Future<Response> sendMessage(
      {required String receiverId, required String message}) async {
    try {
      final response = await apiClient.post("/chat/sendMessage", data: {
        "receiverId": receiverId,
        "content": message,
        "contentType": "text"
      });
      logger.i("/chat/sendMessage : $response");
      return response;
    } on DioException catch (exception) {
      logger.i("/chat/sendMessage : ${exception.response}");
      return exception.response!;
    }
  }

  @override
  Future<Response> getNotification() async {
    try {
      final response = await apiClient.get(
        "/notifications",
      );
      logger.i("/notifications : $response");
      return response;
    } on DioException catch (exception) {
      logger.i("/notifications : ${exception.response}");
      return exception.response!;
    }
  }

  @override
  Future<Response> repost(
      {required String postId, String? repostCaption}) async {
    try {
      final response = await apiClient.post("/posts/repost/$postId",
          data: {"repostCaption": repostCaption});
      logger.i("/posts/repost/$postId : $response");
      return response;
    } on DioException catch (exception) {
      logger.i("/posts/repost/$postId : ${exception.response}");
      return exception.response!;
    }
  }

  @override
  Future<Response> deletePostComment({required String commentId}) async {
    try {
      final response = await apiClient.delete(
        "/comments/$commentId",
      );
      logger.i("/comments/$commentId : $response");
      return response;
    } on DioException catch (exception) {
      logger.i("/comments/$commentId : ${exception.response}");
      return exception.response!;
    }
  }
}
