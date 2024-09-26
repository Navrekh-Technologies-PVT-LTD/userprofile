import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:injectable/injectable.dart';
import 'package:yoursportz/core/api_client.dart';
import 'package:yoursportz/core/prefs.dart';
import 'package:yoursportz/domain/profile/imp_profile_repo.dart';
import 'package:yoursportz/injection/injection.dart';
import 'package:yoursportz/utils/logger.dart';

@LazySingleton(as: ImpProfileRepository)
class ProfileRepo extends ImpProfileRepository {
  final APIClient apiClient;

  ProfileRepo(this.apiClient);

  @override
  Future<Response> getUserProfile({required String userId}) async {
    try {
      final response = await apiClient.get("/users/userById/$userId");
      logger.w("/users/userById/$userId : $response");
      return response;
    } on DioException catch (exception) {
      logger.w("/users/userById/$userId : ${exception.response}");
      return exception.response!;
    }
  }

  @override
  Future<dynamic> updateUserProfile({
    required String userId,
    required String fullName,
    required String userName,
    required String userBio,
    required String profilePath,
  }) async {
    try {
      var headers = {'Authorization': getIt<AppPrefs>().token.getValue()};
      var request = http.MultipartRequest(
          'PUT', Uri.parse('${dotenv.env['BASE_URL']}users/update'));
      request.fields['fullName'] = fullName;
      request.fields['userName'] = userName;
      request.fields['id'] = userId;
      request.fields['profileBio'] = userBio;
      if (profilePath.isNotEmpty) {
        var multipartFile =
            await http.MultipartFile.fromPath('file', profilePath);
        request.files.add(multipartFile);
      }
      logger.d(request.fields);
      request.headers.addAll(headers);
      final response = await http.Response.fromStream(await request.send());
      logger.w("/users/update : ${response.body}");
      return response;
    } on DioException catch (exception) {
      logger.w("/users/update : ${exception.response}");
    }
  }

  @override
  Future<Response> getVision2047({required String userId}) async {
    final accountType = getIt<AppPrefs>().accountType.getValue().toLowerCase();
    try {
      final response = await apiClient.get("/vision2047/$accountType/$userId");
      logger.w("/vision2047/$accountType/$userId : $response");
      return response;
    } on DioException catch (exception) {
      logger.w("/vision2047/$accountType/$userId: ${exception.response}");
      return exception.response!;
    }
  }

  @override
  Future<Response> getUsersConnections({required String userId}) async {
    try {
      final response = await apiClient.get("/users/connections/$userId");
      logger.w("/users/connections/$userId: $response");
      return response;
    } on DioException catch (exception) {
      logger.w("/users/connections/$userId: ${exception.response}");
      return exception.response!;
    }
  }

  @override
  Future<Response> followUser({required String userId}) async {
    try {
      final response = await apiClient.post("/users/follow/$userId");
      logger.w("/users/follow/$userId: $response");
      return response;
    } on DioException catch (exception) {
      logger.w("/users/follow/$userId: ${exception.response}");
      return exception.response!;
    }
  }

  @override
  Future<Response> unfollowUser({required String userId}) async {
    try {
      final response = await apiClient.delete("/users/unfollow/$userId");
      logger.w("/users/unfollow/$userId: $response");
      return response;
    } on DioException catch (exception) {
      logger.w("/users/unfollow/$userId: ${exception.response}");
      return exception.response!;
    }
  }

  @override
  Future<Response> getUserPosts(
      {required String userId, String? timeStamp}) async {
    try {
      final response = await apiClient
          .get("/posts/byUser/$userId?beforeTimeStamp=$timeStamp");
      logger.w("/posts/byUser/$userId: $response");
      return response;
    } on DioException catch (exception) {
      logger.w("/posts/byUser/$userId: ${exception.response}");
      return exception.response!;
    }
  }

  @override
  Future<Response> getUserSavedPosts() async {
    try {
      final response = await apiClient.get("/posts/saved/0");
      logger.w("/posts/saved/0: $response");
      return response;
    } on DioException catch (exception) {
      logger.w("/posts/saved/0: ${exception.response}");
      return exception.response!;
    }
  }

  @override
  Future<Response> addInstituteMember(
      {required String memberUserId, required String position}) async {
    try {
      final response = await apiClient.post(
        "/users/addMember",
        data: {"memberUserId": memberUserId, "position": position},
      );
      logger.w("/users/addMember: $response");
      return response;
    } on DioException catch (exception) {
      logger.w("/users/addMember: ${exception.response}");
      return exception.response!;
    }
  }

  @override
  Future<Response> deleteUserPost({required String postId}) async {
    try {
      final response = await apiClient.delete("/posts/$postId");
      logger.w("/posts/$postId: $response");
      return response;
    } on DioException catch (exception) {
      logger.w("/posts/$postId: ${exception.response}");
      return exception.response!;
    }
  }

  @override
  Future<Response> getInstituteMembers() async {
    try {
      final response = await apiClient.get("/users/members");
      logger.w("/users/members: $response");
      return response;
    } on DioException catch (exception) {
      logger.w("/users/members: ${exception.response}");
      return exception.response!;
    }
  }
}
