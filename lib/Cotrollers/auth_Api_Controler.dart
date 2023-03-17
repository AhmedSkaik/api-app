import 'dart:convert';
import 'dart:io';

import 'package:api_training/Models/Student.dart';
import 'package:api_training/Models/api_response.dart';
import 'package:api_training/SharedPrefencess/shared_pref_controller.dart';
import 'package:api_training/api/api_Settings.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class AuthApiController {
  Future<ApiResponse> Login(
      {required String email, required String password}) async {
    var uri = Uri.parse(ApiSettings.login);
    var response =
        await http.post(uri, body: {"email": email, "password": password});
    if (response.statusCode == 200 || response.statusCode == 400) {
      var jsonResponse = jsonDecode(response.body);
      if (response.statusCode == 200) {
        Student student = Student.fromJson(jsonResponse['object']);
        await SharedPrefController().save(student: student);
      }
      return ApiResponse(
          massage: jsonResponse['message'], success: jsonResponse['status']);
    }
    return ApiResponse(massage: 'somthing wrong', success: false);
  }

  Future<ApiResponse> Logout() async {
    await SharedPrefController().clear();
    var uri = Uri.parse(ApiSettings.logout);
    var response = await http.get(uri, headers: {
      HttpHeaders.authorizationHeader: SharedPrefController().token,
      HttpHeaders.acceptHeader: "application/json"
    });
    if (response.statusCode == 200 || response.statusCode == 401) {
      await SharedPrefController().clear;
      var jsonResponse = jsonDecode(response.body);
      return ApiResponse(massage: 'logout succesfully', success: true);
    }
    return ApiResponse(massage: 'somthing error', success: false);
  }

  Future<ApiResponse> register({required Student student}) async {
    var url = Uri.parse(ApiSettings.register);
    var response = await http.post(url, body: {
      "full_name": student.fullName,
      "email": student.email,
      "password": student.password,
      "gender": student.gender
    });
    if (response.statusCode == 201 || response.statusCode == 400) {
      var jsonResponse = jsonDecode(response.body);
      return ApiResponse(
          massage: jsonResponse['message'], success: jsonResponse['status']);
    }
    return ApiResponse(massage: 'somthing error', success: false);
  }
}
