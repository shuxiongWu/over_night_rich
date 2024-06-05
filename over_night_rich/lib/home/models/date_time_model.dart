class DateTimeModel {
  //有年月日时分秒属性
  String year;
  String month;
  String day;
  String hour;
  String minute;
  String second;

  DateTimeModel({
    required this.year,
    required this.month,
    required this.day,
    required this.hour,
    required this.minute,
    required this.second,
  });

  //生成fromJson方法，将map转为DateTimeModel，并容错处理
  factory DateTimeModel.fromJson(Map<String, dynamic> json) {
    return DateTimeModel(
      year: json["year"] ?? "",
      month: json["month"] ?? "",
      day: json["day"] ?? "",
      hour: json["hour"] ?? "",
      minute: json["minute"] ?? "",
      second: json["second"] ?? "",
    );
  }

}