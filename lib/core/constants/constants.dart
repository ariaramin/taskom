import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import 'package:taskom/config/theme/app_colors.dart';

class Constants {
  // urls
  static const String BASE_URL = "https://taskom.fly.dev/api/";
  static const String TASKS_RECORDS_URL = "collections/tasks/records";
  static const String CATEGORIES_RECORDS_URL = "collections/categories/records";
  static const String GALLERY_RECORDS_URL = "collections/gallery/records";
  static const String AVATARS_RECORDS_URL = "collections/avatars/records";
  static const String AUTH_WITH_PASS_URL =
      "collections/users/auth-with-password";
  static const String AUTH_REFRESH_URL = "collections/users/auth-refresh";
  static const String USERS_RECORDS_URL = "collections/users/records";

  // messages
  static const String AUTH_ERROR_MESSAGE = "احراز هویت ناموفق بود.";
  static const String LOGIN_SUCCESS_MESSAGE = "شما با موفقیت وارد شده اید";
  static const String REGISTER_ERROR_MESSAGE = "ثبت نام ناموفق بود.";
  static const String REGISTER_SUCCESS_MESSAGE = "ثبت نام با موفقیت انجام شد.";
  static const String PROFILE_UPDATED_SUCCESS_MESSAGE =
      "پروفایل با موفقیت ویرایش شد.";
  static const String BLANK_ERROR_MESSAGE = "این فیلد نباید خالی باشد.";
  static const String NO_TASK_FOR_TODAY_MESSAGE = "تسکی برای امروز وجود ندارد";
  static const String NO_TASK_MESSAGE = "تسکی وجود ندارد";
  static const String NO_TASK_AT_THIS_TIME_MESSAGE =
      "تسکی در این بازه زمانی وجود ندارد";
  static const String NONE_TEXTUAL_ERROR_MESSAGE = "خطا محتوای متنی ندارد";
  static const String CONNECTION_ERROR_MESSAGE = "اتصال به شبکه ناموفق بود";
  static const String TASK_SAVED_MESSAGE = "تسک مورد نظر با موفقیت ثبت شد";
  static const String TASK_DELETED_MESSAGE = "تسک مورد نظر با موفقیت حذف شد";
  static const String ERROR_MESSAGE = "مشکلی پیش آمده است";
  static const String SUCCESS_MESSAGE = "عملیات موفقیت آمیز بود";

  static SnackBar getSnackBar({
    required String title,
    required String message,
    required ContentType type,
  }) {
    return SnackBar(
      elevation: 0,
      behavior: SnackBarBehavior.floating,
      backgroundColor: Colors.transparent,
      content: AwesomeSnackbarContent(
        title: title,
        message: message,
        contentType: type,
        color: type == ContentType.success
            ? AppColors.successColor
            : AppColors.errorColor,
      ),
    );
  }
}
