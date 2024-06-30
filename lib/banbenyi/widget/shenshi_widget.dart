import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:xrzl/banbenyi/controller/index_controller.dart';
import 'package:xrzl/common/widget/xwidget.dart';

//神使组件
class ShenshiWidget extends StatefulWidget {
  const ShenshiWidget({super.key});

  @override
  State<ShenshiWidget> createState() => _ShenshiWidgetState();
}

class _ShenshiWidgetState extends State<ShenshiWidget> {
  late IndexController indexController;
  int num = -1;
  int roleId = 5;

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
      for (int i = 0; i < 3; i++) {
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
                  !(indexController.roleMap[roleId]['false'] ?? false) &&
                  !indexController.roleDieList.contains(roleId)
              ? "神使操作：告知有多少个邪恶阵营玩家与你相邻"
              : "神使操作：本场并无神使或神使已死亡 请表演：神使请睁眼，一共有这么多邪恶玩家与你相邻 神使请闭眼",
          style: TextStyle(fontSize: 33.sp),
        ),
        SizedBox(
          height: 20.w,
        ),
        const Text("选择相邻个数"),
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
                  num != -1 &&
                  !indexController.roleDieList.contains(roleId)) {
                indexController.journal("神使得知了有$num个邪恶玩家与自己相邻");
                indexController.sendPlayerInfo("你得知了有$num个邪恶玩家与自己相邻",
                    roleId: roleId);
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
