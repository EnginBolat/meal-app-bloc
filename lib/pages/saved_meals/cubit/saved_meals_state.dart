part of 'saved_meals_cubit.dart';

@immutable
abstract class SavedMealsState {}

class SavedMealsInitial extends SavedMealsState {}

class SavedMealsLoading extends SavedMealsState {
  SavedMealsLoading();
}

class SavedMealsError extends SavedMealsState {
  final String error;
  SavedMealsError(this.error);
}

class SavedMealsFetch extends SavedMealsState {
  final List<Meals?> meals;
  SavedMealsFetch(this.meals);
}
