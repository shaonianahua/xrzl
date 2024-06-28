import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:xrzl/banbenyi/controller/index_controller.dart';
import 'package:xrzl/common/widget/xconfig.dart';
import 'package:xrzl/common/widget/xwidget.dart';

//白天界面
class DayPage extends StatefulWidget {
  const DayPage({super.key});

  @override
  State<DayPage> createState() => _DayPageState();
}

class _DayPageState extends State<DayPage> {
  late IndexController indexController;
  bool alive = false;

  @override
  void initState() {
    super.initState();
    indexController = Get.find<IndexController>();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: XWidget.myAppbar("血染钟楼-白天", false, context),
      body: Obx(() {
        return Column(
          children: [
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
            GestureDetector(
                onTap: () {
                  indexController.nextStep();
                },
                child: Container(
                  width: 200.w,
                  height: 70.w,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(8.w)),
                      color: const Color(0xFF2E71F8)),
                  child: const Text(
                    "进入黑夜",
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
    alive = indexController.peopleMap[name]?['alive'] ?? true;
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
                              indexController.die(name);
                              indexController.journal("白天处决了$name");
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
                          child: ListView(children: [
                        SizedBox(
                          height: 20.w,
                        ),
                        const Text("状态："),
                        SizedBox(
                          height: 20.w,
                        ),
                        Wrap(spacing: 20.w, runSpacing: 10.w, children: [
                          GestureDetector(
                              onTap: () {
                                state(() {
                                  alive = !alive;
                                });
                              },
                              child: Container(
                                width: 200.w,
                                alignment: Alignment.center,
                                height: 60.w,
                                decoration: BoxDecoration(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(8.w)),
                                    color:
                                        Color(alive ? 0xFF2E71F8 : 0xffeeeeee)),
                                child: Text(
                                  "活着",
                                  style: TextStyle(
                                      fontSize: 28.sp,
                                      color: Color(
                                          alive ? 0xffffffff : 0xff222222)),
                                ),
                              )),
                          GestureDetector(
                              onTap: () {
                                state(() {
                                  alive = !alive;
                                });
                              },
                              child: Container(
                                width: 200.w,
                                alignment: Alignment.center,
                                height: 60.w,
                                decoration: BoxDecoration(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(8.w)),
                                    color: Color(
                                        !alive ? 0xFF2E71F8 : 0xffeeeeee)),
                                child: Text(
                                  "死了",
                                  style: TextStyle(
                                      fontSize: 28.sp,
                                      color: Color(
                                          !alive ? 0xffffffff : 0xff222222)),
                                ),
                              ))
                        ]),
                        SizedBox(
                          height: 20.w,
                        )
                      ]))
                    ]));
          });
        });
  }
}
