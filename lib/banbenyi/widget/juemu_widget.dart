import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:xrzl/banbenyi/controller/index_controller.dart';
import 'package:xrzl/common/widget/xconfig.dart';
import 'package:xrzl/common/widget/xwidget.dart';

//掘墓人组件
class JuemuWidget extends StatefulWidget {
  const JuemuWidget({super.key});

  @override
  State<JuemuWidget> createState() => _JuemuWidgetState();
}

class _JuemuWidgetState extends State<JuemuWidget> {
  late IndexController indexController;
  int roleId = 7;
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
    List<Widget> roleWidgetList = [];
    if (indexController.roleMap[roleId]['isSelect'] &&
        !(indexController.roleMap[roleId]['false'] ?? false) &&
        !indexController.roleDieList.contains(roleId)) {
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
              "无人死亡",
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
                  !(indexController.roleMap[roleId]['false'] ?? false) &&
                  !indexController.roleDieList.contains(roleId)
              ? "掘墓人操作：可以查上一个白天死的人的身份 如果是隐士或间谍 或者中毒了 查出来的可以是别的身份"
              : "掘墓人操作：本场并无掘墓人或掘墓人已死亡 请表演：掘墓人请睁眼，上个白天死的人是这个身份 掘墓人请闭眼",
          style: TextStyle(fontSize: 33.sp),
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
                  role != 0 &&
                  !indexController.roleDieList.contains(roleId)) {
                indexController.journal("掘墓人得知了他是${XConfig.roleMap[role]}");
                indexController.sendPlayerInfo("你得知了他是${XConfig.roleMap[role]}",
                    roleId: roleId);
                indexController.nextStep();
              } else if (!indexController.roleMap[roleId]['isSelect'] ||
                  (indexController.roleMap[roleId]['false'] ??
                      false || role == 0) ||
                  indexController.roleDieList.contains(roleId)) {
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
