import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:xrzl/banbenyi/controller/index_controller.dart';
import 'package:xrzl/banbenyi/page/index_page.dart';
import 'package:xrzl/banbenyi/page/player_page.dart';
import 'package:xrzl/common/widget/xwidget.dart';

//首页 选择角色
class FirstPage extends StatefulWidget {
  const FirstPage({super.key});

  @override
  State<FirstPage> createState() => _FirstPageState();
}

class _FirstPageState extends State<FirstPage> {
  late IndexController indexController;

  @override
  void initState() {
    super.initState();
    indexController = IndexController();
    Get.put(indexController);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: XWidget.myAppbar("血染钟楼-选择身份", false, context),
        body: Center(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            GestureDetector(
              onTap: () {
                indexController.userType = 1;
                Get.to(const PlayerPage());
              },
              child: Container(
                width: 200.w,
                height: 70.w,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    color: const Color(0xFF2E71F8),
                    borderRadius: BorderRadius.all(Radius.circular(8.w))),
                child: Text(
                  "我是玩家",
                  style: TextStyle(color: Colors.white, fontSize: 32.sp),
                ),
              ),
            ),
            SizedBox(
              height: 100.w,
            ),
            GestureDetector(
              onTap: () {
                indexController.userType = 2;
                Get.to(const IndexPage());
              },
              child: Container(
                width: 200.w,
                height: 70.w,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    color: const Color(0xFF2E71F8),
                    borderRadius: BorderRadius.all(Radius.circular(8.w))),
                child: Text(
                  "我是说书人",
                  style: TextStyle(color: Colors.white, fontSize: 32.sp),
                ),
              ),
            ),
          ],
        )));
  }
}
