import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DataMainPage extends StatefulWidget {
  const DataMainPage({super.key});

  @override
  State<DataMainPage> createState() => _DataMainPageState();
}

class _DataMainPageState extends State<DataMainPage> {
  @override
  Widget build(BuildContext context) {
    return Container(color: Colors.red, child: const Center(child: Text('历史数据')));
  }
}
