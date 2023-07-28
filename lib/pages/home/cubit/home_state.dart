part of 'home_cubit.dart';

@immutable
abstract class HomeState {}

class HomeInitial extends HomeState {}

class HomeFetch extends HomeState {
  final CategoryModel? categories;
  final List<Meals>? randomMeal;
  final List<Meals>? areaList;
  HomeFetch(this.categories,this.randomMeal,this.areaList);
}

class HomeLoading extends HomeState {
  HomeLoading();
}

class HomeError extends HomeState {
  final String error;
  HomeError(this.error);
}
