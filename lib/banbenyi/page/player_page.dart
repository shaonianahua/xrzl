import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:xrzl/banbenyi/controller/index_controller.dart';
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
                    indexController.userName.value =
                        textController.text.toString();
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
            })
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
}
