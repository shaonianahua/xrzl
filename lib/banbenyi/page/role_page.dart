import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:xrzl/banbenyi/controller/index_controller.dart';
import 'package:xrzl/banbenyi/page/night_page.dart';
import 'package:xrzl/common/widget/xconfig.dart';
import 'package:xrzl/common/widget/xwidget.dart';

class RoleIndex extends StatefulWidget {
  const RoleIndex({super.key});

  @override
  State<RoleIndex> createState() => _RoleIndexState();
}

class _RoleIndexState extends State<RoleIndex> {
  late IndexController indexController;
  int roleId = 0; //角色id
  String enemy = ""; //宿敌名字
  int falseId = 0; //酒鬼/邪恶阵营的第二身份

  @override
  void initState() {
    super.initState();
    indexController = Get.find<IndexController>();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: XWidget.myAppbar("血染钟楼-角色配置", false, context),
      body: Obx(() {
        return Column(
          children: [
            Text(
                "本场需要${indexController.roleMap[19]['isSelect'] ? XConfig.roleConfig[indexController.peopleNum.value]![0] - 2 : XConfig.roleConfig[indexController.peopleNum.value]![0]}个村民，${indexController.roleMap[19]['isSelect'] ? XConfig.roleConfig[indexController.peopleNum.value]![1] + 2 : XConfig.roleConfig[indexController.peopleNum.value]![1]}个外来者，${XConfig.roleConfig[indexController.peopleNum.value]![2]}个爪牙，1个恶魔"),
            SizedBox(
              height: 20.w,
            ),
            Expanded(
                child: ListView(
              padding: EdgeInsets.symmetric(horizontal: 30.w, vertical: 40.w),
              children: [
                Center(
                    child: Wrap(
                        spacing: 100.w,
                        runSpacing: 160.w,
                        children: peopleWidgetList())),
              ],
            )),
            SizedBox(
              height: 50.w,
            ),
            const Text("开始前，让所有玩家闭眼，邪恶阵营玩家睁眼，互相确认身份，然后都闭眼，点击开始游戏，正式开始"),
            SizedBox(
              height: 20.w,
            ),
            GestureDetector(
                onTap: () {
                  bool canPlay = true;
                  //检查
                  List<int> playerNumList = [0, 0, 0, 0];
                  indexController.peopleMap.forEach((key, value) {
                    if (value['role'] != null && value['role'] != 0) {
                      if (value['role'] < 14) {
                        playerNumList[0]++;
                      } else if (value['role'] >= 14 && value['role'] < 18) {
                        playerNumList[1]++;
                      } else if (value['role'] >= 18 && value['role'] < 22) {
                        playerNumList[2]++;
                      } else {
                        playerNumList[3]++;
                      }
                    } else {
                      canPlay = false;
                    }
                  });
                  if (!canPlay) {
                    XWidget.showTextTip("请为所有人选择角色");
                    return;
                  }
                  for (int i = 0; i < playerNumList.length; i++) {
                    //对男爵的加入进行额外判断
                    if (indexController.roleMap[19]['isSelect']) {
                      if (i == 0) {
                        if ((XConfig.roleConfig[
                                    indexController.peopleNum.value]![i] -
                                2) !=
                            playerNumList[i]) {
                          canPlay = false;
                          break;
                        }
                      } else if (i == 1) {
                        if ((XConfig.roleConfig[
                                    indexController.peopleNum.value]![i] +
                                2) !=
                            playerNumList[i]) {
                          canPlay = false;
                          break;
                        }
                      } else {
                        if (XConfig.roleConfig[
                                indexController.peopleNum.value]![i] !=
                            playerNumList[i]) {
                          canPlay = false;
                          break;
                        }
                      }
                    } else {
                      if (XConfig.roleConfig[indexController.peopleNum.value]![
                              i] !=
                          playerNumList[i]) {
                        canPlay = false;
                        break;
                      }
                    }
                  }
                  if (!canPlay) {
                    XWidget.showTextTip(
                        "请搭配配置，${indexController.peopleNum.value}人局需要${indexController.roleMap[19]['isSelect'] ? XConfig.roleConfig[indexController.peopleNum.value]![0] - 2 : XConfig.roleConfig[indexController.peopleNum.value]![0]}个村民，${indexController.roleMap[19]['isSelect'] ? XConfig.roleConfig[indexController.peopleNum.value]![1] + 2 : XConfig.roleConfig[indexController.peopleNum.value]![1]}个外来者，${XConfig.roleConfig[indexController.peopleNum.value]![2]}个爪牙，1个恶魔");
                    return;
                  }
                  if (canPlay) {
                    //配置初始化信息参数
                    indexController.sendPlayerInfo("");
                    indexController.journal("天黑了，进入第1个黑夜");
                    Get.to(const NightPage());
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
                    "开始游戏",
                    style: TextStyle(color: Colors.white),
                  ),
                )),
            SizedBox(
              height: 20.w,
            )
          ],
        );
      }),
    );
  }

  List<Widget> peopleWidgetList() {
    List<Widget> widgetList = [];
    indexController.peopleMap.forEach((key, value) {
      widgetList.add(GestureDetector(
          onTap: () {
            configInfo(key);
          },
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                alignment: Alignment.center,
                width: 250.w,
                height: 90.w,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(8.w)),
                    color: Color(
                        (indexController.peopleMap[key]?['alive'] ?? true)
                            ? 0xFF2E71F8
                            : 0xffFF5219)),
                child: Text(
                  key,
                  style: TextStyle(fontSize: 28.sp, color: Colors.white),
                ),
              ),
              Text(
                  "角色：${XConfig.roleMap[indexController.peopleMap[key]?['role']] ?? "未选择角色"}"),
              Text(
                  "状态：${(indexController.peopleMap[key]?['alive'] ?? true) ? "活着" : "死了"}"),
              if (indexController.peopleMap[key]?['role'] == 6)
                Text(
                    "宿敌：${indexController.peopleMap[key]?['enemyName'] ?? "未选择"}"),
              if (indexController.peopleMap[key]?['role'] == 17)
                Text(
                    "假身份：${XConfig.roleMap[indexController.peopleMap[key]?['drunkId']] ?? "未选择角色"}"),
              if ((indexController.peopleMap[key]?['role'] ?? 0) > 17)
                Text(
                    "假身份：${XConfig.roleMap[indexController.peopleMap[key]?['devil']] ?? "未选择角色"}"),
            ],
          )));
    });
    return widgetList;
  }

  configInfo(String name) {
    //先把已经保存的信息存储在临时信息中，再把存储的信息删除
    indexController.remakeId(name);
    showModalBottomSheet(
      context: context,
      isScrollControlled: false,
      isDismissible: false,
      builder: (BuildContext context) {
        return StatefulBuilder(builder: (context, state) {
          return Container(
              padding: EdgeInsets.symmetric(horizontal: 30.w, vertical: 20.w),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        GestureDetector(
                          onTap: () {
                            roleId = 0;
                            enemy = "";
                            falseId = 0;
                            Get.back();
                          },
                          child: Container(
                            width: 100.w,
                            alignment: Alignment.center,
                            height: 60.w,
                            decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(8.w)),
                                color: const Color(0xffeeeeee)),
                            child: Text(
                              "返回",
                              style: TextStyle(
                                  fontSize: 28.sp,
                                  color: const Color(0xff222222)),
                            ),
                          ),
                        ),
                        Text("玩家：$name"),
                        GestureDetector(
                          onTap: () {
                            if (roleId == 0) {
                              XWidget.showTextTip("请选择角色");
                              return;
                            }
                            if ((roleId == 17 && falseId == 0) ||
                                (roleId == 6 && enemy == "") ||
                                (roleId > 17 && falseId == 0)) {
                              XWidget.showTextTip("请选择假身份或者宿敌");
                              return;
                            }
                            indexController.updateRole(roleId, name,
                                falseId: falseId, enemyName: enemy);
                            roleId = 0;
                            enemy = "";
                            falseId = 0;
                            Get.back();
                          },
                          child: Container(
                            width: 100.w,
                            alignment: Alignment.center,
                            height: 60.w,
                            decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(8.w)),
                                color: const Color(0xFF2E71F8)),
                            child: Text(
                              "确认",
                              style: TextStyle(
                                  fontSize: 28.sp,
                                  color: const Color(0xffffffff)),
                            ),
                          ),
                        )
                      ],
                    ),
                    Expanded(
                        child: ListView(
                      children: [
                        SizedBox(
                          height: 20.w,
                        ),
                        const Text("角色："),
                        SizedBox(
                          height: 20.w,
                        ),
                        Wrap(
                          spacing: 20.w,
                          runSpacing: 10.w,
                          children: roleWidgetList(name, state),
                        ),
                        SizedBox(
                          height: 20.w,
                        ),
                        //占卜师配置
                        if (roleId == 6) const Text("宿敌："),
                        if (roleId == 6)
                          SizedBox(
                            height: 20.w,
                          ),
                        if (roleId == 6)
                          Wrap(
                            spacing: 20.w,
                            runSpacing: 10.w,
                            children: enemyWidgetList(name, state),
                          ),
                        //酒鬼配置
                        if (roleId == 17) const Text("酒鬼的假身份："),
                        if (roleId == 17)
                          SizedBox(
                            height: 20.w,
                          ),
                        if (roleId == 17)
                          Wrap(
                            spacing: 20.w,
                            runSpacing: 10.w,
                            children: drunkardWidgetList(name, state),
                          ),
                        //爪牙/恶魔配置
                        if (roleId > 17) const Text("爪牙/恶魔的假身份："),
                        if (roleId > 17)
                          SizedBox(
                            height: 20.w,
                          ),
                        if (roleId > 17)
                          Wrap(
                            spacing: 20.w,
                            runSpacing: 10.w,
                            children: devilWidgetList(name, state),
                          ),
                      ],
                    ))
                  ]));
        });
      },
    );
  }

  //选择角色列表
  List<Widget> roleWidgetList(String name, StateSetter state) {
    List<Widget> widgetList = [];
    indexController.roleMap.forEach((key, value) {
      widgetList.add(GestureDetector(
          onTap: () {
            if (value['isSelect'] || (value['false'] ?? false)) {
              //被别人选择的或者假身份就不能再选了
              return;
            }
            state(() {
              roleId = key;
            });
          },
          child: Container(
            width: 200.w,
            alignment: Alignment.center,
            height: 60.w,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(8.w)),
                color: Color(roleId == key ? 0xFF2E71F8 : 0xffeeeeee)),
            child: Text(
              value['name'],
              style: TextStyle(
                  fontSize: 28.sp,
                  color: Color(roleId == key
                      ? 0xffffffff
                      : (value['isSelect'] || (value['false'] ?? false))
                          ? 0xffdddddd
                          : 0xff222222)),
            ),
          )));
    });
    return widgetList;
  }

  //选择宿敌列表（占卜师）
  List<Widget> enemyWidgetList(String name, StateSetter state) {
    List<Widget> widgetList = [];
    indexController.peopleMap.forEach((key, value) {
      widgetList.add(GestureDetector(
          onTap: () {
            if (name == key) {
              return;
            }
            state(() {
              enemy = key;
            });
          },
          child: Container(
            width: 200.w,
            alignment: Alignment.center,
            height: 60.w,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(8.w)),
                color: Color(enemy == key ? 0xFF2E71F8 : 0xffeeeeee)),
            child: Text(
              key,
              style: TextStyle(
                  fontSize: 28.sp,
                  color: Color(enemy == key
                      ? 0xffffffff
                      : (name == key)
                          ? 0xffdddddd
                          : 0xff222222)),
            ),
          )));
    });
    return widgetList;
  }

  //酒鬼选择
  List<Widget> drunkardWidgetList(String name, StateSetter state) {
    List<Widget> widgetList = [];
    indexController.roleMap.forEach((key, value) {
      widgetList.add(GestureDetector(
          onTap: () {
            if ((value['isSelect'] || (value['false'] ?? false)) || key > 13) {
              //被别人选择的就不能再选了 但是自己之前选的可以更改
              return;
            }
            state(() {
              falseId = key;
            });
          },
          child: Container(
            width: 200.w,
            alignment: Alignment.center,
            height: 60.w,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(8.w)),
                color: Color(falseId == key ? 0xFF2E71F8 : 0xffeeeeee)),
            child: Text(
              value['name'],
              style: TextStyle(
                  fontSize: 28.sp,
                  color: Color(falseId == key
                      ? 0xffffffff
                      : ((value['isSelect'] || (value['false'] ?? false)) ||
                              key > 13)
                          ? 0xffdddddd
                          : 0xff222222)),
            ),
          )));
    });
    return widgetList;
  }

  //爪牙/恶魔选择假身份
  List<Widget> devilWidgetList(String name, StateSetter state) {
    List<Widget> widgetList = [];
    indexController.roleMap.forEach((key, value) {
      widgetList.add(GestureDetector(
          onTap: () {
            if ((value['isSelect'] || (value['false'] ?? false)) || key > 17) {
              //被别人选择的就不能再选了 但是自己之前选的可以更改
              return;
            }
            state(() {
              falseId = key;
            });
          },
          child: Container(
            width: 200.w,
            alignment: Alignment.center,
            height: 60.w,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(8.w)),
                color: Color(falseId == key ? 0xFF2E71F8 : 0xffeeeeee)),
            child: Text(
              value['name'],
              style: TextStyle(
                  fontSize: 28.sp,
                  color: Color(falseId == key
                      ? 0xffffffff
                      : ((value['isSelect'] || (value['false'] ?? false)) ||
                              key > 17)
                          ? 0xffdddddd
                          : 0xff222222)),
            ),
          )));
    });
    return widgetList;
  }
}
