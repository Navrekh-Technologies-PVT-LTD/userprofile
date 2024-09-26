// Package imports:

import 'dart:io';

import 'package:dio/dio.dart';

abstract class ImpAuthRepository {
  Future<Response> loginUser({required String token});
  Future<dynamic> registerUser({
    required String fullName,
    required String userName,
    required String email,
    required String phoneNumber,
    required String accountType,
    required List<String> interests,
    required File profilPicture,
  });
}
