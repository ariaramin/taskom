import 'package:taskom/config/constants/constants.dart';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:taskom/config/extentions/datetime_extention.dart';

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

  Future<String> urlToFile() async {
    final response = await http.get(Uri.parse(main!));
    final directory = await getApplicationDocumentsDirectory();
    final file =
        File(join(directory.path, "${DateTime.now().getGregorianDate()}.png"));
    file.writeAsBytesSync(response.bodyBytes);
    return file.path;
  }
}
