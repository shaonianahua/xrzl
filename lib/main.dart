import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'banbenyi/page/first_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        designSize: const Size(750, 1334),
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (_, child) => GetMaterialApp(
              builder: BotToastInit(), //1.调用BotToastInit
              navigatorObservers: [BotToastNavigatorObserver()], //2.注册路由观察者
              home: const FirstPage(),
              title: '血染钟楼',
              debugShowCheckedModeBanner: true,
              theme: ThemeData(
                  primaryColor: const Color(0xFF2E71F8),
                  primaryColorDark: const Color(0xFF2E71F8),
                  useMaterial3: false,
                  cardColor: const Color(0xFF2E71F8),
                  bottomAppBarTheme:
                      const BottomAppBarTheme(color: Colors.transparent)),
            ));
  }
}
