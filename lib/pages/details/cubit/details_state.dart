part of 'details_cubit.dart';

@immutable
abstract class DetailsState {}

class DetailsInitial extends DetailsState {}

class DetailsFetch extends DetailsState{
  final Meals? mealDetails;
  final IconData saveIcon;
  DetailsFetch(this.mealDetails,this.saveIcon);
}

class DetailsLoading extends DetailsState{
  DetailsLoading();
}

class DetailsError extends DetailsState{
  final String error;
  DetailsError(this.error);
}
