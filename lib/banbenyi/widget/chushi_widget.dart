import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:xrzl/banbenyi/controller/index_controller.dart';
import 'package:xrzl/common/widget/xwidget.dart';

//厨师组件
class ChushiWidget extends StatefulWidget {
  const ChushiWidget({super.key});

  @override
  State<ChushiWidget> createState() => _ChushiWidgetState();
}

class _ChushiWidgetState extends State<ChushiWidget> {
  late IndexController indexController;
  int num = -1;
  int roleId = 4;

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
        !(indexController.roleMap[roleId]['false'] ?? false)) {
      for (int i = 0; i < 8; i++) {
        widgetList.add(GestureDetector(
            onTap: () {
              setState(() {
                num = i;
              });
            },
            child: Container(
              width: 200.w,
              alignment: Alignment.center,
              height: 60.w,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(8.w)),
                  color: Color(num == i ? 0xFF2E71F8 : 0xffeeeeee)),
              child: Text(
                "$i",
                style: TextStyle(
                    fontSize: 28.sp,
                    color: Color(num == i ? 0xffffffff : 0xff222222)),
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
              ? "厨师操作：告知有多少对邪恶阵营玩家相邻"
              : "厨师操作：本场并无厨师 请表演：厨师请睁眼，一共有这么多对邪恶玩家相邻 厨师请闭眼",
          style: TextStyle(fontSize: 33.sp),
        ),
        SizedBox(
          height: 20.w,
        ),
        const Text("选择邻座对数"),
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
                  num != -1) {
                indexController.journal("厨师得知了有$num对邪恶玩家相邻");
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
