import 'package:taskom/config/constants/constants.dart';

class DbException implements Exception {
  String? message;

  DbException({this.message});

  factory DbException.noRecords() =>
      DbException(message: Constants.NO_RECORDS_MESSAGE);
}
