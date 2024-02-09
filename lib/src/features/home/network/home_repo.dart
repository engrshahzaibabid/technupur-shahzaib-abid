import 'package:flutter/foundation.dart';
import 'package:shahzaib_abid/src/features/home/models/home_model.dart';
import 'package:shahzaib_abid/src/features/home/network/home_data_src.dart';

abstract class _HomeRepo {
  Future<List<CategoryData>> getHomeData();
}

class HomeRepo implements _HomeRepo{
  HomeRepo() {
    _homeDataSrc = HomeDataSrc();
  }

  late HomeDataSrc _homeDataSrc;

  @override
  Future<List<CategoryData>> getHomeData() async {
    final res = await _homeDataSrc.getHomeData();

    print('home data repo: ${res.data}');

    if (res.data != null) {
      final categories = res.data as List;
      return categories.map((e) => CategoryData.fromJson(e)).toList();
    } else {
      throw Exception(res.data['message']);
    }
  }
}