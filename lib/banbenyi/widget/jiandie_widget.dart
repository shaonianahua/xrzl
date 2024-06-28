import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:xrzl/banbenyi/controller/index_controller.dart';
import 'package:xrzl/common/widget/xconfig.dart';

//间谍组件
class JiandieWidget extends StatefulWidget {
  const JiandieWidget({super.key});

  @override
  State<JiandieWidget> createState() => _JiandieWidgetState();
}

class _JiandieWidgetState extends State<JiandieWidget> {
  late IndexController indexController;
  String name = "";
  int roleId = 20;

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
        !(indexController.roleMap[roleId]['false'] ?? false) && !indexController.roleDieList.contains(roleId)) {
      indexController.peopleMap.forEach((key, value) {
        peopleWidgetList.add(Container(
          padding: EdgeInsets.symmetric(vertical: 10.w, horizontal: 20.w),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(8.w)),
              color: Color(name == key ? 0xFF2E71F8 : 0xffeeeeee)),
          child: Text(
            "$key(${XConfig.roleMap[value['role']]})",
            style: TextStyle(
                fontSize: 28.sp,
                color: Color(name == key ? 0xffffffff : 0xff222222)),
          ),
        ));
      });
    }

    return Center(
        child: Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          indexController.roleMap[roleId]['isSelect'] &&
                  !(indexController.roleMap[roleId]['false'] ?? false) && !indexController.roleDieList.contains(roleId)
              ? "间谍操作：可能被认为是个好人 可以查看魔典"
              : "间谍操作：本场并无间谍或间谍已死亡 请表演：间谍请睁眼，请查看魔典 间谍请闭眼",
          style: TextStyle(fontSize: 33.sp),
        ),
        SizedBox(
          height: 20.w,
        ),
        const Text("查看玩家"),
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
                  name != "" && !indexController.roleDieList.contains(roleId)) {
                indexController.journal("间谍查看了魔典");
                indexController.nextStep();
              } else {
                indexController.nextStep();
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
