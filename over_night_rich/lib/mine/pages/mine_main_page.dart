import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MineMainPage extends StatefulWidget {
  const MineMainPage({super.key});

  @override
  State<MineMainPage> createState() => _MineMainPageState();
}

class _MineMainPageState extends State<MineMainPage> {
  @override
  Widget build(BuildContext context) {
    return Container(color: Colors.yellow, child: const Center(child: Text('个人中心')));
  }
}
