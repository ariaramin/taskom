import 'package:taskom/config/constants/constants.dart';

class TaskModel {
  final String? id;
  final String? userId;
  final String? thumbnail;
  final String? title;
  final String? note;
  final String? categoryId;
  final bool? isDone;
  final DateTime? dateTime;

  TaskModel({
    this.id,
    this.userId,
    this.thumbnail,
    this.title,
    this.note,
    this.categoryId,
    this.isDone,
    this.dateTime,
  });

  factory TaskModel.fromMapJson(Map<String, dynamic> jsonObject) {
    return TaskModel(
      id: jsonObject['id'],
      userId: jsonObject['user'],
      // thumbnail:
      //     '${Constants.BASE_URL}files/${jsonObject['collectionId']}/${jsonObject['id']}/${jsonObject['thumbnail']}',
      thumbnail: jsonObject['thumbnail'],
      title: jsonObject['title'],
      note: jsonObject['note'],
      categoryId: jsonObject['category'],
      isDone: jsonObject['isDone'],
      dateTime: DateTime.tryParse(jsonObject['date']),
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'user': userId,
        'thumbnail': thumbnail,
        'title': title,
        'note': note,
        'category': categoryId,
        'isDone': isDone,
        'date': dateTime?.toIso8601String(),
      };
}
