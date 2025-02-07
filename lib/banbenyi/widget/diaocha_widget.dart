import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:xrzl/banbenyi/controller/index_controller.dart';
import 'package:xrzl/common/widget/xconfig.dart';
import 'package:xrzl/common/widget/xwidget.dart';

//调查员员组件
class DiaochaWidget extends StatefulWidget {
  const DiaochaWidget({super.key});

  @override
  State<DiaochaWidget> createState() => _DiaochaWidgetState();
}

class _DiaochaWidgetState extends State<DiaochaWidget> {
  late IndexController indexController;
  String name1 = "";
  String name2 = "";
  int role = 0;
  int roleId = 3;

  @override
  void initState() {
    super.initState();
    indexController = Get.find<IndexController>();
  }

  @override
  Widget build(BuildContext context) {
    return contentWidget();
  }

  Widget contentWidget() {
    List<Widget> peopleWidgetList = [];
    List<Widget> roleWidgetList = [];

    if (indexController.roleMap[roleId]['isSelect'] &&
        !(indexController.roleMap[roleId]['false'] ?? false)) {
      indexController.peopleMap.forEach((key, value) {
        peopleWidgetList.add(GestureDetector(
            onTap: () {
              setState(() {
                if (name1 == key) {
                  name1 = "";
                } else if (name2 == key) {
                  name2 = "";
                } else if (name1 == "") {
                  name1 = key;
                } else if (name2 == "") {
                  name2 = key;
                } else {
                  XWidget.showTextTip("只能选择两个");
                  return;
                }
              });
            },
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 10.w, horizontal: 20.w),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(8.w)),
                  color: Color(
                      name1 == key || name2 == key ? 0xFF2E71F8 : 0xffeeeeee)),
              child: Text(
                XWidget.peopleNightInfo(key, value),
                style: TextStyle(
                    fontSize: 28.sp,
                    color: Color(name1 == key || name2 == key
                        ? 0xffffffff
                        : 0xff222222)),
              ),
            )));
      });

      for (int i = 18; i < 22; i++) {
        roleWidgetList.add(GestureDetector(
            onTap: () {
              setState(() {
                role = i;
              });
            },
            child: Container(
              width: 200.w,
              alignment: Alignment.center,
              height: 60.w,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(8.w)),
                  color: Color(role == i ? 0xFF2E71F8 : 0xffeeeeee)),
              child: Text(
                XConfig.roleMap[i] ?? "",
                style: TextStyle(
                    fontSize: 28.sp,
                    color: Color(role == i ? 0xffffffff : 0xff222222)),
              ),
            )));
      }
    }

    return Center(
        child: Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          indexController.roleMap[roleId]['isSelect'] &&
                  !(indexController.roleMap[roleId]['false'] ?? false)
              ? "调查员操作：选择两个人告知有一个人是xx爪牙身份"
              : "调查员操作：本场并无调查员 请表演：调查员请睁眼，他与他其中一个人是这个身份 调查员请闭眼",
          style: TextStyle(fontSize: 33.sp),
        ),
        SizedBox(
          height: 20.w,
        ),
        const Text("选择玩家（2个）"),
        SizedBox(
          height: 20.w,
        ),
        Wrap(
          spacing: 25.w,
          runSpacing: 10.w,
          children: peopleWidgetList,
        ),
        SizedBox(
          height: 20.w,
        ),
        const Text("选择角色"),
        SizedBox(
          height: 20.w,
        ),
        Wrap(
          spacing: 25.w,
          runSpacing: 10.w,
          children: roleWidgetList,
        ),
        SizedBox(
          height: 20.w,
        ),
        GestureDetector(
            onTap: () {
              if (indexController.roleMap[roleId]['isSelect'] &&
                  !(indexController.roleMap[roleId]['false'] ?? false) &&
                  name1 != "" &&
                  name2 != "" &&
                  role != 0) {
                indexController
                    .journal("调查员得知了$name1和$name2中存在${XConfig.roleMap[role]}");
                indexController.sendPlayerInfo(
                    "你得知了$name1和$name2中存在${XConfig.roleMap[role]}",
                    roleId: roleId);
                indexController.nextStep();
              } else if (!indexController.roleMap[roleId]['isSelect'] ||
                  (indexController.roleMap[roleId]['false'] ?? false)) {
                indexController.nextStep();
              } else {
                XWidget.showTextTip("请选择完整");
              }
            },
            child: Container(
              width: 200.w,
              height: 70.w,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(8.w)),
                  color: const Color(0xFF2E71F8)),
              child: const Text(
                "下一步",
                style: TextStyle(color: Colors.white),
              ),
            ))
      ],
    ));
  }
}
