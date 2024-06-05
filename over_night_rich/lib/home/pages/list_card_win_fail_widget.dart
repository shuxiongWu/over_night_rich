import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:over_night_rich/home/models/win_fail_model.dart';
import 'package:over_night_rich/untils/color_untils.dart';

class ListCardWinFailWidget extends StatefulWidget {
  final WinFailBattleModel battleModel;

  const ListCardWinFailWidget({super.key, required this.battleModel});

  @override
  State<ListCardWinFailWidget> createState() => _ListCardWinFailWidgetState();
}

class _ListCardWinFailWidgetState extends State<ListCardWinFailWidget> {
  @override
  Widget build(BuildContext context) {
    WinFailBattleModel battleModel = widget.battleModel;
    Color boundaryColor = Colors.grey.withOpacity(0.7);
    if (battleModel.boundary.contains("+")) {
      battleModel.boundary = battleModel.boundary.substring(1, battleModel.boundary.length);
    }
    if (int.parse(battleModel.boundary) > 0) {
      boundaryColor = Colors.green;
      battleModel.boundary = "+${battleModel.boundary}";
    } else if (battleModel.boundary.contains("-")) {
      boundaryColor = Colors.redAccent;
    }
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const SizedBox(width: 10,),
        Container(
          width: 16,
          height: 16,
          decoration: BoxDecoration(
            color: boundaryColor, // 背景颜色
            borderRadius: BorderRadius.circular(8), // 圆角边框
          ),
          child: Center(child: Text(battleModel.boundary,
            style: const TextStyle(fontSize: 10, color: Colors.white),)),
        ),
        const SizedBox(width: 4,),
        Expanded(
          child: Row(
            children: [
              winFailSubItem(battleModel.winFailItemModels[0]),
              const SizedBox(width: 1,),
              winFailSubItem(battleModel.winFailItemModels[1]),
              const SizedBox(width: 1,),
              winFailSubItem(battleModel.winFailItemModels[2]),
            ],
          ),
        )
      ],
    );
  }

  Widget winFailSubItem(WinFailItemModel itemModel) {
    return Expanded(
      child: GestureDetector(
        onTap: () {
          itemModel.isSelect.value = !itemModel.isSelect.value;
        },
        child: Obx(() {
          return Container(
            decoration: BoxDecoration(
              color: itemModel.isSelect.value ? ColorUtils.themeColor : Colors.white, // 背景颜色
              border: Border.all(
                color: Colors.grey.withOpacity(0.2), // 边框颜色
                width: 1, // 边框宽度
              ),
            ),
            height: 35,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "  ${itemModel.name}", style: TextStyle(fontSize: 12, color: itemModel.isSelect.value ? Colors.white : Colors.black),),
                Text("${itemModel.value} ", style: TextStyle(
                    fontSize: 12, color: itemModel.isSelect.value ? Colors.white : Colors.grey.withOpacity(0.7)),),
              ],
            ),
          );
        }),
      ),
    );
  }

}
