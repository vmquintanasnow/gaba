import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart';
import 'package:http/http.dart' as http;
import 'package:screening/utils/robot_model.dart';

class RobotRepository {
  static Future<List<Robot>> getRobots() async {
    final List<Robot> robots = [];
    const String url = 'https://jsonplaceholder.typicode.com/users';
    final Uri uri = Uri.parse(url);

    final Response response = await http.get(uri);

    if (response.statusCode == 200) {
      try {
        final List<dynamic> body = json.decode(response.body) as List;

        final mappedBody = body.map((e) => Robot.fromJson(e as Map<String, dynamic>)).toList();
        robots.addAll(mappedBody);
      } catch (error, stack) {
        log('$error', error: error, stackTrace: stack);
      }
    }
    return robots;
  }
}
