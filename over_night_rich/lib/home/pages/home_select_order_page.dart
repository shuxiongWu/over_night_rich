import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_custom_tab_bar/custom_tab_bar.dart';
import 'package:flutter_custom_tab_bar/indicator/custom_indicator.dart';
import 'package:flutter_custom_tab_bar/indicator/round_indicator.dart';
import 'package:flutter_custom_tab_bar/transform/color_transform.dart';
import 'package:over_night_rich/home/pages/win_fail_select_page.dart';

class HomeSelectOrderPage extends StatefulWidget {
  const HomeSelectOrderPage({super.key});

  @override
  State<HomeSelectOrderPage> createState() => _HomeSelectOrderPageState();
}

class _HomeSelectOrderPageState extends State<HomeSelectOrderPage> {

  late final PageController _controller = PageController(initialPage: 0);
  final CustomTabBarController _tabBarController = CustomTabBarController();
  final List<String> titleList = ["胜负场","总进球","半全场","比分","上下单双"];

  Widget getTabbarChild(BuildContext context, int index) {
    return TabBarItem(
        transform: ColorsTransform(
            highlightColor: Colors.white,
            normalColor: const Color(0xFF051716),
            builder: (context, color) {
              return Container(
                padding: const EdgeInsets.fromLTRB(10, 2, 10, 2),
                alignment: Alignment.center,
                constraints: const BoxConstraints(minWidth: 60),
                child: (Text(
                    titleList[index],
                  style: TextStyle(fontSize: 14, color: color),
                )),
              );
            }),
        index: index);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: const Color(0xFF051716),
          title: const Text(
            '北京单场',
          ),
        ),
        body: Column(
          children: [
            const SizedBox(height: 12,),
            CustomTabBar(
              tabBarController: _tabBarController,
              height: 35,
              itemCount: titleList.length,
              builder: getTabbarChild,
              indicator: RoundIndicator(
                color: const Color(0xFF051716),
                top: 2.5,
                bottom: 2.5,
                left: 2.5,
                right: 2.5,
                radius: BorderRadius.circular(15),
              ),
              pageController: _controller,
            ),
            Expanded(
                child: PageView.builder(
                    controller: _controller,
                    itemCount: titleList.length,
                    itemBuilder: (context, index) {
                      return const WinFailSelectPage();
                    })),
          ],
        ),
    );
  }

}
