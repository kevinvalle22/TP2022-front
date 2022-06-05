import 'dart:convert';
import 'dart:io';
//import User from '../models/User';
import 'package:tp2022_front/models/Exercise.dart';
import 'package:tp2022_front/models/User.dart';
import 'package:http/http.dart' as http;

//global variable to store the token

class DataBaseHelper {
  Future<String> authenticate(String userName, String password) async {
    final url = 'http://10.0.2.2:8081/authenticate';

    http.Response auth = await http.post(Uri.parse(url),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
        body: jsonEncode({'userName': userName, 'password': password}));

    return (json.decode(auth.body))['token'];
  }

  Future<int> authenticateToGetId(String userName, String password) async {
    final url = 'http://10.0.2.2:8081/authenticate';

    http.Response auth = await http.post(Uri.parse(url),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
        body: jsonEncode({'userName': userName, 'password': password}));
    print(auth.body);
    return (json.decode(auth.body))['id'];
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

  Future<Exercise> createExercise(String urlOption, String userName,
      String password, Exercise exercise) async {
    const requestUrl = "http://10.0.2.2:8081/api/users/";
    final url = Uri.parse(requestUrl + urlOption + "/exercises");
    final token = await authenticate(userName, password);

    http.Response result = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      },
      body: jsonEncode({
        'duration': exercise.duration,
        'exerciseDate': exercise.exerciseDate,
      }),
    );
    if (result.statusCode == HttpStatus.ok) {
      final jsonResponse = json.decode(result.body);
      return Exercise.fromJson(jsonResponse);
    } else {
      throw Exception('Failed request');
    }
  }
}
