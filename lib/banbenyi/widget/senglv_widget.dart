import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:xrzl/banbenyi/controller/index_controller.dart';
import 'package:xrzl/common/widget/xwidget.dart';

//僧侣组件
class SenglvWidget extends StatefulWidget {
  const SenglvWidget({super.key});

  @override
  State<SenglvWidget> createState() => _SenglvWidgetState();
}

class _SenglvWidgetState extends State<SenglvWidget> {
  late IndexController indexController;
  String name = "";
  int roleId = 8;

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

    if (indexController.roleMap[roleId]['isSelect'] &&
        !(indexController.roleMap[roleId]['false'] ?? false) &&
        !indexController.roleDieList.contains(roleId)) {
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
    }

    return Center(
        child: Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          indexController.roleMap[roleId]['isSelect'] &&
                  !(indexController.roleMap[roleId]['false'] ?? false) &&
                  !indexController.roleDieList.contains(roleId)
              ? "僧侣操作：选择保护一个人 夜晚不受恶魔伤害 不能是自己"
              : "僧侣操作：本场并无僧侣或僧侣已死亡 请表演：僧侣请睁眼，你选择保护谁 僧侣请闭眼",
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
        GestureDetector(
            onTap: () {
              if (indexController.roleMap[roleId]['isSelect'] &&
                  !(indexController.roleMap[roleId]['false'] ?? false) &&
                  name != "" &&
                  !indexController.roleDieList.contains(roleId)) {
                indexController.peopleMap[name]!['protect'] = true;
                indexController.journal("僧侣选择保护了$name");
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
