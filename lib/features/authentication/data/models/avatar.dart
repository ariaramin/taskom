import 'package:taskom/config/constants/constants.dart';

class Avatar {
  final String? id;
  final String? main;
  final String? second;
  final String? welcome;

  Avatar({
    this.id,
    this.main,
    this.second,
    this.welcome,
  });

  factory Avatar.fromMapJson(Map<String, dynamic> jsonObject) {
    return Avatar(
      id: jsonObject['id'],
      main:
          '${Constants.BASE_URL}files/${jsonObject['collectionId']}/${jsonObject['id']}/${jsonObject['main']}',
      second:
          '${Constants.BASE_URL}files/${jsonObject['collectionId']}/${jsonObject['id']}/${jsonObject['second']}',
      welcome:
          '${Constants.BASE_URL}files/${jsonObject['collectionId']}/${jsonObject['id']}/${jsonObject['welcome']}',
    );
  }
}
