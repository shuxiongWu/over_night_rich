import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:over_night_rich/constants/net_config.dart';
import 'package:over_night_rich/home/models/win_fail_model.dart';
import 'package:over_night_rich/router/rich_pages.dart';
import 'package:over_night_rich/untils/color_untils.dart';

class ListCardLeftWidget extends StatefulWidget {
  final WinFailBattleModel battleModel;
  const ListCardLeftWidget({super.key, required this.battleModel});

  @override
  State<ListCardLeftWidget> createState() => _ListCardLeftWidgetState();
}

class _ListCardLeftWidgetState extends State<ListCardLeftWidget> {

  @override
  Widget build(BuildContext context) {
    WinFailBattleModel battleModel = widget.battleModel;
    bool isHasRank = battleModel.hostTeamInfoModel.rank.isNotEmpty && battleModel.guestTeamInfoModel.rank.isNotEmpty;
    String color = "0xFFF5F5F5";
    Color textColor = ColorUtils.secondaryTextColor;
    if (battleModel.league_color.isNotEmpty) {
      color = "0xFF${battleModel.league_color.first.substring(1, battleModel.league_color.first.length)}";
      textColor = Colors.white;
    }

    return GestureDetector(
      onTap: (){
        String url = "https://koudai.17itou.com/460/match2/?abvertising_id=qEUdvOwkdhspRggvpHlmhNwNTijIjm&pageName=history&matchid=${battleModel.match_id}&lotteryId=${battleModel.lottery_no}&token=${NetConfig.token}";
        // 点击事件
        Get.toNamed(RichPages.webView, arguments: {"url": url});
      },
      child: Column(
        children: [
          Text(battleModel.serial_no, style: const TextStyle(fontSize: 10),),
          const SizedBox(height: 2,),
          Container(
              width: 60,
              height: 16,
              color: Color(int.parse(color)),
              child: Center(child: Text(battleModel.league_name, style: TextStyle(fontSize: 10, color: textColor)))
          ),
          timeWiget(isHasRank, battleModel),
          const SizedBox(height: 2,),
          const Text("分析", style: TextStyle(fontSize: 10, color: Colors.lightBlueAccent),),
        ],
      ),
    );
  }

  Widget timeWiget(bool isNeed, WinFailBattleModel battleModel) {
    Widget widget1 = Column(
      children: [
        const SizedBox(height: 2,),
        Text("${battleModel.bet_time.split(" ").last.split(":").first}:${battleModel.bet_time.split(" ").last.split(":")[1]}", style: const TextStyle(fontSize: 10)),
      ],
    );
    Widget widget2 = const SizedBox();
    if (isNeed) {
      return widget1;
    } else {
      return widget2;
    }
  }

}
