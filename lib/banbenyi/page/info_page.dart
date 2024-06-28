import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:xrzl/banbenyi/controller/index_controller.dart';
import 'package:xrzl/common/widget/xconfig.dart';
import 'package:xrzl/common/widget/xwidget.dart';

//数据面板 随时查看
class InfoPage extends StatefulWidget {
  const InfoPage({super.key});

  @override
  State<InfoPage> createState() => _InfoPageState();
}

class _InfoPageState extends State<InfoPage> {
  late IndexController indexController;

  @override
  void initState() {
    super.initState();
    indexController = Get.find<IndexController>();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: XWidget.myAppbar("血染钟楼-角色面板", false, context),
      body:
          Wrap(spacing: 100.w, runSpacing: 160.w, children: peopleWidgetList()),
    );
  }

  List<Widget> peopleWidgetList() {
    List<Widget> widgetList = [];
    indexController.peopleMap.forEach((key, value) {
      widgetList.add(Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("角色：$key"),
          Text(
              "角色：${XConfig.roleMap[indexController.peopleMap[key]?['role']] ?? "未选择角色"}"),
          Text(
              "状态：${(indexController.peopleMap[key]?['alive'] ?? true) ? "活着" : "死了"}"),
          if (indexController.peopleMap[key]?['role'] == 6)
            Text("宿敌：${indexController.peopleMap[key]?['enemy'] ?? "未选择"}"),
          if (indexController.peopleMap[key]?['role'] == 17)
            Text(
                "假身份：${XConfig.roleMap[indexController.peopleMap[key]?['drunkId']] ?? "未选择角色"}"),
          if ((indexController.peopleMap[key]?['role'] ?? 0) > 17)
            Text(
                "假身份：${XConfig.roleMap[indexController.peopleMap[key]?['devil']] ?? "未选择角色"}"),
        ],
      ));
    });
    return widgetList;
  }
}
