import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:xrzl/banbenyi/controller/index_controller.dart';

//日志
class JournalWidget extends StatefulWidget {
  const JournalWidget({super.key});

  @override
  State<JournalWidget> createState() => _JournalWidgetState();
}

class _JournalWidgetState extends State<JournalWidget> {
  late IndexController indexController;
  String name = "";
  int roleId = 21;

  @override
  void initState() {
    super.initState();
    indexController = Get.find<IndexController>();
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        for (int i = 0; i < indexController.journalList.length; i++)
          Container(
            padding: EdgeInsets.symmetric(vertical: 10.w, horizontal: 20.w),
            child: Text(indexController.journalList[i]),
          )
      ],
    );
  }
}
