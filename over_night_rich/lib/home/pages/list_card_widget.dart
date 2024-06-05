import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:over_night_rich/home/models/win_fail_model.dart';
import 'package:over_night_rich/home/pages/list_card_left_widget.dart';
import 'package:over_night_rich/home/pages/list_card_team_info_widget.dart';
import 'package:over_night_rich/home/pages/list_card_win_fail_widget.dart';
import 'package:over_night_rich/untils/color_untils.dart';

class ListCardWidget extends StatefulWidget {
  final WinFailBattleModel battleModel;
  const ListCardWidget({super.key, required this.battleModel});

  @override
  State<ListCardWidget> createState() => _ListCardWidgetState();
}

class _ListCardWidgetState extends State<ListCardWidget> {
  @override
  Widget build(BuildContext context) {
    return listCard(widget.battleModel);
  }

  Widget listCard(WinFailBattleModel battleModel) {

    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: ColorUtils.backgroundColor,
        border: Border(
          top: BorderSide(
            color: Colors.grey.withOpacity(0.2), // 边框颜色
            width: 1, // 边框宽度
          ),
        ),
      ),
      child: Row(
        children: [
          ListCardLeftWidget(battleModel: battleModel),
          Expanded(
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  ListCardTeamInfoWidget(battleModel: battleModel),
                  ListCardWinFailWidget(battleModel: battleModel),
                ]
            ),
          )
        ],
      ),
    );
  }

}
