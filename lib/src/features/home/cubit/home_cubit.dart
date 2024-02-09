import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:shahzaib_abid/src/features/home/models/home_model.dart';
import 'package:shahzaib_abid/src/features/home/network/home_repo.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(const HomeInitial(categories: null)) {
    _homeRepo = HomeRepo();
  }

  late HomeRepo _homeRepo;

  Future getHomeData() async {
    try{
      emit(HomeDataLoading(loading: true, categories: state.categories));
      final res = await _homeRepo.getHomeData();
      emit(HomeDataLoading(loading: false, categories: res));
      emit(HomeDataLoaded(categories: res));
    }catch(e, t){
      print(e); print(t);
      emit(HomeDataLoading(loading: false, categories: state.categories));
      emit(HomeDataError(message: e.toString(), categories: state.categories));
    }
  }
}
