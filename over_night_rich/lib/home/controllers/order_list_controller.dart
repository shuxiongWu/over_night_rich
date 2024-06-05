import 'package:easy_refresh/easy_refresh.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:over_night_rich/constants/net_config.dart';
import 'package:over_night_rich/router/rich_pages.dart';
import '../models/order_list_model.dart';

class OrderListController extends GetxController {
  List<OrderListModel> dataList = <OrderListModel>[].obs;
  int pageNum = 1;
  int pageSize = 20;
  EasyRefreshController easyRefreshController = EasyRefreshController();

  @override
  void onInit() {
    super.onInit();
    requestData(isNeedLoading: true);
  }

  Future<IndicatorResult> onRefresh() async {
    await requestData(isNeedRresh: true);
    return IndicatorResult.success;
  }

  Future<IndicatorResult> onLoad() async {
    await requestData();
    return IndicatorResult.success;
  }

  Future<void> requestData(
      {bool isNeedRresh = false, bool isNeedLoading = false}) async {
    if (isNeedRresh) {
      pageNum = 1;
    }
    if (isNeedLoading) {
      EasyLoading.show();
    }
    final res = await NetConfig.dio.post(NetConfig.orderList, queryParameters: {
      "page": pageNum,
      "pageSize": pageSize,
      "lottery_type": "DanChang",
      "token": NetConfig.token
    });
    EasyLoading.dismiss();
    pageNum++;
    if (isNeedRresh) {
      dataList.clear();
    }
    List list = res.data["data"];
    list.forEach((element) {
      dataList.add(OrderListModel.fromJson(element));
    });
  }

  void pushToOrderDetailPage(OrderListModel model) {
    Get.toNamed(RichPages.orderDetail,
        arguments: {"projectId": model.projectId, "pUuid": model.pUuid});
  }
}
