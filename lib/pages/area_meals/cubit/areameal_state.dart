part of 'areameal_cubit.dart';

@immutable
abstract class AreamealState {}

class AreamealInitial extends AreamealState {}

class AreaMealFetch extends AreamealState {
  final List<Meals>? areaMealList;
  AreaMealFetch(this.areaMealList);
}

class AreaMealLoading extends AreamealState {
  AreaMealLoading();
}

class AreaMealError extends AreamealState {
  final String error;
  AreaMealError(this.error);
}
