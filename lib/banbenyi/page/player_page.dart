import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:xrzl/banbenyi/controller/index_controller.dart';
import 'package:xrzl/banbenyi/page/first_page.dart';
import 'package:xrzl/common/widget/xconfig.dart';
import 'package:xrzl/common/widget/xwidget.dart';

//玩家界面
class PlayerPage extends StatefulWidget {
  const PlayerPage({super.key});

  @override
  State<PlayerPage> createState() => _PlayerPageState();
}

class _PlayerPageState extends State<PlayerPage> {
  TextEditingController textController = TextEditingController(text: "");
  late IndexController indexController;

  @override
  void initState() {
    super.initState();
    indexController = Get.find<IndexController>();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: XWidget.myAppbar("血染钟楼-玩家", false, context),
      body: Center(
        child: Column(
          children: [
            SizedBox(
              height: 100.w,
            ),
            Obx(() {
              if (indexController.userName.value == "") {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    commonInput(),
                    SizedBox(
                      width: 50.w,
                    ),
                    GestureDetector(
                      onTap: () {
                        indexController.userName.value =
                            textController.text.toString();
                      },
                      child: Container(
                        width: 200.w,
                        height: 70.w,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                            color: const Color(0xFF2E71F8),
                            borderRadius:
                                BorderRadius.all(Radius.circular(8.w))),
                        child: Text(
                          "确定",
                          style:
                              TextStyle(color: Colors.white, fontSize: 32.sp),
                        ),
                      ),
                    ),
                  ],
                );
              } else {
                return Container();
              }
            }),
            SizedBox(
              height: 30.w,
            ),
            Obx(() {
              return Text("玩家姓名：${indexController.userName.value}");
            }),
            SizedBox(
              height: 50.w,
            ),
            Obx(() {
              if (indexController.userName.value != "") {
                return GestureDetector(
                  onTap: () {
                    indexController.getPlayerInfo();
                  },
                  child: Container(
                    width: 500.w,
                    height: 70.w,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        color: const Color(0xFF2E71F8),
                        borderRadius: BorderRadius.all(Radius.circular(8.w))),
                    child: Text(
                      "查询信息（等说书人通知）",
                      style: TextStyle(color: Colors.white, fontSize: 32.sp),
                    ),
                  ),
                );
              } else {
                return Container();
              }
            }),
            SizedBox(
              height: 60.w,
            ),
            Obx(() {
              if (indexController.playerInfo.isNotEmpty) {
                return userInfo();
              } else {
                return Container();
              }
            }),
            SizedBox(
              height: 50.w,
            ),
            Obx(() {
              if (indexController.playerInfo.isNotEmpty &&
                  indexController.playerInfo['content']?['roleId'] ==
                      indexController.playerRoleId) {
                return checkInfo();
              } else {
                return Container();
              }
            }),
            SizedBox(
              height: 50.w,
            ),
            Obx(() {
              if (indexController.playerInfo.isNotEmpty &&
                  indexController.playerRoleId == 20) {
                return jiandieWidget();
              } else {
                return Container();
              }
            }),
            SizedBox(
              height: 50.w,
            ),
            Obx(() {
              if (indexController.playerInfo.isNotEmpty) {
                return hideBtn();
              } else {
                return Container();
              }
            }),
            SizedBox(height: 50.w,),
            remarkBtn()
          ],
        ),
      ),
    );
  }

  Widget commonInput() {
    return Container(
      width: 350.w,
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      height: 80.w,
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(16.w)),
      child: TextField(
        controller: textController,
        maxLines: 1,
        style: TextStyle(
          fontSize: 32.sp,
          color: const Color(0xff222222),
        ),
        textAlign: TextAlign.center,
        cursorColor: const Color(0xff171A1D),
        decoration: InputDecoration(
            border: InputBorder.none,
            counterText: "",
            hintText: "请输入你的姓名",
            contentPadding: EdgeInsets.only(left: 15.w),
            hintStyle: TextStyle(
                fontSize: 28.sp,
                fontWeight: FontWeight.w300,
                color: const Color(0xffC8C8C9),
                decoration: TextDecoration.none)),
        autofocus: false,
      ),
    );
  }

  //用户信息
  Widget userInfo() {
    return Column(
      children: [
        indexController.playerInfo['user'][indexController.userName.value]
                    ['role'] ==
                17
            ? Text(
                "角色：${indexController.hide.value ? "" : XConfig.roleMap[indexController.playerInfo['user'][indexController.userName.value]['drunkId']]}")
            : Text(
                "角色：${indexController.hide.value ? "" : XConfig.roleMap[indexController.playerInfo['user'][indexController.userName.value]['role']]}"),
        Text(
            "状态：${indexController.hide.value ? "" : (indexController.playerInfo['user'][indexController.userName.value]['alive'] ?? true) ? "活着" : "死了"}"),
        Text(
            "假身份：${indexController.hide.value ? "" : XConfig.roleMap[indexController.playerInfo['user'][indexController.userName.value]['devil']] ?? "无"}"),
        if (indexController.playerRoleId > 17) //邪恶玩家
          xieeWidget()
      ],
    );
  }

  //间谍魔典
  Widget jiandieWidget() {
    List<Widget> widgetList = [];
    indexController.playerInfo['user'].forEach((key, value) {
      widgetList.add(Text("$key:${XConfig.roleMap[value['role']]}"));
    });
    return Column(children: indexController.hide.value ? [] : widgetList);
  }

  //查验信息
  Widget checkInfo() {
    return Column(
      children: [
        Text(indexController.hide.value
            ? ""
            : indexController.playerInfo['content']['data']),
      ],
    );
  }

  //邪恶玩家信息
  Widget xieeWidget() {
    List<Widget> widgetList = [];
    widgetList.add(const Text("邪恶玩家阵营："));
    indexController.playerInfo['user'].forEach((key, value) {
      if (value['role'] > 17) {
        widgetList.add(Text(
            "$key:${XConfig.roleMap[value['role']]}，假身份：${XConfig.roleMap[value['devil']]}"));
      }
    });
    return Column(children: indexController.hide.value ? [] : widgetList);
  }

  //隐藏按钮
  Widget hideBtn() {
    return GestureDetector(
      onTap: () {
        indexController.hide.value = !indexController.hide.value;
      },
      child: Container(
        width: 500.w,
        height: 70.w,
        alignment: Alignment.center,
        decoration: BoxDecoration(
            color: const Color(0xFF2E71F8),
            borderRadius: BorderRadius.all(Radius.circular(8.w))),
        child: Text(
          "隐藏/展示信息",
          style: TextStyle(color: Colors.white, fontSize: 32.sp),
        ),
      ),
    );
  }

  //游戏重制按钮
  Widget remarkBtn() {
    return GestureDetector(
      onTap: () {
        Get.delete<IndexController>();
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
              builder: (context) => const FirstPage(),
            ),
            (route) => route == null);
      },
      child: Container(
        width: 500.w,
        height: 70.w,
        alignment: Alignment.center,
        decoration: BoxDecoration(
            color: const Color(0xFF2E71F8),
            borderRadius: BorderRadius.all(Radius.circular(8.w))),
        child: Text(
          "重制",
          style: TextStyle(color: Colors.white, fontSize: 32.sp),
        ),
      ),
    );
  }
}
