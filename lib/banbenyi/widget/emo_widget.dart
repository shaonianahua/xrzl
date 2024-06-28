import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:xrzl/banbenyi/controller/index_controller.dart';
import 'package:xrzl/common/widget/xwidget.dart';

//小恶魔组件
class EmoWidget extends StatefulWidget {
  const EmoWidget({super.key});

  @override
  State<EmoWidget> createState() => _EmoWidgetState();
}

class _EmoWidgetState extends State<EmoWidget> {
  late IndexController indexController;
  String name = "";
  int roleId = 22;
  bool kill = false;

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
    List<Widget> resultWidgetList = [];
    if ((indexController.roleMap[roleId]['isSelect'] &&
            !indexController.roleDieList.contains(roleId)) ||
        (indexController.roleDieList.contains(roleId) &&
            indexController.dangfuName != "" &&
            (indexController.peopleMap[indexController.dangfuName]
                    ?['isDevil'] ??
                false))) {
      //前面的条件是恶魔活着 后面的条件是恶魔死了但荡妇变成恶魔了
      indexController.peopleMap.forEach((key, value) {
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
      });

      resultWidgetList.add(GestureDetector(
          onTap: () {
            setState(() {
              kill = true;
            });
          },
          child: Container(
            padding: EdgeInsets.symmetric(vertical: 10.w, horizontal: 20.w),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(8.w)),
                color: Color(kill ? 0xFF2E71F8 : 0xffeeeeee)),
            child: Text(
              "杀死了",
              style: TextStyle(
                  fontSize: 28.sp,
                  color: Color(kill ? 0xffffffff : 0xff222222)),
            ),
          )));

      resultWidgetList.add(GestureDetector(
          onTap: () {
            setState(() {
              kill = false;
            });
          },
          child: Container(
            padding: EdgeInsets.symmetric(vertical: 10.w, horizontal: 20.w),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(8.w)),
                color: Color(!kill ? 0xFF2E71F8 : 0xffeeeeee)),
            child: Text(
              "没杀死",
              style: TextStyle(
                  fontSize: 28.sp,
                  color: Color(!kill ? 0xffffffff : 0xff222222)),
            ),
          )));
    }

    return Center(
        child: Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          indexController.roleMap[roleId]['isSelect']
              ? "小恶魔操作：选择杀死一个人"
              : "小恶魔操作：小恶魔已经死亡 请表演：小恶魔请睁眼，你选择杀死谁 小恶魔请闭眼",
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
        SizedBox(
          height: 20.w,
        ),
        const Text("是否成功杀死"),
        SizedBox(
          height: 20.w,
        ),
        Wrap(
          spacing: 25.w,
          runSpacing: 10.w,
          children: resultWidgetList,
        ),
        SizedBox(
          height: 20.w,
        ),
        GestureDetector(
            onTap: () {
              if ((indexController.roleMap[roleId]['isSelect'] &&
                      name != "" &&
                      !indexController.roleDieList.contains(roleId)) ||
                  (indexController.roleDieList.contains(roleId) &&
                      indexController.dangfuName != "" &&
                      (indexController.peopleMap[indexController.dangfuName]
                              ?['isDevil'] ??
                          false) &&
                      name != "")) {
                if (kill) {
                  indexController.die(name);
                }
                indexController.journal("小恶魔选择杀死$name,${kill ? "成功了" : "失败了"}");
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
