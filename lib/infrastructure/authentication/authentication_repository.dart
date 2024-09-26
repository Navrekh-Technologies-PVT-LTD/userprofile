import 'dart:io';

import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;
import 'package:injectable/injectable.dart';
import 'package:yoursportz/core/api_client.dart';
import 'package:yoursportz/domain/authentication/imp_auth_repo.dart';
import 'package:yoursportz/utils/logger.dart';

@LazySingleton(as: ImpAuthRepository)
class AuthenticationRepo extends ImpAuthRepository {
  final APIClient apiClient;

  AuthenticationRepo(this.apiClient);

  @override
  Future<Response> loginUser({required String token}) async {
    try {
      final response = await apiClient.get("/auth/login/$token");
      logger.w("/auth/login/$token : $response");
      return response;
    } on DioException catch (exception) {
      logger.w("/auth/login/$token : ${exception.response}");
      return exception.response!;
    }
  }

  @override
  Future<dynamic> registerUser({
    required String fullName,
    required String userName,
    required String email,
    required String phoneNumber,
    required String accountType,
    required List<String> interests,
    required File profilPicture,
  }) async {
    try {
      var request = http.MultipartRequest(
          'POST', Uri.parse('http://3.108.210.48:5000/api/v1/auth/signup'));
      request.fields['fullName'] = fullName;
      request.fields['userName'] = userName;
      request.fields['email'] = email;
      request.fields['phoneNumber'] = phoneNumber;
      request.fields['accountType'] = accountType;
      request.fields['interests'] = interests.join(',');

      var multipartFile =
          await http.MultipartFile.fromPath('file', profilPicture.path);
      request.files.add(multipartFile);
      final response = await http.Response.fromStream(await request.send());
      logger.w("/users/auth/signup : ${response.body}");
      return response;
    } catch (exception) {
      logger.e("/users/auth/signup : $exception");
      return exception;
    }
  }
}
