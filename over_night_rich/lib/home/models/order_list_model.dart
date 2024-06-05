class OrderListModel {
  String lotteryType;
  String lotteryNo;
  String endTime;
  String printEndTime;
  double netPrize;
  String createTime;
  int totalMoney;
  int stationUid;
  int projectId;
  int isRcmd;
  String statusText;
  String statusColor;
  String endTimeText;
  int submitStatus;
  String lotteryTypeText;
  String playTypeText;
  String pUuid;

  OrderListModel({
    this.lotteryType = '',
    this.lotteryNo = '',
    this.endTime = '',
    this.printEndTime = '',
    this.netPrize = 0.0,
    this.createTime = '',
    this.totalMoney = 0,
    this.stationUid = 0,
    this.projectId = 0,
    this.isRcmd = 0,
    this.statusText = '',
    this.statusColor = '',
    this.endTimeText = '',
    this.submitStatus = 0,
    this.lotteryTypeText = '',
    this.playTypeText = '',
    this.pUuid = '',
  });

  factory OrderListModel.fromJson(Map<String, dynamic> json) {
    return OrderListModel(
      lotteryType: json['lottery_type'] ?? '',
      lotteryNo: json['lottery_no'] ?? '',
      endTime: json['end_time'] ?? '',
      printEndTime: json['print_end_time'] ?? '',
      netPrize: double.parse(json['net_prize'].toString()),
      createTime: json['create_time'] ?? '',
      totalMoney: (json['total_money'] ?? 0).toInt(),
      stationUid: json['station_uid'] ?? 0,
      projectId: json['project_id'] ?? 0,
      isRcmd: json['is_rcmd'] ?? 0,
      statusText: json['status_text'] ?? '',
      statusColor: json['status_color'] ?? '',
      endTimeText: json['end_time_text'] ?? '',
      submitStatus: json['submit_status'] ?? 0,
      lotteryTypeText: json['lottery_type_text'] ?? '',
      playTypeText: json['play_type_text'] ?? '',
      pUuid: json['p_uuid'] ?? '',
    );
  }
}
