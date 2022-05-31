import 'dart:convert';
import 'package:http/http.dart' as http;

//global variable to store the token

class DataBaseHelper {
  var token = '';
  List dataUsers = [];
  Future<http.Response> authenticate(String userName, String password) async {
    var url = 'https://mental-health-deploy.herokuapp.com/authenticate';
    var body = json.encode({'userName': userName, 'password': password});
    var response = await http
        .post(url, body: body, headers: {'Content-Type': 'application/json'});
    //print(response.body);
    // print(jsonDecode(response.body));

    token = jsonDecode(response.body)['token'].toString();
    print(token);
    //print(token);
    return response;
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

  Future<String> getUser() async {
    var url = 'https://mental-health-deploy.herokuapp.com/api/users';
    var response = await http.get(Uri.parse(url + "users"), headers: {
      'Content-Type': 'application/json',
      'Authorization': "Bearer $token"
    });

    var extractdata = json.decode(response.body);
    dataUsers = extractdata['content'];

    print(dataUsers);
    return response.body.toString();
  }

  Future<http.Response> getUserInfo(String Id) async {
    // Perfil información del usuario
    var url2 = 'https://mental-health-deploy.herokuapp.com/api/users/$Id';
    var response2 = await http.get(url2, headers: {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ' + token
    });
    print(response2.body);
    return response2;
  }
}
