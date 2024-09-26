import 'dart:developer';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:injectable/injectable.dart';
import 'package:yoursportz/core/api_client.dart';
import 'package:yoursportz/core/prefs.dart';
import 'package:yoursportz/domain/post/imp_post_repo.dart';
import 'package:yoursportz/injection/injection.dart';
import 'package:yoursportz/utils/logger.dart';

@LazySingleton(as: ImpPostRepository)
class PostRepo extends ImpPostRepository {
  final APIClient apiClient;

  PostRepo(this.apiClient);

  @override
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
  }) async {
    try {
      var headers = {'Authorization': getIt<AppPrefs>().token.getValue()};
      var request = http.MultipartRequest(
          'POST',
          Uri.parse(isIdea
              ? "http://3.108.210.48:5000/api/v1/banners/innovationPosts"
              : 'http://3.108.210.48:5000/api/v1/posts'));
      request.fields.addAll({
        'caption': caption!,
        'mediaType': mediaType,
        'tags': '$tags',
        'locationCoordinates': '[$longitude,$latitude]'
      });
      if (gifUrl != null) {
        request.fields.addAll({'gifUrl': gifUrl});
      }
      if (isIdea) {
        request.fields.addAll({
          'bannerType': "Innovation & Idea",
        });
      }
      if (filePath != null) {
        for (var i = 0; i < filePath.length; i++) {
          if (filePath[i] != null) {
            request.files.add(
              await http.MultipartFile.fromPath(
                'media',
                filePath[i],
              ),
            );
          }
        }
      }
      if (thumbnailsPath != null) {
        for (var i = 0; i < thumbnailsPath.length; i++) {
          if (thumbnailsPath[i] != null) {
            request.files.add(
              await http.MultipartFile.fromPath(
                'thumbnail',
                thumbnailsPath[i],
              ),
            );
          }
        }
      }
      request.headers.addAll(headers);
      logger.i(request.fields);
      final response = await http.Response.fromStream(await request.send());
      logger.i(response.body);
      return response;
    } on HttpClient catch (exception) {
      logger.i("/post : $exception");
    }
  }

  @override
  Future<Response> createChallengesPost(
      {required String challengeText, required List<String> tags}) async {
    try {
      final response = await apiClient.post(
        "/banners/bannerChallenges",
        data: {
          "caption": challengeText,
          "tags": tags.toString(),
        },
      );
      logger.i("/banners/bannerChallenges : $response");
      return response;
    } on DioException catch (exception) {
      logger.i("/banners/bannerChallenges : ${exception.response}");
      return exception.response!;
    }
  }

  @override
  Future<dynamic> createReel({
    String? filePath,
    String? thumbnailPath,
    String? caption,
    List<String>? tags,
  }) async {
    try {
      var headers = {'Authorization': getIt<AppPrefs>().token.getValue()};
      var request = http.MultipartRequest(
          'POST', Uri.parse('http://3.108.210.48:5000/api/v1/reels'));
      request.fields.addAll({
        'caption': caption!,
        'tags': '$tags',
      });
      log("message");
      request.files.add(await http.MultipartFile.fromPath('reel', filePath!));
      request.files
          .add(await http.MultipartFile.fromPath('thumbnail', thumbnailPath!));
      log("message");

      request.headers.addAll(headers);

      final response = await http.Response.fromStream(await request.send());
      logger.i(response.body);
      return response;
    } on HttpClient catch (exception) {
      logger.i("/reels : $exception");
    }
  }

  @override
  Future<Response> getGIFList() async {
    try {
      final response = await apiClient.get(
          "https://api.giphy.com/v1/gifs/trending?api_key=${dotenv.get("GIFY_API_KEY")}");
      logger.i("/gifs/trending : $response");
      return response;
    } on DioException catch (exception) {
      logger.i("/gifs/trending : ${exception.response}");
      return exception.response!;
    }
  }

  @override
  Future<Response> getSearchedGIFList({required String query}) async {
    try {
      final response = await apiClient.get(
          "https://api.giphy.com/v1/gifs/search?q=$query&api_key=${dotenv.get("GIFY_API_KEY")}");
      logger.i("/gifs/search : $response");
      return response;
    } on DioException catch (exception) {
      logger.i("/gifs/search : ${exception.response}");
      return exception.response!;
    }
  }

  @override
  Future<Response> createPostPoll(
      {required String caption, required List<String> options}) async {
    try {
      final response = await apiClient.post(
        "/polls",
        data: {"question": caption, "options": options},
      );
      logger.i("/polls : $response");
      return response;
    } on DioException catch (exception) {
      logger.i("/polls : ${exception.response}");
      return exception.response!;
    }
  }
}
