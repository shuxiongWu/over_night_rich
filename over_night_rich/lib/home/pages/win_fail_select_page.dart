import 'package:expandable/expandable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:intl/intl.dart';
import 'package:over_night_rich/home/controllers/win_fail_select_controller.dart';
import 'package:over_night_rich/home/pages/list_card_widget.dart';
import 'package:over_night_rich/home/pages/order_confirm_widget.dart';
import 'package:over_night_rich/untils/time_untils.dart';

class WinFailSelectPage extends StatefulWidget {
  const WinFailSelectPage({super.key});

  @override
  State<WinFailSelectPage> createState() => _WinFailSelectPageState();
}

class _WinFailSelectPageState extends State<WinFailSelectPage> {
  final _controller = Get.put(WinFailController());

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned(
          top: 0,
          left: 0,
          bottom: 0,
          right: 0,
            child: Obx(() {
              return Padding(
                padding: const EdgeInsets.only(top: 12),
                child: ListView.builder(
                    itemCount: _controller.dataList.length,
                    itemBuilder: (context, index)
                    {
                      return ExpandableNotifier(
                        child: Padding(
                          padding: const EdgeInsets.all(3),
                          child: Card(
                            child: ExpandablePanel(
                              header: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text('${TimeUntils.formatDate(_controller.dataList[index].bet_date)}(${TimeUntils.getWeekdayOrToday(_controller.dataList[index].bet_date)})   共${_controller.dataList[index].battleList.length}场比赛'),
                              ),
                              collapsed: const SizedBox(),
                              expanded: Column(
                                  children: List.generate(_controller.dataList[index].battleList.length, (indexChild) =>
                                      ListCardWidget(battleModel: _controller.dataList[index].battleList[indexChild]))
                              ),
                            ),
                          ),
                        ),
                      );
                    }),
              );
            })
        ),
        Positioned(
            bottom: 0,
            right: 0,
            left: 0,
            child: OrderConfirmWidget(dataList: _controller.dataList,)
        )
      ],
    );
  }

}
