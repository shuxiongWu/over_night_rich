import 'package:get/get.dart';
import 'package:over_night_rich/home/models/team_info_model.dart';

//创建一个胜平负的枚举
enum WinFailEnum {
  win(3),
  fail(0),
  draw(1);

  final int value;

  const WinFailEnum(this.value);

  // 静态方法通过整数值获取枚举
  static WinFailEnum fromValue(int value) {
    switch (value) {
      case 3:
        return WinFailEnum.win;
      case 0:
        return WinFailEnum.fail;
      case 1:
        return WinFailEnum.draw;
      default:
        throw ArgumentError('Invalid enum value: $value');
    }
  }
}

class WinFailItemModel {
  final WinFailEnum winFailEnum;
  final double value;
  final String name;
  final bool isResult = false; //是否是结果
  final RxBool isSelect = false.obs;

  //isSelect生成set方法
  set setIsSelect(bool value) => isSelect.value = value;

  WinFailItemModel(
      {required this.winFailEnum,
      required this.value,
      required this.name,
      required isResult,
      required isSelect});

  //生成fromJson方法，给默认值
  factory WinFailItemModel.fromJson(Map<String, dynamic> json) {
    WinFailItemModel model = WinFailItemModel(
      winFailEnum: WinFailEnum.fromValue(json["winFailEnum"]),
      value: double.parse(json["value"].toString()) ?? 0.0,
      name: json["name"],
      isResult: json["isResult"] ?? false,
      isSelect: json["isSelect"] ?? false,
    );
    model.isSelect.value = json["isSelect"] ?? false;
    return model;
  }
}

class WinFailModel {
  final String bet_date;
  final List<WinFailBattleModel> battleList;
  final bool isExpand;

  WinFailModel(
      {required this.bet_date,
      required this.battleList,
      required this.isExpand});

  //生成fromJson方法
  factory WinFailModel.fromJson(Map<String, dynamic> json) {
    List<WinFailBattleModel> battleList = [];
    List<String> keys = json.keys.toList();
    keys.sort((a, b) => a.compareTo(b));
    keys.forEach((element) {
      Map<String, dynamic> elementMap = json[element];
      Map rank = elementMap['rank'];
      Map oodMap = elementMap["list"]["WDL"]["odds"];
      String boundary = elementMap["list"]["WDL"]["boundary"] ?? "0";
      elementMap["boundary"] = boundary;
      elementMap["hostTeamInfo"] = rank["1"];
      elementMap["guestTeamInfo"] = rank["2"];
      elementMap["winFailItem"] = [
        {
          "winFailEnum": 3,
          "value": double.parse("${oodMap["3"]}"),
          "name": "胜",
          "isSelect": false
        },
        {
          "winFailEnum": 1,
          "value": double.parse("${oodMap["1"]}"),
          "name": "平",
          "isSelect": false
        },
        {
          "winFailEnum": 0,
          "value": double.parse("${oodMap["0"]}"),
          "name": "负",
          "isSelect": false
        }
      ];

      battleList.add(WinFailBattleModel.fromJson(elementMap));
    });
    //根据serial_no的int值来排序
    battleList.sort(
        (a, b) => int.parse(a.serial_no).compareTo(int.parse(b.serial_no)));
    return WinFailModel(
      bet_date: battleList.first.bet_date,
      battleList: battleList,
      isExpand: false,
    );
  }
}

class WinFailBattleModel {
  final String league_name;
  final String bet_date;
  final String bet_time;
  final String match_time;
  final String serial_no;
  final String lottery_no;
  final String match_id;
  final TeamInfoModel hostTeamInfoModel;
  final TeamInfoModel guestTeamInfoModel;
  final List<String> league_color;
  final List<WinFailItemModel> winFailItemModels;
  String boundary;

  //生成boundary的set方法
  set setBoundary(String value) => boundary = value;

  WinFailBattleModel(
      {required this.league_name,
      required this.lottery_no,
      required this.bet_date,
      required this.match_id,
      required this.bet_time,
      required this.match_time,
      required this.hostTeamInfoModel,
      required this.guestTeamInfoModel,
      required this.league_color,
      required this.winFailItemModels,
      required this.serial_no,
      required this.boundary});

  //生成fromJson方法
  factory WinFailBattleModel.fromJson(Map<String, dynamic> json) {
    List<WinFailItemModel> winFailItemModels = [];
    json['winFailItem'].forEach((element) {
      winFailItemModels.add(WinFailItemModel.fromJson(element));
    });

    List<String> leagueColor = [];
    if (json['league_color'] != null) {
      leagueColor = List<String>.from(json['league_color']);
    }

    //修改下，添加默认值容错处理
    return WinFailBattleModel(
      lottery_no: json['lottery_no'] ?? "",
      serial_no: json['serial_no'] ?? "",
      match_id: json['match_id2'] ?? "",
      league_name: json['league_name'] ?? "",
      bet_date: json['bet_date'] ?? "",
      bet_time: json['bet_time'] ?? "",
      match_time: json['match_time'] ?? "",
      hostTeamInfoModel: TeamInfoModel.fromJson(json['hostTeamInfo']),
      guestTeamInfoModel: TeamInfoModel.fromJson(json['guestTeamInfo']),
      league_color: leagueColor,
      winFailItemModels: winFailItemModels,
      boundary: json["boundary"] ?? "",
    );
  }
}
