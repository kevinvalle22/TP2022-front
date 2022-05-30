import 'dart:convert';
import 'package:http/http.dart' as http;

//global variable to store the token

class DataBaseHelper {
  var token;
  List dataUsers = [];
  Future<http.Response> authenticate(String userName, String password) async {
    var url = 'https://mental-health-deploy.herokuapp.com/authenticate';
    var body = json.encode({'userName': userName, 'password': password});
    var response = await http
        .post(url, body: body, headers: {'Content-Type': 'application/json'});
    //print(response.body);
    // print(jsonDecode(response.body));
    // obtener el token la informacion del body
    token = jsonDecode(response.body)['token'];
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

  Future<http.Response> getUserInfo(String userName) async {
    String a = "3";
    // Obtener Usuarios
    var url = 'https://mental-health-deploy.herokuapp.com/api/users';
    var response = await http.get(url, headers: {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token'
    });

    var contends = json.decode(response.body)['content'];
    print(contends);
    dataUsers = contends;
    print(dataUsers);

    print(a);
    // Perfil información del usuario
    var url2 = 'https://mental-health-deploy.herokuapp.com/api/users/$a';
    var response2 = await http.get(url2, headers: {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token'
    });
    print(response2.body);
    return response2;
  }
}
