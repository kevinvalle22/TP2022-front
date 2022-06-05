import 'dart:convert';
import 'dart:io';
//import User from '../models/User';
import 'package:tp2022_front/models/User.dart';
import 'package:http/http.dart' as http;

//global variable to store the token

class DataBaseHelper {
  Future<String> authenticate(String userName, String password) async {
    var url = 'http://10.0.2.2:8081/authenticate';
    var body = json.encode({'userName': userName, 'password': password});
    http.Response auth = await http
        .post(url, body: body, headers: {'Content-Type': 'application/json'});
    //print(response.body);
    // print(jsonDecode(response.body));

    //print(token);
    return (json.decode(auth.body)['token']);
  }

  Future<int> authenticateToGetId(String userName, String password) async {
    var url = 'http://10.0.2.2:8081/authenticate';
    var body = json.encode({'userName': userName, 'password': password});
    http.Response auth = await http
        .post(url, body: body, headers: {'Content-Type': 'application/json'});
    //print(response.body);
    // print(jsonDecode(response.body));

    //print(token);
    return (json.decode(auth.body)['id']);
  }

  Future<http.Response> register(String userName, String email, String password,
      String phone, String university, String province, String district) async {
    var url = 'https://mental-health-deploy.herokuapp.com/register';
    var body = json.encode({
      'userName': userName,
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

  Future<User> getUser(
      String urlOption, String userName, String password) async {
    const requestUrl = "http://10.0.2.2:8081/api/users/";
    final url = Uri.parse(requestUrl + urlOption);
    final token = await authenticate(userName, password);
    http.Response result = await http.get(
      requestUrl + urlOption,
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );
    if (result.statusCode == HttpStatus.ok) {
      final jsonResponse = json.decode(result.body);
      return User.fromJson(jsonResponse);
    } else {
      throw Exception('Failed request');
    }
  }

  Future<List> getUsers(String userName, String password) async {
    // Perfil información del usuario
    const requestUrl = "https://mental-health-deploy.herokuapp.com/api/users";
    final url = Uri.parse(requestUrl);
    final token = await authenticate(userName, password);
    http.Response result = await http.get(url, headers: {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    });
    if (result.statusCode == HttpStatus.ok) {
      final jsonResponse = json.decode(result.body);
      final arrayMap = jsonResponse['content'];
      List items = arrayMap.map((map) => User.fromJson(map)).toList();
      print(items);
      return items;
    } else {
      throw Exception('Failed request');
    }
  }
}
