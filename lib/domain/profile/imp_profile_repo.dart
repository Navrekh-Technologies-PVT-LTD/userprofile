// Package imports:

import 'package:dio/dio.dart';

abstract class ImpProfileRepository {
  Future<Response> getUserProfile({required String userId});
  Future<dynamic> updateUserProfile({
    required String userId,
    required String fullName,
    required String userName,
    required String userBio,
    required String profilePath,
  });
  Future<Response> getVision2047({required String userId});
  Future<Response> getUsersConnections({required String userId});
  Future<Response> followUser({required String userId});
  Future<Response> unfollowUser({required String userId});
  Future<Response> getUserPosts({required String userId, String? timeStamp});
  Future<Response> getUserSavedPosts();
  Future<Response> addInstituteMember(
      {required String memberUserId, required String position});

  Future<Response> deleteUserPost({required String postId});
  Future<Response> getInstituteMembers();
}
