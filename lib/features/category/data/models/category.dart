import 'package:taskom/core/constants/constants.dart';

class Category {
  final String? id;
  final String? title;
  final String? icon;
  final String? color;

  Category({
    this.id,
    this.title,
    this.icon,
    this.color,
  });

  factory Category.fromMapJson(Map<String, dynamic> jsonObject) {
    return Category(
      id: jsonObject['id'],
      title: jsonObject['title'],
      icon:
          '${Constants.BASE_URL}files/${jsonObject['collectionId']}/${jsonObject['id']}/${jsonObject['icon']}',
      color: jsonObject['color'],
    );
  }
}
