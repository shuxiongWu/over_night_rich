import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:over_night_rich/constants/net_config.dart';

import '../models/order_detail_model.dart';

class OrderDetailController extends GetxController {
  final int projectId;
  final String pUdid;
  RxBool isLoad = false.obs;
  final preTimeStr = "".obs;
  double totalMoney = 0.0;
  OrderDetailModel orderDetailModel = OrderDetailModel(battleList: []);

  OrderDetailController({required this.projectId, required this.pUdid});

  @override
  void onInit() {
    super.onInit();
    requestData();
  }

  Future<void> requestData() async {
    EasyLoading.show();
    final result = await NetConfig.dio.post(NetConfig.orderDetail,
        queryParameters: {
          "project_id": projectId,
          "p_uuid": pUdid,
          "token": NetConfig.token
        });
    Map value = result.data["data"];
    //处理胜平负的数据
    List matchSeqs = value["match_seq"];
    Map matchMap = value["match_list"];
    //具体选中的比赛
    String wagers = value["wagers"][0]["wager"];
    List battleList = [];
    matchSeqs.forEach((element) {
      Map match = matchMap[element];
      List<bool> wagerList = parseResults(wagers, element);
      Map oodMap = match["list"]["WDL"];
      battleList.add({
        "hostTeamInfo": {
          "rank": match["rank"],
          "team_name": match["host_name_s"],
          "rank_league": match["rank_league"],
          "half_goals": match["half_host_goals"],
          "full_goals": match["host_goals"],
        },
        "guestTeamInfo": {
          "rank": match["rank"],
          "team_name": match["guest_name_s"],
          "rank_league": match["rank_league"],
          "half_goals": match["half_guest_goals"],
          "full_goals": match["guest_goals"],
        },
        "bet_time": match["bet_time"],
        "boundary": oodMap["boundary"],
        "league_name": match["league_name"],
        "bet_date": match["bet_date"],
        "match_time": match["match_time"],
        "host_name_l": match["host_name_l"],
        "guest_name_l": match["guest_name_l"],
        "serial_no": match["serial_no"],
        "winFailItem": [
          {
            "value": oodMap["odds"]["3"],
            "name": "胜",
            "winFailEnum": 3,
            "isSelect": wagerList[0],
            "isResult": oodMap["boundary"] == "3",
          },
          {
            "value": oodMap["odds"]["1"],
            "name": "平",
            "winFailEnum": 1,
            "isSelect": wagerList[1],
            "isResult": oodMap["boundary"] == "1",
          },
          {
            "value": oodMap["odds"]["0"],
            "name": "负",
            "winFailEnum": 0,
            "isSelect": wagerList[2],
            "isResult": oodMap["boundary"] == "0",
          }
        ]
      });
    });

    Map<String, dynamic> data = {
      "multiple": value["multiple"], // "multiple": 1,
      "ticket_count": value["ticket_count"],
      "lottery_no": value["lottery_no"],
      "end_time": value["end_time"],
      "print_end_time": value["print_end_time"],
      "pass_type": value["pass_type"],
      "create_time": value["create_time"],
      "total_money": value["total_money"],
      "pre_prize_time": value["pre_prize_time"],
      "real_prize_time": value["real_prize_time"],
      "real_money": value["real_money"],
      "count": value["count"],
      "lottery_type_text": value["lottery_type_text"],
      "status_info": value["status_info"],
      "battleList": battleList
    };

    orderDetailModel = OrderDetailModel.fromJson(data);
    preTimeStr.value = "预计${orderDetailModel.prePrizeTime}开奖";
    isLoad.value = true;

    calculateMaxPrize();

    EasyLoading.dismiss();
    update();
  }

  //计算最高奖金
  calculateMaxPrize() {
    double maxPrize = 1;
    for (var battle in orderDetailModel.battleList) {
      //找到选中的项赔率最高的，一直相乘
      double maxOdds = 0.0;
      battle.winFailItemModels.forEach((element) {
        if (element.isSelect.value) {
          maxOdds = maxOdds > element.value ? maxOdds : element.value;
        }
      });
      maxPrize = maxPrize * maxOdds;
    }
    totalMoney = maxPrize * 2 * 0.65;
    if (totalMoney > 5000000) {
      totalMoney = 5000000;
    }
  }

  List<bool> parseResults(String data, String key) {
    List<bool> results = [false, false, false];
    Map<String, List<String>> map = {};

    // 分割整个字符串，得到每一部分
    var parts = data.split(';');
    for (var part in parts) {
      var splitPart = part.split(':');
      if (splitPart.length == 2) {
        // 存储每个键和值（值被进一步按逗号分割）
        map[splitPart[0]] = splitPart[1].split(',');
      }
    }

    // 检查是否有对应键的数据
    if (map.containsKey(key)) {
      var values = map[key]!;
      // 设置返回数组的对应位置
      results[0] = values.contains('3');
      results[1] = values.contains('1');
      results[2] = values.contains('0');
    }

    return results;
  }

}
