import 'dart:convert';
import 'dart:io';
//import User from '../models/User';
import 'package:tp2022_front/models/Affimation.dart';
import 'package:tp2022_front/models/Exercise.dart';
import 'package:tp2022_front/models/Goal.dart';
import 'package:tp2022_front/models/Reminder.dart';
import 'package:tp2022_front/models/Thoughts.dart';
import 'package:tp2022_front/models/User.dart';
import 'package:tp2022_front/models/SleepRecord.dart';
import 'package:http/http.dart' as http;

//global variable to store the token

class DataBaseHelper {
  Future<String> authenticate(String userName, String password) async {
    final url = 'https://mental-health-deploy.herokuapp.com/authenticate';

    http.Response auth = await http.post(Uri.parse(url),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
        body: jsonEncode({'userName': userName, 'password': password}));

    return (json.decode(auth.body))['token'];
  }

  Future<int> authenticateToGetId(String userName, String password) async {
    const url = 'https://mental-health-deploy.herokuapp.com/authenticate';

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
    const requestUrl = "https://mental-health-deploy.herokuapp.com/api/users/";
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

  Future<List> getUsuarios(String userName, String password) async {
    const requestUrl = "https://mental-health-deploy.herokuapp.com/api/users/";
    final url = Uri.parse(requestUrl);
    final token = await authenticate(userName, password);
    http.Response result = await http.get(
      requestUrl,
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );
    if (result.statusCode == HttpStatus.ok) {
      final jsonResponse = json.decode(utf8.decode(result.bodyBytes));
      final list = jsonResponse['content'];
      print(list);
      List listOfSleepRecords =
          list.map<User>((json) => User.fromJson(json)).toList();
      return list;
    } else {
      throw Exception('Failed request');
    }
  }

  Future<Exercise> createExercise(String urlOption, String userName,
      String password, Exercise exercise) async {
    const requestUrl = "https://mental-health-deploy.herokuapp.com/api/users/";
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
        'startDate': exercise.startDate,
        'endDate': exercise.endDate,
        'message': exercise.message,
      }),
    );
    if (result.statusCode == HttpStatus.ok) {
      final jsonResponse = json.decode(result.body);
      return Exercise.fromJson(jsonResponse);
    } else {
      throw Exception('Failed request');
    }
  }

  Future<Affirmation> createAffirmation(String urlOption, String userName,
      String password, Affirmation affirmation) async {
    const requestUrl = "https://mental-health-deploy.herokuapp.com/api/users/";
    final url = Uri.parse(requestUrl + urlOption + "/affirmations");
    final token = await authenticate(userName, password);

    http.Response result = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      },
      body: jsonEncode({
        'message': affirmation.message,
        'affirmationDate': affirmation.affirmationDate,
        'mondayActive': affirmation.mondayActive,
        'tuesdayActive': affirmation.tuesdayActive,
        'wednesdayActive': affirmation.wednesdayActive,
        'thursdayActive': affirmation.thursdayActive,
        'fridayActive': affirmation.fridayActive,
        'saturdayActive': affirmation.saturdayActive,
        'sundayActive': affirmation.sundayActive
      }),
    );
    if (result.statusCode == HttpStatus.ok) {
      final jsonResponse = json.decode(result.body);
      return Affirmation.fromJson(jsonResponse);
    } else {
      throw Exception('Failed request');
    }
  }

  Future<SleepRecord> createASleepRecord(String urlOption, String userName,
      String password, SleepRecord sleepRecord) async {
    const requestUrl = "https://mental-health-deploy.herokuapp.com/api/users/";
    final url = Uri.parse(requestUrl + urlOption + "/sleeps");
    final token = await authenticate(userName, password);

    http.Response result = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      },
      body: jsonEncode({
        'startDate': sleepRecord.startDate,
        'endDate': sleepRecord.endDate,
        'message': sleepRecord.message,
      }),
    );
    if (result.statusCode == HttpStatus.ok) {
      final jsonResponse = json.decode(result.body);
      return SleepRecord.fromJson(jsonResponse);
    } else {
      throw Exception('Failed request');
    }
  }

  Future<Goal> createAGoalRecord(
      String urlOption, String userName, String password, Goal goal) async {
    const requestUrl = "https://mental-health-deploy.herokuapp.com/api/users/";
    final url = Uri.parse(requestUrl + urlOption + "/goals");
    final token = await authenticate(userName, password);

    http.Response result = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      },
      body: jsonEncode({
        'startDate': goal.startDate,
        'message': goal.message,
        'type': goal.type,
        'status': goal.status,
        'actionPlan1': goal.actionPlan1,
        'actionPlan2': goal.actionPlan2,
        'actionPlan3': goal.actionPlan3,
      }),
    );
    if (result.statusCode == HttpStatus.ok) {
      final jsonResponse = json.decode(result.body);
      return Goal.fromJson(jsonResponse);
    } else {
      throw Exception('Failed request');
    }
  }

  Future<List> getSleepsRecords(
      String urlOption, String userName, String password) async {
    const urlBase = "https://mental-health-deploy.herokuapp.com/api/users/";
    final token = await authenticate(userName, password);
    final strFinal = urlBase + urlOption + "/sleeps";
    final url = Uri.parse(strFinal);

    http.Response result = await http.get(url, headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    });
    if (result.statusCode == HttpStatus.ok) {
      final jsonResponse = json.decode(utf8.decode(result.bodyBytes));
      final list = jsonResponse['content'];
      print(list);
      List listOfSleepRecords =
          list.map<SleepRecord>((json) => SleepRecord.fromJson(json)).toList();
      return list;
    } else {
      throw Exception('Failed request');
    }
  }

  Future<List> getGoalsRecord(
      String urlOption, String userName, String password) async {
    const urlBase = "https://mental-health-deploy.herokuapp.com/api/users/";
    final token = await authenticate(userName, password);
    final strFinal = urlBase + urlOption + "/goals";
    final url = Uri.parse(strFinal);

    http.Response result = await http.get(url, headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    });
    if (result.statusCode == HttpStatus.ok) {
      final jsonResponse = json.decode(utf8.decode(result.bodyBytes));
      final list = jsonResponse['content'];
      print(list);
      List listOfSleepRecords =
          list.map<Goal>((json) => Goal.fromJson(json)).toList();
      return list;
    } else {
      throw Exception('Failed request');
    }
  }

  Future<List> getAffirmations(
      String urlOption, String userName, String password) async {
    const urlBase = "https://mental-health-deploy.herokuapp.com/api/users/";
    final token = await authenticate(userName, password);
    final strFinal = urlBase + urlOption + "/affirmations";
    final url = Uri.parse(strFinal);

    http.Response result = await http.get(url, headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    });
    if (result.statusCode == HttpStatus.ok) {
      final jsonResponse = json.decode(result.body);
      final list = jsonResponse['content'];
      print(list);
      List listOfSleepRecords =
          list.map<Affirmation>((json) => Affirmation.fromJson(json)).toList();
      return list;
    } else {
      throw Exception('Failed request');
    }
  }

  Future<List> getExercises(
      String urlOption, String userName, String password) async {
    //with uri.parse we can parse the url
    const urlBase = "https://mental-health-deploy.herokuapp.com/api/users/";

    final token = await authenticate(userName, password);
    final strFinal = urlBase + urlOption + "/exercises";
    final url = Uri.parse(strFinal);

    http.Response result = await http.get(url, headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    });
    if (result.statusCode == HttpStatus.ok) {
      final jsonResponse = json.decode(utf8.decode(result.bodyBytes));
      final list = jsonResponse['content'];
      print(list);
      List listOfExercises =
          list.map<Exercise>((json) => Exercise.fromJson(json)).toList();
      return list;
    } else {
      throw Exception('Failed request');
    }
  }

  Future<Thought> createThoughts(String urlOption, String userName,
      String password, Thought thought) async {
    int id = int.parse(urlOption);
    final requestUrl =
        "https://mental-health-deploy.herokuapp.com/api/users/$id/thoughtRecords";

    final token = await authenticate(userName, password);

    http.Response result = await http.post(
      requestUrl,
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      },
      body: jsonEncode({
        'message': thought.message,
      }),
    );
    print(result.statusCode);
    if (result.statusCode == HttpStatus.ok) {
      final jsonResponse = json.decode(result.body);
      return Thought.fromJson(jsonResponse);
    } else {
      throw Exception('Failed request');
    }
  }

  Future<List> getThoughts(
      String urlOption, String userName, String password) async {
    const urlBase = "https://mental-health-deploy.herokuapp.com/api/users/";
    final token = await authenticate(userName, password);
    final strFinal = urlBase + urlOption + "/thoughtRecords";
    final url = Uri.parse(strFinal);

    http.Response result = await http.get(url, headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    });
    if (result.statusCode == HttpStatus.ok) {
      final jsonResponse = json.decode(utf8.decode(result.bodyBytes));
      final list = jsonResponse['content'];
      print(list);
      List listOfThoughts =
          list.map<Thought>((json) => Thought.fromJson(json)).toList();
      return list;
    } else {
      throw Exception('Failed request');
    }
  }

  Future<Reminder> createAReminder(String urlOption, String userName,
      String password, Reminder reminder) async {
    int id = int.parse(urlOption);
    final requestUrl =
        "https://mental-health-deploy.herokuapp.com/api/users/$id/reminders";

    final token = await authenticate(userName, password);

    http.Response result = await http.post(
      requestUrl,
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      },
      body: jsonEncode({
        'reminderDate': reminder.reminderDate,
        'message': reminder.message,
      }),
    );
    print(result.statusCode);
    if (result.statusCode == HttpStatus.ok) {
      final jsonResponse = json.decode(result.body);
      return Reminder.fromJson(jsonResponse);
    } else {
      throw Exception('Failed request');
    }
  }

  Future<Exercise> editAnExercise(String urlOption, String userName,
      String password, String exerciseId, Exercise exercise) async {
    int id = int.parse(urlOption);
    int id2 = int.parse(exerciseId);
    //var exercise=getExercises(urlOption, userName, password);
    final requestUrl =
        "https://mental-health-deploy.herokuapp.com/api/users/$id/exercises/$id2";

    final token = await authenticate(userName, password);

    http.Response result = await http.put(
      requestUrl,
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      },
      body: jsonEncode({
        'startDate': exercise.startDate,
        'endDate': exercise.endDate,
        'message': exercise.message,
      }),
    );
    print(result.statusCode);
    if (result.statusCode == HttpStatus.ok) {
      final jsonResponse = json.decode(result.body);
      return Exercise.fromJson(jsonResponse);
    } else {
      throw Exception('Failed request');
    }
  }

  Future<int> deleteAnExercise(String urlOption, String userName,
      String password, int exerciseId) async {
    int id = int.parse(urlOption);

    final requestUrl =
        "https://mental-health-deploy.herokuapp.com/api/users/$id/exercises/$exerciseId";

    final token = await authenticate(userName, password);

    http.Response result = await http.delete(
      requestUrl,
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );
    print(result.statusCode);
    if (result.statusCode == HttpStatus.ok) {
      final jsonResponse = HttpStatus.ok;
      return HttpStatus.ok;
    } else {
      throw Exception('Failed request');
    }
  }

  Future<List> getReminders(
      String urlOption, String userName, String password) async {
    const urlBase = "https://mental-health-deploy.herokuapp.com/api/users/";
    final token = await authenticate(userName, password);
    final strFinal = urlBase + urlOption + "/reminders";
    final url = Uri.parse(strFinal);

    http.Response result = await http.get(url, headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    });
    if (result.statusCode == HttpStatus.ok) {
      final jsonResponse = json.decode(result.body);
      final list = jsonResponse['content'];
      print(list);
      List listOfExercises =
          list.map<Exercise>((json) => Exercise.fromJson(json)).toList();
      return list;
    } else {
      throw Exception('Failed request');
    }
  }

  Future<int> deleteAnReminder(String urlOption, String userName,
      String password, int reminderId) async {
    int id = int.parse(urlOption);

    final requestUrl =
        "https://mental-health-deploy.herokuapp.com/api/users/$id/reminders/$reminderId";

    final token = await authenticate(userName, password);

    http.Response result = await http.delete(
      requestUrl,
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );
    print(result.statusCode);
    if (result.statusCode == HttpStatus.ok) {
      final jsonResponse = HttpStatus.ok;
      return HttpStatus.ok;
    } else {
      throw Exception('Failed request');
    }
  }

  Future<int> deleteAnSleepRecord(
      String urlOption, String userName, String password, int sleepId) async {
    int id = int.parse(urlOption);

    final requestUrl =
        "https://mental-health-deploy.herokuapp.com/api/users/$id/sleeps/$sleepId";

    final token = await authenticate(userName, password);

    http.Response result = await http.delete(
      requestUrl,
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );
    print(result.statusCode);
    if (result.statusCode == HttpStatus.ok) {
      final jsonResponse = HttpStatus.ok;
      return HttpStatus.ok;
    } else {
      throw Exception('Failed request');
    }
  }

  Future<int> deleteAnThought(
      String urlOption, String userName, String password, int thoughtId) async {
    int id = int.parse(urlOption);

    final requestUrl =
        "https://mental-health-deploy.herokuapp.com/api/users/$id/thoughtRecords/$thoughtId";

    final token = await authenticate(userName, password);

    http.Response result = await http.delete(
      requestUrl,
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );
    print(result.statusCode);
    if (result.statusCode == HttpStatus.ok) {
      final jsonResponse = HttpStatus.ok;
      return HttpStatus.ok;
    } else {
      throw Exception('Failed request');
    }
  }

  Future<int> deleteAnGoal(
      String urlOption, String userName, String password, int goalId) async {
    int id = int.parse(urlOption);

    final requestUrl =
        "https://mental-health-deploy.herokuapp.com/api/users/$id/goals/$goalId";

    final token = await authenticate(userName, password);

    http.Response result = await http.delete(
      requestUrl,
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );
    print(result.statusCode);
    if (result.statusCode == HttpStatus.ok) {
      final jsonResponse = HttpStatus.ok;
      return HttpStatus.ok;
    } else {
      throw Exception('Failed request');
    }
  }
}
