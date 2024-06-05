import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:over_night_rich/home/models/win_fail_model.dart';

class OrderConfirmWidget extends StatefulWidget {
  final List<WinFailModel> dataList;

  const OrderConfirmWidget({super.key, required this.dataList});

  @override
  State<OrderConfirmWidget> createState() => _OrderConfirmWidgetState();
}

class _OrderConfirmWidgetState extends State<OrderConfirmWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      color: Colors.white,
      child: Column(children: [
        const Row(
          children: [
            SizedBox(width: 10),
            Text("投注内容", style: TextStyle(fontSize: 16, color: Colors.black)),
            Expanded(child: SizedBox()),
            Text("1倍", style: TextStyle(fontSize: 16, color: Colors.black)),
            SizedBox(width: 10),
          ],
        ),
        Row(
          children: [
            const Icon(Icons.delete_forever_outlined),
            const Expanded(child: SizedBox()),
            ElevatedButton(
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.black,
                  backgroundColor: Colors.white, // 文字颜色
                ),
                onPressed: () {
                  EasyLoading.showToast("功能待开发");
                },
                child: const Text("保存")),
            const SizedBox(width: 4),
            ElevatedButton(
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.black,
                  backgroundColor: Colors.white, // 文字颜色
                ),
                onPressed: () {
                  EasyLoading.showToast("功能待开发");
                },
                child: const Text("合买")),
            const SizedBox(width: 4),
            ElevatedButton(
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white,
                  backgroundColor: const Color(0xFF051716), // 文字颜色
                ),
                onPressed: () {
                  EasyLoading.showToast("功能待开发");
                },
                child: const Text("下一步")),
          ],
        ),
        SizedBox(
          height: MediaQuery.of(context).padding.bottom,
        )
      ]),
    );
  }
}
