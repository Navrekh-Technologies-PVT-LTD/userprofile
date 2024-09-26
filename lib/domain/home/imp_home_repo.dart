// Package imports:
import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;

abstract class ImpHomeRepository {
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
  });
  Future<Response> getBanners();
  Future<Response> getPost(String? timeStamp);
  Future<Response> getInnovationIdeaPost(String? timeStamp);
  Future<Response> getChallengesPost();
  Future<Response> likeUnlikePost({required String postId});
  Future<Response> likeUnlikeIdea({required String postId});
  Future<Response> likeUnlikeChallenges({required String postId});
  Future<Response> likeUnlikePostComment(
      {required String postId, required bool isReel});
  Future<Response> saveUnsavePost({required String postId});
  Future<Response> saveUnsaveIdea({required String postId});
  Future<Response> saveUnsaveChallenge({required String postId});
  Future<Response> deletePostComment({required String commentId});
  Future<Response> repost({required String postId, String? repostCaption});
  Future<Response> getLiveStream();
  Future<Response> addPostComment({
    required String postId,
    required String comment,
    required bool isIdea,
    required bool isChallenge,
    required bool isReel,
  });

  Future<Response> getComments({
    required String postId,
    String? timeStamp,
    required bool isIdea,
    required bool isChallenge,
    required bool isReel,
  });
  Future<http.Response> createMeeting();
  Future<dynamic> createLivestreamRequest({
    required String fullName,
    required String phoneNumber,
    required String datetime,
    required String meetingId,
    required String sessionId,
    required String message,
    required String filePath,
  });

  Future<Response> getAllChats();
  Future<Response> sendMessage(
      {required String receiverId, required String message});

  Future<Response> getUserChats({
    required String chatId,
    String? timeStamp,
  });
  Future<Response> getNotification();
}
