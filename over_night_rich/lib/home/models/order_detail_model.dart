import 'package:get/get.dart';
import 'package:over_night_rich/home/models/win_fail_model.dart';

class OrderDetailModel {
  /*
  "ticket_count": value["ticket_count"],
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
   */
  final int ticketCount;
  final String endTime;
  final String printEndTime;
  final String lotteryNo;
  final String passType;
  final String createTime;
  final int totalMoney;
  final String prePrizeTime;
  final String realPrizeTime;
  final int realMoney;
  final int count;
  final int multiple;
  final String lotteryTypeText;
  final StatusInfoModel? statusInfo;
  final List<WinFailBattleModel> battleList;

  OrderDetailModel({
    this.ticketCount = 0,
    this.multiple = 1,
    this.lotteryNo = '',
    this.endTime = '',
    this.printEndTime = '',
    this.passType = '',
    this.createTime = '',
    this.totalMoney = 0,
    this.prePrizeTime = '',
    this.realPrizeTime = '',
    this.realMoney = 0,
    this.count = 0,
    this.lotteryTypeText = '',
    this.statusInfo,
    this.battleList = const [],
  });

  //生成fromJson方法，并容错处理
  factory OrderDetailModel.fromJson(Map<String, dynamic> json) {
    List<WinFailBattleModel> battleList = [];
    json["battleList"].forEach((element) {
      battleList.add(WinFailBattleModel.fromJson(element));
    });
    return OrderDetailModel(
      multiple: json['multiple'],
      lotteryNo: json['lottery_no'],
      ticketCount: json['ticket_count'],
      endTime: json['end_time'],
      printEndTime: json['print_end_time'],
      passType: json['pass_type'],
      createTime: json['create_time'],
      totalMoney: json['total_money'],
      prePrizeTime: json['pre_prize_time'],
      realPrizeTime: json['real_prize_time'],
      realMoney: json['real_money'],
      count: json['count'],
      lotteryTypeText: json['lottery_type_text'],
      statusInfo: StatusInfoModel.fromJson(json['status_info']),
      battleList: battleList,
    );
  }

}

class StatusInfoModel {
  /*
  * "status_info":{"name":"保存方案（已过期）","desc":"方案已过官网停售时间。"}*/
  final String name;
  final String desc;

  StatusInfoModel({
    required this.name,
    required this.desc,
  });

  //生成fromJson方法
  factory StatusInfoModel.fromJson(Map<String, dynamic> json) {
    return StatusInfoModel(
      name: json['name'],
      desc: json['desc'],
    );
  }
}