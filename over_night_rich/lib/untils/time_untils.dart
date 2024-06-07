import 'package:intl/intl.dart';
import '../home/models/date_time_model.dart';
export '../home/models/date_time_model.dart';

class TimeUntils {
  //生成一个静态方法，可以将2024-05-22 17:55:00这个格式的时间转为一个map返回分别拿到年月日时分秒
  static DateTimeModel formatTime(String time) {
    List<String> timeList = time.split(" ");
    List<String> dateList = timeList[0].split("-");
    List<String> timeList2 = timeList[1].split(":");
    return DateTimeModel(
      year: dateList[0],
      month: dateList[1],
      day: dateList[2],
      hour: timeList2[0],
      minute: timeList2[1],
      second: timeList2[2],
    );
  }

  static String formatDate(String inputDate) {
    DateTime date = DateTime.parse(inputDate);
    // 创建一个 DateFormat 对象，用于格式化日期为 "M月d日"
    DateFormat formatter = DateFormat('M月d日');
    return formatter.format(date);
  }

  static String getWeekdayOrToday(String inputDate) {
    DateTime date = DateTime.parse(inputDate);
    DateTime today = DateTime.now();

    // Check if the input date is today
    if (date.year == today.year && date.month == today.month && date.day == today.day) {
      return '今天';
    } else {
      // Get the weekday and convert to Chinese
      List<String> weekdays = [
        '周日', // Sunday
        '周一', // Monday
        '周二', // Tuesday
        '周三', // Wednesday
        '周四', // Thursday
        '周五', // Friday
        '周六'  // Saturday
      ];
      return weekdays[date.weekday - 1];
    }
  }

}