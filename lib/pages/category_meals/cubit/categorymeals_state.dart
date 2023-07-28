part of 'categorymeals_cubit.dart';

@immutable
abstract class CategorymealsState {}

class CategorymealsInitial extends CategorymealsState {}


class CategorymealsFetch extends CategorymealsState{
  final List<Meals>? mealList;
  CategorymealsFetch(this.mealList);
}

class CategorymealsLoading extends CategorymealsState{
  CategorymealsLoading();
}

class CategorymealsError extends CategorymealsState{
  final String error;
  CategorymealsError(this.error);
}
