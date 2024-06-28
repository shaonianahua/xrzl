import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:xrzl/banbenyi/controller/index_controller.dart';
import 'package:xrzl/banbenyi/widget/chushi_widget.dart';
import 'package:xrzl/banbenyi/widget/dangfu_widget.dart';
import 'package:xrzl/banbenyi/widget/diaocha_widget.dart';
import 'package:xrzl/banbenyi/widget/dushi_widget.dart';
import 'package:xrzl/banbenyi/widget/emo_widget.dart';
import 'package:xrzl/banbenyi/widget/guanjia_widget.dart';
import 'package:xrzl/banbenyi/widget/jiandie_widget.dart';
import 'package:xrzl/banbenyi/widget/juemu_widget.dart';
import 'package:xrzl/banbenyi/widget/senglv_widget.dart';
import 'package:xrzl/banbenyi/widget/shenshi_widget.dart';
import 'package:xrzl/banbenyi/widget/shouya_widget.dart';
import 'package:xrzl/banbenyi/widget/tushuyuan_widget.dart';
import 'package:xrzl/banbenyi/widget/xiyifu_widget.dart';
import 'package:xrzl/banbenyi/widget/yuyan_widget.dart';
import 'package:xrzl/common/widget/xwidget.dart';
import 'info_page.dart';

class NightPage extends StatefulWidget {
  const NightPage({super.key});

  @override
  State<NightPage> createState() => _NightPageState();
}

class _NightPageState extends State<NightPage> {
  late IndexController indexController;
  String name = "";

  @override
  void initState() {
    super.initState();
    indexController = Get.find<IndexController>();
  }

  Map<int, Widget> flowList = {
    21: const DushiWidget(), //毒师
    1: const XiyifuWidget(), //洗衣妇
    2: const TushuyuanWidget(), //图书管理员
    3: const DiaochaWidget(), //调查员
    4: const ChushiWidget(), //厨师
    5: const ShenshiWidget(), //神使
    6: const YuyanWidget(), //预言家
    15: const GuanjiaWidget(), //管家
    20: const JiandieWidget(), //间谍
    8: const SenglvWidget(), //僧侣
    18: const DangfuWidget(), //荡妇
    7: const JuemuWidget(), //掘墓人
    9: const ShouyaWidget(), //守鸦人
    22: const EmoWidget(), //小恶魔
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: XWidget.myAppbar("血染钟楼-夜晚", true, context),
        body: Column(
          children: [
            Obx(() {
              return indexController.nightIndex.value == 1
                  ? (flowList[indexController
                          .flowListFirst[indexController.flowIndex.value]] ??
                      Container())
                  : (flowList[indexController
                          .flowListOther[indexController.flowIndex.value]] ??
                      Container());
            }),
            SizedBox(
              height: 100.w,
            ),
            GestureDetector(
                onTap: () {
                  Get.to(const InfoPage());
                },
                child: Container(
                  width: 200.w,
                  height: 70.w,
                  decoration: BoxDecoration(
                      color: const Color.fromARGB(194, 233, 197, 14),
                      borderRadius: BorderRadius.all(Radius.circular(8.w))),
                  alignment: Alignment.center,
                  child: const Text("数据面板"),
                ))
          ],
        ));
  }
}
