import 'package:get/get.dart';
import 'package:xrzl/banbenyi/page/day_page.dart';
import 'package:xrzl/banbenyi/page/night_page.dart';
import 'package:xrzl/common/widget/xwidget.dart';

class IndexController extends GetxController {
  String lastEnemyName = ""; //上一个宿敌的名字 方便更新
  String dangfuName = "";//选择荡妇的人 方便变身时找到
  RxInt peopleNum = RxInt(0);
  RxMap<String, RxMap<String, dynamic>> peopleMap = RxMap();
  RxMap<int, dynamic> roleMap = RxMap({
    1: {
      "name": "洗衣妇",
      "isSelect": false,
    },
    2: {
      "name": "图书管理员",
      "isSelect": false,
    },
    3: {
      "name": "调查员",
      "isSelect": false,
    },
    4: {
      "name": "厨师",
      "isSelect": false,
    },
    5: {
      "name": "神使",
      "isSelect": false,
    },
    6: {
      "name": "预言家",
      "isSelect": false,
    },
    7: {
      "name": "送葬者",
      "isSelect": false,
    },
    8: {
      "name": "僧侣",
      "isSelect": false,
    },
    9: {
      "name": "养鸦人",
      "isSelect": false,
    },
    10: {
      "name": "处女",
      "isSelect": false,
    },
    11: {
      "name": "杀手",
      "isSelect": false,
    },
    12: {
      "name": "军人",
      "isSelect": false,
    },
    13: {
      "name": "镇长",
      "isSelect": false,
    },
    14: {
      "name": "隐士",
      "isSelect": false,
    },
    15: {
      "name": "家仆",
      "isSelect": false,
    },
    16: {
      "name": "圣徒",
      "isSelect": false,
    },
    17: {
      "name": "酒鬼",
      "isSelect": false,
    },
    18: {
      "name": "荡妇",
      "isSelect": false,
    },
    19: {
      "name": "男爵",
      "isSelect": false,
    },
    20: {
      "name": "间谍",
      "isSelect": false,
    },
    21: {
      "name": "毒师",
      "isSelect": false,
    },
    22: {
      "name": "恶魔",
      "isSelect": false,
    },
  }); //角色使用库
  RxInt nightIndex = RxInt(1); //第几晚 默认为1
  RxBool isNight = RxBool(true); //是否是夜晚 默认为是
  //流程器
  RxInt flowIndex = RxInt(0); //当前进程 夜晚结束时重制
  List<int> flowListFirst = [21, 1, 2, 3, 4, 5, 6, 15, 20]; //第一晚的流程
  List<int> flowListOther = [21, 8, 18, 22, 9, 5, 6, 15, 7, 20]; //其他晚的流程
  List<String> journalList = []; //日志列表
  List<int> roleDieList = []; //角色死亡记录列表

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onClose() {
    super.onClose();
  }

  //更新角色信息
  updateRole(int roleId, String name,
      {int falseId = 0, String enemyName = ""}) {
    //传入选择的角色-roleId 玩家姓名-name 伪装身份可选参数-falseId
    //先更新角色卡池数据
    roleMap[roleId]['isSelect'] = true;
    if (falseId != 0) {
      roleMap[falseId]['false'] = true;
    }
    //再更新玩家信息
    if (roleId == 6) {
      //预言家设置宿敌
      if (lastEnemyName != "") {
        peopleMap[lastEnemyName]?['enemy'] = false;
      }
      peopleMap[enemyName]?['enemy'] = true;
      peopleMap[name]?['enemyName'] = enemyName;
      lastEnemyName = enemyName;
    }
    if (roleId == 17) {
      //酒鬼的假身份
      peopleMap[name]?['drunkId'] = falseId;
    }
    if (roleId > 17) {
      //邪恶阵营假身份
      peopleMap[name]?['devil'] = falseId;
    }
    if(roleId == 18){
      dangfuName = name;
    }
    peopleMap[name]?['role'] = roleId;
  }

  //进入下个角色环节 全结束的话进入白天
  nextStep() {
    if (!isNight.value) {
      //白天执行此操作直接进入黑夜
      flowIndex.value = 0;
      peopleMap.forEach((key, value) {
        value['poison'] = false;
        value['protect'] = false;
      });
      isNight.value = true;
      journal("天黑了，进入第$nightIndex个黑夜");
      XWidget.showTextTip("天黑了");
      Get.to(const NightPage());
    } else {
      //黑夜就往后执行新的角色 没有的话进入白天
      if (nightIndex.value == 1) {
        if (flowListFirst.length - 1 == flowIndex.value) {
          //最后一名角色
          isNight.value = false;
          nightIndex.value++;
          XWidget.showTextTip("天亮了");
          Get.to(const DayPage());
          journal("天亮了，进入第$nightIndex个白天");
        } else {
          flowIndex.value++;
        }
      } else {
        if (flowListOther.length - 1 == flowIndex.value) {
          isNight.value = false;
          nightIndex.value++;
          XWidget.showTextTip("天亮了");
          Get.to(const DayPage());
          journal("天亮了，进入第$nightIndex个白天");
        } else {
          flowIndex.value++;
        }
      }
    }
  }

  //重制身份信息
  remakeId(String name) {
    if (peopleMap[name]?['role'] != null) {
      roleMap[peopleMap[name]?['role']]['isSelect'] = false;
      roleMap[peopleMap[name]?['role']]['false'] = false;
    }
    peopleMap[name]?.clear();
    if (lastEnemyName == name) {
      peopleMap[name]?['enemy'] = true;
    }
  }

  //日志记录
  journal(String text) {
    journalList.add(text);
  }

  //死亡记录
  die(String name) {
    peopleMap[name]?['alive'] = false;
    roleDieList.add(peopleMap[name]?['role']);
  }

  //荡妇变身
  changeDevil(){
    if(dangfuName!=""){
      peopleMap[dangfuName]?['isDevil'] = true;
    }
  }
}