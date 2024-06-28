import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:xrzl/banbenyi/controller/index_controller.dart';
import 'package:xrzl/common/widget/xwidget.dart';

//毒师组件
class DushiWidget extends StatefulWidget {
  const DushiWidget({super.key});

  @override
  State<DushiWidget> createState() => _DushiWidgetState();
}

class _DushiWidgetState extends State<DushiWidget> {
  late IndexController indexController;
  String name = "";
  int roleId = 21;

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
    List<Widget> widgetList = [];
    if (indexController.roleMap[roleId]['isSelect'] &&
        !(indexController.roleMap[roleId]['false'] ?? false) &&
        !indexController.roleDieList.contains(roleId)) {
      indexController.peopleMap.forEach((key, value) {
        widgetList.add(GestureDetector(
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
              ? "毒师操作：下毒"
              : "毒师操作：本场并无毒师或已死亡 请表演：毒师请睁眼，毒师要给谁下毒，好的，毒师请闭眼",
          style: TextStyle(fontSize: 33.sp),
        ),
        SizedBox(
          height: 20.w,
        ),
        Wrap(
          spacing: 25.w,
          runSpacing: 10.w,
          children: widgetList,
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
                indexController.peopleMap[name]!['poison'] = true;
                indexController.journal("毒师对$name下毒了");
                indexController.nextStep();
              } else if (!indexController.roleMap[roleId]['isSelect'] ||
                  (indexController.roleMap[roleId]['false'] ?? false) || indexController.roleDieList.contains(roleId)) {
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
