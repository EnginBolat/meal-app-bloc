import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:meal_app_bloc/core/service/database_service.dart';
import 'package:meal_app_bloc/core/service/dio_service.dart';
import 'package:meal_app_bloc/model/meal_details_model.dart';
import 'package:meta/meta.dart';

import '../../../model/database_model.dart';

part 'saved_meals_state.dart';

class SavedMealsCubit extends Cubit<SavedMealsState> {
  SavedMealsCubit() : super(SavedMealsInitial());
  final IDioService dioService = DioService();

  Future getSavedMeals() async {
    try {
      List<SavedMealModel>? savedMeals =
          await DatabaseService.instance.allSavedMeals();
      List<Meals?> mealsList = [];

      if ((savedMeals?.length ?? 0) > 0) {
        for (var i = 0; i < (savedMeals?.length ?? 0); i++) {
          Meals? meal =
              await dioService.mealDetailsById(savedMeals![i].id.toString());
          mealsList.add(meal);
        }
      }
      emit(SavedMealsFetch(mealsList));
    } catch (e) {
      log("Get Saved News Error");
    }
  }
}
