import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:xrzl/banbenyi/controller/index_controller.dart';

//荡妇组件
class DangfuWidget extends StatefulWidget {
  const DangfuWidget({super.key});

  @override
  State<DangfuWidget> createState() => _DangfuWidgetState();
}

class _DangfuWidgetState extends State<DangfuWidget> {
  late IndexController indexController;
  int roleId = 18;
  bool isDevil = false;

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
        !indexController.roleDieList.contains(roleId) &&
        !(indexController.peopleMap[indexController.dangfuName]?['isDevil'] ??
            false)) {
      peopleWidgetList.add(GestureDetector(
          onTap: () {
            setState(() {
              isDevil = true;
            });
          },
          child: Container(
            padding: EdgeInsets.symmetric(vertical: 10.w, horizontal: 20.w),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(8.w)),
                color: Color(isDevil ? 0xFF2E71F8 : 0xffeeeeee)),
            child: Text(
              "你成为恶魔",
              style: TextStyle(
                  fontSize: 28.sp,
                  color: Color(isDevil ? 0xffffffff : 0xff222222)),
            ),
          )));
      peopleWidgetList.add(GestureDetector(
          onTap: () {
            setState(() {
              isDevil = false;
            });
          },
          child: Container(
            padding: EdgeInsets.symmetric(vertical: 10.w, horizontal: 20.w),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(8.w)),
                color: Color(!isDevil ? 0xFF2E71F8 : 0xffeeeeee)),
            child: Text(
              "你没成为恶魔",
              style: TextStyle(
                  fontSize: 28.sp,
                  color: Color(!isDevil ? 0xffffffff : 0xff222222)),
            ),
          )));
    }

    return Center(
        child: Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          indexController.roleMap[roleId]['isSelect'] &&
                  !indexController.roleDieList.contains(roleId) &&
                  !(indexController.peopleMap[indexController.dangfuName]
                          ?['isDevil'] ??
                      false)
              ? "荡妇操作：恶魔死了以后 存活人数>=4 你变成恶魔"
              : (indexController.peopleMap[indexController.dangfuName]
                          ?['isDevil'] ??
                      false)
                  ? "荡妇操作：已变成恶魔，将在恶魔回合执行杀人，请表演：荡妇请睁眼，你今晚的状态是这个 荡妇请闭眼"
                  : "荡妇操作：本场并无荡妇或已死亡 请表演：荡妇请睁眼，你今晚的状态是这个 荡妇请闭眼",
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
                  !indexController.roleDieList.contains(roleId) &&
                  !(indexController.peopleMap[indexController.dangfuName]
                          ?['isDevil'] ??
                      false)) {
                if (isDevil) {
                  indexController.changeDevil();
                }
                indexController.journal("荡妇${isDevil ? "变成了" : "没变成"}恶魔");
                indexController.sendPlayerInfo(
                    "你${isDevil ? "变成了" : "没变成"}恶魔，${isDevil ? "当说书人说出恶魔请睁眼的时候，你需要睁眼完成杀人" : ""}",
                    roleId: roleId);
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
