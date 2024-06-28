import 'package:dio/dio.dart';

class DioUtils {
  static final dio = Dio();

  static getInfo() async {
    Response response;
    response = await dio.get(
        'https://datatest.mijiaoyu.cn/ifree/text-ext/get-by-name',
        queryParameters: {"name": "xrzl"});
    print(response.data['data']['content'].toString());
  }

  static saveInfo(String content) async {
    Response response;
    response = await dio.post(
        'https://datatest.mijiaoyu.cn/ifree/text-ext/save',
        data: {"id": 72, "content": content, "name": "xrzl", "remark": "不要删除"});
  }
}
