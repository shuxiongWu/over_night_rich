import 'dart:convert';
import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'dart:typed_data';
import 'package:flutter/cupertino.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:over_night_rich/home/controllers/order_detail_controller.dart';
import 'package:over_night_rich/untils/color_untils.dart';
import 'package:permission_handler/permission_handler.dart';
import 'list_card_widget.dart';

class OrderDetailPage extends StatefulWidget {
  const OrderDetailPage({super.key});

  @override
  State<OrderDetailPage> createState() => _OrderDetailPageState();
}

class _OrderDetailPageState extends State<OrderDetailPage> {
  late OrderDetailController _controller;
  final GlobalKey _repaintKey = GlobalKey();

  @override
  void initState() {
    super.initState();
    final arguments = Get.arguments;
    _controller = Get.put(OrderDetailController(
        projectId: arguments['projectId'], pUdid: arguments['pUuid']));
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<OrderDetailController>(
      assignId: true,
      builder: (logic) {
        return Scaffold(
            appBar: AppBar(
              actions: <Widget>[
                TextButton(
                    onPressed: () {
                      saveImageToAblum();
                    },
                    child: const Text(
                      '保存',
                      style: TextStyle(color: Colors.white, fontSize: 16),
                    ))
              ],
              elevation: 0,
              backgroundColor: ColorUtils.themeColor,
              title: Column(
                children: [
                  const Text(
                    '方案详情',
                    style: TextStyle(fontSize: 18),
                  ),
                  Text(_controller.preTimeStr.value,
                      style: const TextStyle(fontSize: 14))
                ],
              ),
            ),
            body: _controller.isLoad.value ? SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(
                    height: _controller.orderDetailModel.battleList.length *
                        80 + 100 + MediaQuery.of(context).padding.top, // Force a long content size
                    child: RepaintBoundary(
                      key: _repaintKey,
                      child: ListView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        // Disable scrolling
                        itemCount: _controller.orderDetailModel.battleList
                            .length + 1,
                        itemBuilder: (context, index) {
                          if (index == 0) return headerView();
                          return ListCardWidget(
                              battleModel: _controller.orderDetailModel
                                  .battleList[index - 1]);
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ) : const SizedBox());
      },
    );
  }

  Widget headerView() {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Column(
        children: [
          SizedBox(height: MediaQuery.of(context).padding.top,),
          Row(
            children: [
              RichText(
                  text: TextSpan(children: [
                    const TextSpan(
                        text: '金额：',
                        style: TextStyle(
                            color: ColorUtils.secondaryTextColor,
                            fontSize: 14)),
                    TextSpan(
                        text:
                        _controller.orderDetailModel.totalMoney.toString(),
                        style: const TextStyle(
                            color: ColorUtils.themeColor, fontSize: 14)),
                    TextSpan(
                        text: '元 [${_controller.orderDetailModel
                            .multiple}倍]',
                        style: const TextStyle(
                            color: ColorUtils.secondaryTextColor,
                            fontSize: 14)),
                  ])),
              const Expanded(child: SizedBox()),
              RichText(
                  text: TextSpan(children: [
                    const TextSpan(
                        text: '理论最高奖金：',
                        style: TextStyle(
                            color: ColorUtils.secondaryTextColor,
                            fontSize: 14)),
                    TextSpan(
                        text: _controller.totalMoney.toStringAsFixed(2),
                        style: const TextStyle(
                            decoration: TextDecoration.underline,
                            decorationColor: ColorUtils.themeColor, // 下滑线颜色
                            color: ColorUtils.themeColor,
                            fontSize: 14)),
                    const TextSpan(
                        text: '元',
                        style: TextStyle(
                            color: ColorUtils.secondaryTextColor,
                            fontSize: 14)),
                  ])),
            ],
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              Text(_controller.orderDetailModel.lotteryTypeText,
                  style: const TextStyle(
                      color: ColorUtils.linkColor, fontSize: 14)),
              const SizedBox(width: 4),
              RichText(
                  text: TextSpan(children: [
                    const TextSpan(
                        text: '选',
                        style: TextStyle(
                            color: ColorUtils.secondaryTextColor,
                            fontSize: 14)),
                    TextSpan(
                        text: _controller.orderDetailModel.battleList
                            ?.length
                            .toString(),
                        style: const TextStyle(
                            color: ColorUtils.themeColor, fontSize: 14)),
                    const TextSpan(
                        text: '场',
                        style: TextStyle(
                            color: ColorUtils.secondaryTextColor,
                            fontSize: 14)),
                  ])),
              const SizedBox(width: 4),
              Text(_controller.orderDetailModel.passType.replaceAll(
                  '_', '串'),
                  style: const TextStyle(
                      color: ColorUtils.themeColor, fontSize: 14)),
              const Expanded(child: SizedBox()),
              Text("第${_controller.orderDetailModel.lotteryNo}期",
                  style: const TextStyle(
                      color: ColorUtils.secondaryTextColor, fontSize: 14)),
            ],
          )
        ],
      ),
    );
  }

  Widget listView() {
    return Column(
      children: _controller.orderDetailModel.battleList
          .map((e) =>
          ListCardWidget(
            battleModel: e,
          ))
          .toList(),
    );
  }

  saveImageToAblum() async {
    await requestPermissions();
  }

  Future<void> requestPermissions() async {
    var status = await Permission.storage.status;
    if (!status.isGranted) {
      await Permission.storage.request();
    }
    if (status.isGranted) {
      _takeScreenshot();
    }
  }

  Future<void> _takeScreenshot() async {
    EasyLoading.show(status: "正在保存...");
    try {
      RenderRepaintBoundary boundary = _repaintKey.currentContext!
          .findRenderObject() as RenderRepaintBoundary;
      ui.Image image = await boundary.toImage(pixelRatio: 2.0);
      ByteData? byteData = await image.toByteData(
          format: ui.ImageByteFormat.png);
      Uint8List pngBytes = byteData!.buffer.asUint8List();

      final result = await ImageGallerySaver.saveImage(
          pngBytes, quality: 100); // 保存图片时设置最高质量
      EasyLoading.showSuccess("保存成功");
      print("Image Saved to Gallery: $result");
    } catch (e) {
      EasyLoading.showError("保存失败");
      print("Error capturing image: $e");
    }
  }

}
