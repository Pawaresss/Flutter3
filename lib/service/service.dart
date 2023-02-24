import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';

class ServiceAPI {
  static final Dio _dio = Dio(BaseOptions(
    baseUrl: "https://b5a2-49-231-253-51.ap.ngrok.io/api/",
    headers: {'Content-Type': 'application/json; charset=UTF-8'},
  ));

  static Future<bool>? signup(
      String username, String password, String email, String text) async {
    return await _dio.post("auth/signup", data: {
      "username": username,
      "email": email,
      "password": password
    }).then((value) => Future.value(true));
  }

  static Future<Object>? signin(String username, String password) async {
    return await _dio.post("auth/signin", data: {
      "username": username,
      "password": password
    }).then((value) => Future.value(value));
  }

  static createState(String text, String text2, String text3, String text4) {}
}
