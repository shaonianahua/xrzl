import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:xrzl/common/widget/journal_widget.dart';
import 'package:xrzl/common/widget/xconfig.dart';

class XWidget {
  static PreferredSizeWidget myAppbar(
      String title, bool journal, BuildContext context) {
    return AppBar(
      title: Text(
        title,
        style: TextStyle(fontSize: 40.sp, color: const Color(0xff333333)),
      ),
      centerTitle: true,
      elevation: 0,
      actions: [
        if (journal)
          GestureDetector(
            onTap: () {
              showModalBottomSheet(
                  context: context,
                  isScrollControlled: false,
                  builder: (BuildContext context) {
                    return const JournalWidget();
                  });
            },
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 20.w, horizontal: 30.w),
              child: Text("日志"),
            ),
          )
      ],
    );
  }

  //提示
  static showTextTip(String text) {
    BotToast.showText(text: text);
  }

  //夜晚用户信息展示
  static String peopleNightInfo(String name, Map<String, dynamic> value) {
    //角色-role 宿敌-enemy 中毒-poison 被僧侣保护-protect 存活状态-alive 是否变恶魔-isDevil
    String text =
        "$name(${XConfig.roleMap[value['role']]})${(value['protect'] ?? false) ? "(被保护)" : ""}${(value['poison'] ?? false) ? "(中毒)" : ""}${(value['enemy'] ?? false) ? "(宿敌)" : ""}${(value['alive'] ?? true) ? "" : "(死亡)"}${(value['isDevil'] ?? false) ? "(已变恶魔)" : ""}";
    return text;
  }
}
