part of 'home_cubit.dart';

@immutable
abstract class HomeState {
  const HomeState({required this.categories});
  final List<CategoryData>? categories;
}

class HomeInitial extends HomeState {
  const HomeInitial({required super.categories});
}

class HomeDataLoading extends HomeState {
  const HomeDataLoading({required this.loading, required super.categories});
  final bool loading;
}

class HomeDataLoaded extends HomeState {
  const HomeDataLoaded({required super.categories});
}

class HomeDataError extends HomeState {
  const HomeDataError({required this.message, required super.categories});
  final String message;
}


