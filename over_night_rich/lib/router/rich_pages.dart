import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:over_night_rich/data/pages/data_main_page.dart';
import 'package:over_night_rich/home/pages/home_main_page.dart';
import 'package:over_night_rich/home/pages/home_select_order_page.dart';
import 'package:over_night_rich/home/pages/order_list_page.dart';
import 'package:over_night_rich/mine/pages/mine_main_page.dart';
import 'package:over_night_rich/home/pages/order_detail_page.dart';
import '../webview_page.dart';

class RichPages {
  static const String home = "/homePage";
  static const String mine = "/minePage";
  static const String data = "/dataPage";
  static const String selectOrder = "/selectOrderPage";
  static const String orderList = "/orderListPage";
  static const String orderDetail = "/orderDetailPage";
  static const String webView = "/webViewPage";

  static List<GetPage> getPages = [
    GetPage(name: RichPages.home, page: () => const HomeMainPage()),
    GetPage(name: RichPages.mine, page: () => const MineMainPage()),
    GetPage(name: RichPages.data, page: () => const DataMainPage()),
    GetPage(name: RichPages.selectOrder, page: () => const HomeSelectOrderPage()),
    GetPage(name: RichPages.orderList, page: () => const OrderListPage()),
    GetPage(name: RichPages.orderDetail, page: () => const OrderDetailPage()),
    GetPage(name: RichPages.webView, page: () => const WebViewPage()),

  ];

}