import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:over_night_rich/home/controllers/order_list_controller.dart';
import 'package:easy_refresh/easy_refresh.dart';
import 'package:over_night_rich/home/models/order_list_model.dart';
import 'package:over_night_rich/router/rich_pages.dart';
import 'package:over_night_rich/untils/color_untils.dart';
import 'package:over_night_rich/untils/time_untils.dart';

class OrderListPage extends StatefulWidget {
  const OrderListPage({super.key});

  @override
  State<OrderListPage> createState() => _OrderListPageState();
}

class _OrderListPageState extends State<OrderListPage> {
  final _controller = Get.put(OrderListController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorUtils.backgroundColor,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: ColorUtils.themeColor,
          title: const Text(
            '选号记录',
            style: TextStyle(fontSize: 18),
          ),
        ),
      body: EasyRefresh (
        controller: _controller.easyRefreshController,
        onRefresh: _controller.onRefresh,
        onLoad: _controller.onLoad,
        child: Obx(() {
          return Padding(
            padding: const EdgeInsets.only(left: 12, right: 12),
            child: Container(
              color: Colors.white,
              child: ListView.separated(
                  itemCount: _controller.dataList.length,
                  itemBuilder: (context, index) {
                    return _buildItem(_controller.dataList[index]);
                  }, separatorBuilder: (BuildContext context, int index) {
                    return const Divider(color: ColorUtils.dividerColor, height: 1,);
              },),
            ),
          );
        }),
      )
    );
  }

  Widget _buildItem(OrderListModel model) {
    return Material(  // 添加 Material widget
      color: Colors.transparent,  // 设置透明背景
      child: InkWell(
        onTap: () {
          _controller.pushToOrderDetailPage(model);
        },
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Row(
            children: [
              _dateItem(model),
              const SizedBox(width: 20,),
              _midItem(model),
              const Expanded(child: SizedBox()),
              _rightItem(model),
              const SizedBox(width: 8,),
              const Icon(Icons.arrow_forward_ios_outlined, color: ColorUtils.arrowColor, size: 16,)
            ],
          ),
        ),
      ),
    );
  }


  Widget _dateItem(OrderListModel model) {
    DateTimeModel dateTimeModel = TimeUntils.formatTime(model.createTime);
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        border: Border.all(color: Colors.grey.withOpacity(0.8), width: 1),
      ),
      child: Column(
        children: [
          Container(
            color: Colors.blue.shade200,
              width: 40,
              height: 30,
              child: Center(child: Text(dateTimeModel.day, style: const TextStyle(color: ColorUtils.primaryTextColor),))
          ),
          SizedBox(
              width: 40,
              height: 30,
              child: Center(child: Text("${dateTimeModel.month}月", style: const TextStyle(fontSize: 12, color: ColorUtils.secondaryTextColor),))
          ),
        ],
      ),
    );
  }

  Widget _midItem(OrderListModel model) {
    Color color = model.submitStatus == 1 ? Colors.green : ColorUtils.backgroundColor;
    Color bordColor = model.submitStatus == 1 ? Colors.green : ColorUtils.dividerColor;
    Color textColor = model.submitStatus == 1 ? Colors.white : Colors.grey.shade700;
    if (model.statusText.contains("奖金")) {
      color = ColorUtils.warningColor;
      bordColor =  ColorUtils.warningColor;
      textColor = Colors.white;
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
            width: 100,
            height: 30,
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(15),
              border: Border.all(color: bordColor, width: 1),
            ),
            child: Center(child: Text(model.statusText, style: TextStyle(color: textColor),))
        ),
        const SizedBox(height: 8,),
        Text(model.endTimeText, style: const TextStyle(color: ColorUtils.secondaryTextColor),),
      ],
    );
  }

  Widget _rightItem(OrderListModel model) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Text(model.lotteryTypeText, style: const TextStyle(color: ColorUtils.secondaryTextColor, fontSize: 12),),
        const SizedBox(height: 8,),
        Text(model.totalMoney.toString(), style: const TextStyle(fontSize: 14, color: ColorUtils.primaryTextColor),),
      ],
    );
  }

}
