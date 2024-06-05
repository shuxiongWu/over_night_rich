import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:over_night_rich/home/models/win_fail_model.dart';
import 'package:over_night_rich/untils/color_untils.dart';
import 'package:over_night_rich/untils/time_untils.dart';

class ListCardTeamInfoWidget extends StatefulWidget {
  final WinFailBattleModel battleModel;
  const ListCardTeamInfoWidget({super.key, required this.battleModel});

  @override
  State<ListCardTeamInfoWidget> createState() => _ListCardTeamInfoWidgetState();
}

class _ListCardTeamInfoWidgetState extends State<ListCardTeamInfoWidget> {
  @override
  Widget build(BuildContext context) {
    WinFailBattleModel battleModel = widget.battleModel;
    bool isHasRank = battleModel.hostTeamInfoModel.rank.isNotEmpty && battleModel.guestTeamInfoModel.rank.isNotEmpty;
    return isHasRank ? selectWidget(battleModel) : resultWidget(battleModel);
  }

  Widget selectWidget(WinFailBattleModel battleModel) {
    return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text("[${battleModel.hostTeamInfoModel.rank}]\n${battleModel.hostTeamInfoModel.rank_league}", style: const TextStyle(fontSize: 10, color: Colors.grey),textAlign: TextAlign.center,),
              const SizedBox(width: 4,),
              Text(battleModel.hostTeamInfoModel.team_name),
            ],
          )),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 8),
            child: Text('VS'),
          ),
          Expanded(child: Row(
            children: [
              Text(battleModel.guestTeamInfoModel.team_name),
              const SizedBox(width: 4,),
              Text("[${battleModel.guestTeamInfoModel.rank}]\n${battleModel.guestTeamInfoModel.rank_league}", style: const TextStyle(fontSize: 10, color: Colors.grey),textAlign: TextAlign.center,),
            ],
          )),
        ]
    );
  }

  Widget resultWidget(WinFailBattleModel battleModel) {
    DateTimeModel model = TimeUntils.formatTime(battleModel.match_time);
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly, // 中心对齐所有子元素
        children: <Widget>[
          Expanded( // 使用Expanded包裹左侧文本
            child: Text(battleModel.hostTeamInfoModel.team_name, textAlign: TextAlign.right, style: const TextStyle(fontSize: 14)),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Text('${model.month}/${model.day} ${model.hour}:${model.minute}', style: TextStyle(fontSize: 12, color: ColorUtils.secondaryTextColor)),
          ),
          Expanded( // 使用Expanded包裹右侧文本
            child: Text(battleModel.guestTeamInfoModel.team_name, textAlign: TextAlign.left, style: const TextStyle(fontSize: 14)),
          ),
        ],
      ),
    );
  }

}
