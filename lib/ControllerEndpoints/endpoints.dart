import 'dart:convert';
import 'package:http/http.dart' as http;

//global variable to store the token
String token = "";

class DataBaseHelper {
  Future<http.Response> authenticate(String userName, String password) async {
    var url = 'https://mental-health-deploy.herokuapp.com/authenticate';
    var body = json.encode({'userName': userName, 'password': password});
    var response = await http
        .post(url, body: body, headers: {'Content-Type': 'application/json'});
    print(response.body);
    token = response.body;
    return response;
  }

  Future<http.Response> register(String username, String email, String password,
      String phone, String university, String province, String district) async {
    var url = 'https://mental-health-deploy.herokuapp.com/register';
    var body = json.encode({
      'username': username,
      'email': email,
      'password': password,
      'role': "ROLE_USER",
      'phone': phone,
      'university': university,
      'province': province,
      'district': district
    });

    var response = await http
        .post(url, body: body, headers: {'Content-Type': 'application/json'});

    return response;
  }

  Future<http.Response> getUserInfo(String id) async {
    int a = int.parse(id);
    // Perfil información del usuario
    var url = 'https://mental-health-deploy.herokuapp.com/users/$a';
    var response = await http.get(url, headers: {
      'Content-Type': 'application/json',
      'Authorization': "Bearer " + token
    });
    return response;
  }
}
