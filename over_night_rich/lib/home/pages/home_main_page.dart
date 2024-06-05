import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/route_manager.dart';
import 'package:over_night_rich/router/rich_pages.dart';

class HomeMainPage extends StatefulWidget {
  const HomeMainPage({super.key});

  @override
  State<HomeMainPage> createState() => _HomeMainPageState();
}

class _HomeMainPageState extends State<HomeMainPage> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.greenAccent,
        body: Center(
          child: Column(
            children: [
              SizedBox(height: 200,),
              FloatingActionButton(
                heroTag: "uniqueTag1",
                onPressed: () {
                  Get.toNamed(RichPages.selectOrder);
                },
                backgroundColor: Colors.blue,
                child: const Column(
                  mainAxisAlignment: MainAxisAlignment.center, // Align the children in the center vertically
                  children: <Widget>[
                    Icon(Icons.hdr_auto_select), // Replace this with Image.asset('path_to_your_image') if you have a custom image
                    SizedBox(height: 4), // Provide some space between the icon and the text
                    Text('北京单场', style: TextStyle(fontSize: 10)), // Smaller text size for better fitting
                  ],
                ),
              ),
              FloatingActionButton(
                heroTag: "uniqueTag2",
                onPressed: () {
                  Get.toNamed(RichPages.orderList);
                },
                backgroundColor: Colors.blue,
                child: const Column(
                  mainAxisAlignment: MainAxisAlignment.center, // Align the children in the center vertically
                  children: <Widget>[
                    Icon(Icons.list_alt), // Replace this with Image.asset('path_to_your_image') if you have a custom image
                    SizedBox(height: 4), // Provide some space between the icon and the text
                    Text('选号记录', style: TextStyle(fontSize: 10)), // Smaller text size for better fitting
                  ],
                ),
              ),
            ],
          )
        ),
      ),
    );
  }
}
