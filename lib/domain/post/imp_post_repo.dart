// Package imports:

import 'package:dio/dio.dart';

abstract class ImpPostRepository {
  Future<dynamic> createPost({
    List<dynamic>? filePath,
    List<dynamic>? thumbnailsPath,
    String? caption,
    String? gifUrl,
    List<String>? tags,
    required String mediaType,
    required String longitude,
    required String latitude,
    required bool isIdea,
  });
  Future<dynamic> createReel({
    String? filePath,
    String? thumbnailPath,
    String? caption,
    List<String>? tags,
  });
  Future<Response> createChallengesPost({
    required String challengeText,
    required List<String> tags,
  });
  Future<Response> createPostPoll({
    required String caption,
    required List<String> options,
  });
  Future<Response> getGIFList();
  Future<Response> getSearchedGIFList({required String query});
}
