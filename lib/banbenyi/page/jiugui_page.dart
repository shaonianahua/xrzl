import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:xrzl/banbenyi/controller/index_controller.dart';
import 'package:xrzl/common/widget/xconfig.dart';
import 'package:xrzl/common/widget/xwidget.dart';

//给酒鬼假信息页面
class JiuguiWidget extends StatefulWidget {
  const JiuguiWidget({super.key});

  @override
  State<JiuguiWidget> createState() => _JiuguiWidgetState();
}

class _JiuguiWidgetState extends State<JiuguiWidget> {
  List<int> roleList = [1, 2, 3, 4, 5, 6, 7, 9];
  int roleId = -1; //选择的角色
  int num = -1; //数量
  String name1 = ""; //需要查两个人的角色使用
  String name2 = "";
  String name = ""; //守鸦人 掘墓使用
  int role = 0; //查出来的角色
  bool have = false; //是否查到恶魔
  late IndexController indexController;

  @override
  void initState() {
    super.initState();
    indexController = Get.find<IndexController>();
  }

  String sendInfo() {
    String str = "";
    if (roleId == 4 && num != -1) {
      // 厨师
      str = "你得知了有$num对邪恶玩家相邻";
    } else if (roleId == 5 && num != -1) {
      //共情者
      str = "你得知了有$num个邪恶玩家与自己相邻";
    } else if ((roleId == 1 || roleId == 2 || roleId == 3) &&
        name1 != "" &&
        name2 != "" &&
        role != 0) {
      //洗衣妇 图书管理员 调查员
      str = "你得知了$name1和$name2中存在${XConfig.roleMap[role]}";
    } else if (roleId == 6 && name1 != "" && name2 != "") {
      //占卜师
      str = "你得知了$name1和$name2中${have ? "存在" : "不存在"}恶魔";
    } else if (roleId == 7 && role != 0) {
      //掘墓人
      str = "你得知了他是${XConfig.roleMap[role]}";
    } else if (roleId == 9 && name != "" && role != 0) {
      //守鸦人
      str = "你查验了$name得知了他${XConfig.roleMap[role]}";
    }
    return str;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: XWidget.myAppbar("血染钟楼-酒鬼界面", false, context),
      body: ListView(
        children: [
          const Text("酒鬼的假身份是："),
          SizedBox(height: 50.w),
          Wrap(
            spacing: 30.w,
            runSpacing: 20.w,
            children: [
              for (int i = 0; i < roleList.length; i++)
                GestureDetector(
                  onTap: () {
                    setState(() {
                      roleId = roleList[i];
                    });
                  },
                  child: Container(
                    width: 200.w,
                    height: 70.w,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        color: Color(
                            roleList[i] == roleId ? 0xFF2E71F8 : 0xffeeeeee),
                        borderRadius: BorderRadius.all(Radius.circular(8.w))),
                    child: Text(
                      XConfig.roleMap[roleList[i]] ?? "",
                      style: TextStyle(
                          color: Color(
                              roleList[i] == roleId ? 0xffffffff : 0xff333333),
                          fontSize: 32.sp),
                    ),
                  ),
                )
            ],
          ),
          SizedBox(
            height: 50.w,
          ),
          if (roleId == 4 || roleId == 5) //厨师或者共情者 给他个数字
            Wrap(
              spacing: 30.w,
              runSpacing: 20.w,
              children: [
                for (int i = 0; i < 6; i++)
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        num = i;
                      });
                    },
                    child: Container(
                      width: 200.w,
                      height: 70.w,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          color: Color(num == i ? 0xFF2E71F8 : 0xffeeeeee),
                          borderRadius: BorderRadius.all(Radius.circular(8.w))),
                      child: Text(
                        "$i",
                        style: TextStyle(
                            color: Color(num == i ? 0xffffffff : 0xff333333),
                            fontSize: 32.sp),
                      ),
                    ),
                  )
              ],
            ),
          if (roleId == 1 || roleId == 2 || roleId == 3 || roleId == 6)
            contentWidget(),
          if (roleId == 7 || roleId == 9) contentWidget2(),
          SizedBox(
            height: 100.w,
          ),
          Text("发送内容：${sendInfo()}"),
          SizedBox(
            height: 30.w,
          ),
          GestureDetector(
              onTap: () {
                if (sendInfo() != "") {
                  indexController.sendPlayerInfo(sendInfo(), roleId: 17);
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
                  "发送",
                  style: TextStyle(color: Colors.white),
                ),
              ))
        ],
      ),
    );
  }

  Widget contentWidget() {
    List<Widget> peopleWidgetList = [];
    List<Widget> roleWidgetList = [];
    List<Widget> yuyanList = [];
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
                  color: Color(
                      name1 == key || name2 == key ? 0xffffffff : 0xff222222)),
            ),
          )));
    });

    for (int i = 1; i < 22; i++) {
      roleWidgetList.add(GestureDetector(
          onTap: () {
            setState(() {
              role = i;
            });
          },
          child: Container(
            width: 200.w,
            alignment: Alignment.center,
            height: 60.w,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(8.w)),
                color: Color(role == i ? 0xFF2E71F8 : 0xffeeeeee)),
            child: Text(
              XConfig.roleMap[i] ?? "",
              style: TextStyle(
                  fontSize: 28.sp,
                  color: Color(role == i ? 0xffffffff : 0xff222222)),
            ),
          )));
    }

    yuyanList.add(GestureDetector(
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
                fontSize: 28.sp, color: Color(have ? 0xffffffff : 0xff222222)),
          ),
        )));

    yuyanList.add(GestureDetector(
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
                fontSize: 28.sp, color: Color(!have ? 0xffffffff : 0xff222222)),
          ),
        )));
    return Center(
        child: Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
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
        Text(roleId != 6 ? "选择角色" : "是有有恶魔"),
        SizedBox(
          height: 20.w,
        ),
        Wrap(
          spacing: 25.w,
          runSpacing: 10.w,
          children: roleId != 6 ? roleWidgetList : yuyanList,
        ),
      ],
    ));
  }

  Widget contentWidget2() {
    List<Widget> peopleWidgetList = [];
    List<Widget> roleWidgetList = [];
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

    for (int i = 1; i < 22; i++) {
      roleWidgetList.add(GestureDetector(
          onTap: () {
            setState(() {
              role = i;
            });
          },
          child: Container(
            width: 200.w,
            alignment: Alignment.center,
            height: 60.w,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(8.w)),
                color: Color(role == i ? 0xFF2E71F8 : 0xffeeeeee)),
            child: Text(
              XConfig.roleMap[i] ?? "",
              style: TextStyle(
                  fontSize: 28.sp,
                  color: Color(role == i ? 0xffffffff : 0xff222222)),
            ),
          )));
    }

    return Center(
        child: Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const Text("选择玩家（1个）"),
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
      ],
    ));
  }
}
