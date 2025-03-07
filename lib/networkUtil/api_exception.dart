import 'package:dio/dio.dart';

class ApiException implements Exception {
  int? code;
  String? message;
  Response<dynamic>? response;
  ApiException(this.code, this.message, {this.response}) {
    switch (code) {
      case 400:
        message = 'تمامی پارامترهای اجباری وارد نشده اند.';
        break;
      case 401:
        message = 'رمزینه نادرست است.';
        break;
      case 402:
        message =
            'درخواست با خطا روبرو شده است.(درصورت برطرف نشدن خطا با پشتیبانی تماس بگیرید.)';
        break;
      case 403:
        message =
            'درخواست با خطا روبرو شده است.(درصورت برطرف نشدن خطا با پشتیبانی تماس بگیرید.)';
        break;
      case 404:
        message = 'اطلاعاتی یافت نشده است.';
        break;
      case 409:
        message = 'درخواست شما با قوانین و مقررات مغایرت دارد.';
        break;
      case 429:
        message = 'تعداد درخواست های شما بیش از حد مجاز است.';
        break;

      default:
        message = '	ارتباط با سرور برقرار نشده است.';
    }
  }
}
