import 'package:taskom/core/constants/constants.dart';

class Gallery {
  final String? id;
  final String? image;

  Gallery({this.id, this.image});

  factory Gallery.fromMapJson(Map<String, dynamic> jsonObject) {
    return Gallery(
      id: jsonObject['id'],
      image:
          '${Constants.BASE_URL}files/${jsonObject['collectionId']}/${jsonObject['id']}/${jsonObject['image']}',
    );
  }
}
