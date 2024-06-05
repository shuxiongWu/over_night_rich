import 'package:dio/dio.dart';

class NetConfig {

  static final dio = Dio();

  static const String BASE_URL = 'https://apic.91bixin.net';
  static const String token = 'yt9np917h28i2c0ihc21oc4plw1xvtd901362i12495osy1u';
  static const String orderList = '$BASE_URL/api/savelist';
  static const String winFailList = '$BASE_URL/api/dc/selectlist';
  static const String orderDetail = '$BASE_URL/api/project/detailV2';
}