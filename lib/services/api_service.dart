import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:toonflix/models/webtoon_model.dart';

class ApiService {
  static const String baseUrl =
      "https://webtoon-crawler.nomadcoders.workers.dev";
  static const String today = "today";

  static Future<List<WebtoonModel>> getTodaysToons() async {
    try {
      List<WebtoonModel> webtoonInstances = [];
      final url = Uri.parse('$baseUrl/$today');
      final response = await http.get(url);
      if (response.statusCode == 200) {
        final webtoons = jsonDecode(response.body);
        for (var webtoon in webtoons) {
          final instance = WebtoonModel.fromJson(webtoon);
          webtoonInstances.add(instance);
        }
        return webtoonInstances;
      } else {
        throw Error(); // 여기에 예외를 던짐
      }
    } catch (e) {
      print('Connection failed: $e');
      throw Error();
    }
  }
}
