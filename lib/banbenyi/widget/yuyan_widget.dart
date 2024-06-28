import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:xrzl/banbenyi/controller/index_controller.dart';
import 'package:xrzl/common/widget/xwidget.dart';

//预言家组件
class YuyanWidget extends StatefulWidget {
  const YuyanWidget({super.key});

  @override
  State<YuyanWidget> createState() => _YuyanWidgetState();
}

class _YuyanWidgetState extends State<YuyanWidget> {
  late IndexController indexController;
  String name1 = "";
  String name2 = "";
  bool have = false;
  int roleId = 6;

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
        !(indexController.roleMap[roleId]['false'] ?? false) &&
        !indexController.roleDieList.contains(roleId)) {
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

      roleWidgetList.add(GestureDetector(
          onTap: () {
            setState(() {
              have = true;
            });
          },
          child: Container(
            width: 200.w,
            alignment: Alignment.center,
            height: 60.w,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(8.w)),
                color: Color(have ? 0xFF2E71F8 : 0xffeeeeee)),
            child: Text(
              "存在",
              style: TextStyle(
                  fontSize: 28.sp,
                  color: Color(have ? 0xffffffff : 0xff222222)),
            ),
          )));

      roleWidgetList.add(GestureDetector(
          onTap: () {
            setState(() {
              have = false;
            });
          },
          child: Container(
            width: 200.w,
            alignment: Alignment.center,
            height: 60.w,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(8.w)),
                color: Color(!have ? 0xFF2E71F8 : 0xffeeeeee)),
            child: Text(
              "不存在",
              style: TextStyle(
                  fontSize: 28.sp,
                  color: Color(!have ? 0xffffffff : 0xff222222)),
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
              ? "预言家操作：预言家自己选择两个人告知是否存在恶魔"
              : "预言家操作：本场并无预言家或预言家已死亡 请表演：预言家请睁眼，请选择查验的人 他与她之中的恶魔数量是这个 预言家请闭眼",
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
        const Text("选择是否存在恶魔"),
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
                  !indexController.roleDieList.contains(roleId)) {
                indexController
                    .journal("预言家得知了$name1和$name2中${have ? "存在" : "不存在"}恶魔");
                indexController.nextStep();
              } else if (!indexController.roleMap[roleId]['isSelect'] ||
                  (indexController.roleMap[roleId]['false'] ?? false) ||
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
