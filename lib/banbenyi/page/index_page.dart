import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:xrzl/banbenyi/controller/index_controller.dart';
import 'package:xrzl/banbenyi/page/role_page.dart';
import 'package:xrzl/common/widget/xconfig.dart';
import 'package:xrzl/common/widget/xwidget.dart';

class IndexPage extends StatefulWidget {
  const IndexPage({super.key});

  @override
  State<IndexPage> createState() => _IndexPageState();
}

class _IndexPageState extends State<IndexPage> {
  late IndexController indexController;

  @override
  void initState() {
    super.initState();
    indexController = Get.find<IndexController>();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: XWidget.myAppbar("血染钟楼-人员确定", false, context),
        body: Padding(
          padding: EdgeInsets.symmetric(vertical: 30.w, horizontal: 30.w),
          child: Column(
            children: [
              Text(
                "参与人数",
                style:
                    TextStyle(fontSize: 32.sp, color: const Color(0xff333333)),
              ),
              SizedBox(
                height: 20.w,
              ),
              Obx(() {
                return Wrap(
                  spacing: 20.w,
                  runSpacing: 30.w,
                  children: [
                    for (int i = 5; i < 16; i++)
                      GestureDetector(
                        onTap: () {
                          if (indexController.peopleNum.value > i) {
                            indexController.peopleMap.clear();
                          }
                          indexController.peopleNum.value = i;
                        },
                        child: Container(
                          alignment: Alignment.center,
                          width: 120.w,
                          height: 50.w,
                          decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(8.w)),
                              color: Color(indexController.peopleNum.value == i
                                  ? 0xFF2E71F8
                                  : 0xffeeeeee)),
                          child: Text(
                            "$i",
                            style: TextStyle(
                                fontSize: 28.sp,
                                color: indexController.peopleNum.value == i
                                    ? Colors.white
                                    : const Color(0xff222222)),
                          ),
                        ),
                      )
                  ],
                );
              }),
              SizedBox(
                height: 40.w,
              ),
              Text(
                "配置玩家",
                style:
                    TextStyle(fontSize: 32.sp, color: const Color(0xff333333)),
              ),
              SizedBox(
                height: 20.w,
              ),
              Obx(() {
                return Wrap(
                  spacing: 20.w,
                  runSpacing: 30.w,
                  children: [
                    for (int i = 0; i < XConfig.peopleNameList.length; i++)
                      GestureDetector(
                        onTap: () {
                          if (indexController.peopleMap
                              .containsKey(XConfig.peopleNameList[i])) {
                            indexController.peopleMap
                                .remove(XConfig.peopleNameList[i]);
                          } else {
                            if (indexController.peopleMap.length <
                                indexController.peopleNum.value) {
                              indexController
                                      .peopleMap[XConfig.peopleNameList[i]] =
                                  RxMap();
                            } else {
                              XWidget.showTextTip("人数已达最大");
                            }
                          }
                        },
                        child: Container(
                          alignment: Alignment.center,
                          width: 120.w,
                          height: 50.w,
                          decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(8.w)),
                              color: Color(indexController.peopleMap
                                      .containsKey(XConfig.peopleNameList[i])
                                  ? 0xFF2E71F8
                                  : 0xffeeeeee)),
                          child: Text(
                            XConfig.peopleNameList[i],
                            style: TextStyle(
                                fontSize: 28.sp,
                                color: indexController.peopleMap
                                        .containsKey(XConfig.peopleNameList[i])
                                    ? Colors.white
                                    : const Color(0xff222222)),
                          ),
                        ),
                      )
                  ],
                );
              }),
              SizedBox(
                height: 80.w,
              ),
              GestureDetector(
                onTap: () {
                  if (indexController.peopleMap.length !=
                      indexController.peopleNum.value) {
                    XWidget.showTextTip("人数不对");
                    return;
                  }
                  Get.to(const RoleIndex());
                },
                child: Container(
                  alignment: Alignment.center,
                  width: 250.w,
                  height: 90.w,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(8.w)),
                      color: const Color(0xFF2E71F8)),
                  child: Text(
                    "下一步",
                    style: TextStyle(fontSize: 35.sp, color: Colors.white),
                  ),
                ),
              )
            ],
          ),
        ));
  }
}
