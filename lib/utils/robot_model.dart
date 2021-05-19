import 'package:flutter/cupertino.dart';

class Robot {
  final int id;
  final String name;
  final String email;

  Robot(this.id, {@required this.name, @required this.email});

  Robot.fromJson(Map<String, dynamic> map)
      : name = map['name'] as String,
        email = map['email'] as String,
        id = map['id'] as int;
}
