import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';

import '../../../core/service/dio_service.dart';
import '../../../model/meal_details_model.dart';

part 'categorymeals_state.dart';

class CategorymealsCubit extends Cubit<CategorymealsState> {
  CategorymealsCubit() : super(CategorymealsInitial());

   final IDioService dioService = DioService();

  Future areaMeals(String area) async {
    emit(CategorymealsLoading());
    try {
      List<Meals>? areaMealList = await dioService.mealsByCategory(area);
      emit(CategorymealsFetch(areaMealList));
    } catch (e) {
      debugPrint("Area Meals Error: $e");
      emit(CategorymealsError("Meals cannot found"));
    }
  }
}
