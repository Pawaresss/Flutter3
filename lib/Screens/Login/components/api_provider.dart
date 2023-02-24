import 'package:http/http.dart' as http;
import 'dart:io';

class ApiProvider {
  ApiProvider();

  String endPoint = 'http://18.139.255.90:3000';

  Future<http.Response> doLogin(String username, String password) async {
    String url = '$endPoint/login';
    var body = {"username": username, "password": password};
    return await http.post(Uri.parse(url), body: body);
  }

  Future<http.Response> getUser(String token) async {
    String url = '$endPoint/users';
    return await http.get(
      Uri.parse(url),
      headers: {HttpHeaders.authorizationHeader: "Bearer $token"},
    );
  }

    Future<http.Response> createUser({required String token,required String username,
    required  String password,required String fullname,required String email}) async {
    String url = '$endPoint/register';
    var body = {
      "username": username,
      "password": password,
      "fullname": fullname,
      "email": email
    };
    return await http.post(
      Uri.parse(url),
      body: body,
      headers: {HttpHeaders.authorizationHeader: "Bearer $token"},
    );
  }

  static createState(String text, String text2, String text3, String text4) {
    
  }
}
