import '../../../services/api_service.dart';

class HomeDataSrc {

  Future getHomeData() async {
    final res = APIService.instance.request(
        '/category',
        DioMethod.get,
    );
    return res;
  }


}