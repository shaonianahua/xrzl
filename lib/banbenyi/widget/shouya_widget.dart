import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:xrzl/banbenyi/controller/index_controller.dart';
import 'package:xrzl/common/widget/xconfig.dart';
import 'package:xrzl/common/widget/xwidget.dart';

//养鸦人组件
class ShouyaWidget extends StatefulWidget {
  const ShouyaWidget({super.key});

  @override
  State<ShouyaWidget> createState() => _ShouyaWidgetState();
}

class _ShouyaWidgetState extends State<ShouyaWidget> {
  late IndexController indexController;
  String name = "";
  int roleId = 9;
  int role = 0;

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
        if (value['role'] != roleId) {
          peopleWidgetList.add(GestureDetector(
              onTap: () {
                setState(() {
                  name = key;
                });
              },
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 10.w, horizontal: 20.w),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(8.w)),
                    color: Color(name == key ? 0xFF2E71F8 : 0xffeeeeee)),
                child: Text(
                  XWidget.peopleNightInfo(key, value),
                  style: TextStyle(
                      fontSize: 28.sp,
                      color: Color(name == key ? 0xffffffff : 0xff222222)),
                ),
              )));
        }
      });

      XConfig.roleMap.forEach((key, value) {
        roleWidgetList.add(GestureDetector(
            onTap: () {
              setState(() {
                role = key;
              });
            },
            child: Container(
              width: 200.w,
              alignment: Alignment.center,
              height: 60.w,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(8.w)),
                  color: Color(role == key ? 0xFF2E71F8 : 0xffeeeeee)),
              child: Text(
                XConfig.roleMap[key] ?? "",
                style: TextStyle(
                    fontSize: 28.sp,
                    color: Color(role == key ? 0xffffffff : 0xff222222)),
              ),
            )));
      });

      roleWidgetList.add(GestureDetector(
          onTap: () {
            setState(() {
              role = 0;
            });
          },
          child: Container(
            width: 200.w,
            alignment: Alignment.center,
            height: 60.w,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(8.w)),
                color: Color(role == 0 ? 0xFF2E71F8 : 0xffeeeeee)),
            child: Text(
              "今晚未死亡或已查验过",
              style: TextStyle(
                  fontSize: 28.sp,
                  color: Color(role == 0 ? 0xffffffff : 0xff222222)),
            ),
          )));
    }

    return Center(
        child: Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          indexController.roleMap[roleId]['isSelect'] &&
                  !(indexController.roleMap[roleId]['false'] ?? false)
              ? "养鸦人操作：如果死了 可以查一个人身份 只能查一次 如果中毒了可能会查到假身份"
              : "养鸦人操作：本场并无养鸦人 请表演：养鸦人请睁眼，你今晚的状态是这个 养鸦人请闭眼",
          style: TextStyle(fontSize: 33.sp),
        ),
        SizedBox(
          height: 20.w,
        ),
        const Text("选择玩家"),
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
                  name != "" &&
                  role != 0) {
                indexController
                    .journal("养鸦人选择查验了$name得知了他是${XConfig.roleMap[role]}");
                indexController.sendPlayerInfo(
                    "你查验了$name得知了他是${XConfig.roleMap[role]}",
                    roleId: roleId);
                indexController.nextStep();
              } else if (!indexController.roleMap[roleId]['isSelect'] ||
                  (indexController.roleMap[roleId]['false'] ?? false) ||
                  role == 0) {
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
