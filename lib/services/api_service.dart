import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:mentors/modal/login_response_model.dart';
import 'package:mentors/modal/register_request_model.dart';
import 'package:mentors/modal/register_response_model.dart';
import 'package:provider/provider.dart';
import '../config.dart';
import '../modal/login_request_model.dart';
import './shared_service.dart';

class ApiService {
  static var client = http.Client();

  static Future<void> login(
      BuildContext context, LoginRequestModel model) async {
    try {
      Map<String, String> requestHeader = {'Content-Type': 'application/json'};
      var url = Uri.http(Config.apiUrl, Config.loginApi);
      var response = await client.post(url,
          headers: requestHeader, body: jsonEncode(model.toJson()));
      if (response.statusCode == 200) {
        await Provider.of<SharedService>(context, listen: false)
            .setlogindetails(loginResponsejson(response.body));
        // return true;
      } else {
        //return false;
      }
    } catch (error) {
      rethrow;
    }
  }

  static Future<void> register(
      BuildContext context, RegisterRequestModel model) async {
    try {
      Map<String, String> requestHeader = {'Content-Type': 'application/json'};
      var url = Uri.http(Config.apiUrl, Config.registerApi);
      var response = await client.post(url,
          headers: requestHeader, body: jsonEncode(model.toJson()));
      if (response.statusCode == 200) {
        await Provider.of<SharedService>(context, listen: false)
            .register(registerResponsejson(response.body));
      }
    } catch (error) {
      rethrow;
    }
  }

  static Future<void> createOtp(CreateOtpModel model) async {
    try {
      Map<String, String> requestHeader = {'Content-Type': 'application/json'};
      var url = Uri.http(Config.apiUrl, Config.mobcreateotpApi);
      var response = await client.post(url,
          headers: requestHeader, body: jsonEncode(model.toJson()));
      if (response.statusCode == 200) {
        print(response.statusCode);
      }
    } catch (error) {
      rethrow;
    }
  }

  static Future<void> verifyOtp(VerifyOtpModel model) async {
    try {
      Map<String, String> requestHeader = {'Content-Type': 'application/json'};
      var url = Uri.http(Config.apiUrl, Config.mobverifyotpApi);
      var response = await client.post(url,
          headers: requestHeader, body: jsonEncode(model.toJson()));
      if (response.statusCode == 200) {
        print(response.statusCode);
      }
    } catch (error) {
      rethrow;
    }
  }

  static Future<bool> profile(String token) async {
    try {
      Map<String, String> requestHeader = {
        'Content-Type': 'application/json',
        'authorization': 'Basic $token'
      };
      var url = Uri.http(Config.apiUrl, Config.profileApi);
      var response = await client.get(url, headers: requestHeader);
      if (response.statusCode == 200) {
        return true;
      } else {
        return false;
      }
    } catch (error) {
      rethrow;
    }
  }
}
