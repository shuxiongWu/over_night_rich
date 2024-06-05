import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:over_night_rich/constants/net_config.dart';
import 'package:over_night_rich/home/models/win_fail_model.dart';

class WinFailController extends GetxController {
  List<WinFailModel> dataList = <WinFailModel>[].obs;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    requestData();
  }

  Future<void> requestData() async {
    EasyLoading.show();
    final response = await NetConfig.dio.get(NetConfig.winFailList, queryParameters: {"token": NetConfig.token});
    EasyLoading.dismiss();
    Map<String, dynamic> data = response.data["data"];
    //将data里面根据key的大小来排序生成一个数组，然后赋值给dataList，key是格式化时间2024-05-21，按照先后顺序排列
    List<String> keys = data.keys.toList();
    keys.sort((a, b) => a.compareTo(b));
    List list = [];
    keys.forEach((element) {
      list.add(data[element]);
    });
    list.forEach((element) {
      dataList.add(WinFailModel.fromJson(element));
    });
    //

  }

}