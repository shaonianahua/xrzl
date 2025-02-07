class XConfig {
  static List<String> peopleNameList = [
    "李晨辉",
    "李晓宝",
    "刘丹飏",
    "杨一帆",
    "金英鑫",
    "魏正晨",
    "张石磊",
    "王晨",
    "周先念",
    "王建峰",
  ];

  //角色版 1-13是村民 14-17是外来者 18-21是爪牙 22是恶魔 
  static Map<int, String> roleMap = {
    1: "洗衣妇",
    2: "图书管理员",
    3: "调查员",
    4: "厨师",
    5: "共情者",
    6: "占卜师",
    7: "掘墓人",
    8: "僧侣",
    9: "守鸦人",
    10: "圣女",
    11: "杀手",
    12: "士兵",
    13: "市长",
    14: "隐士",
    15: "管家",
    16: "圣徒",
    17: "酒鬼",
    18: "荡妇",
    19: "男爵",
    20: "间谍",
    21: "下毒者",
    22: "恶魔",
  };

  //角色对应数 村民 外来者 爪牙 恶魔
  static Map<int, List> roleConfig = {
    5: [3, 0, 1, 1],
    6: [3, 1, 1, 1],
    7: [5, 0, 1, 1],
    8: [5, 1, 1, 1],
    9: [5, 2, 1, 1],
    10: [7, 0, 2, 1],
    11: [7, 1, 2, 1],
    12: [7, 2, 2, 1],
    13: [9, 0, 3, 1],
    14: [9, 1, 3, 1],
    15: [9, 2, 3, 1],
  };
}
