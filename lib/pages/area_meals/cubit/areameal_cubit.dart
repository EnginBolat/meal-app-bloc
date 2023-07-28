import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:meal_app_bloc/core/service/dio_service.dart';

import '../../../model/meal_details_model.dart';

part 'areameal_state.dart';

class AreamealCubit extends Cubit<AreamealState> {
  AreamealCubit() : super(AreamealInitial());

  final IDioService dioService = DioService();

  Future areaMeals(String area) async {
    emit(AreaMealLoading());
    try {
      List<Meals>? areaMealList = await dioService.areaFoodByAreaName(area);
      emit(AreaMealFetch(areaMealList));
    } catch (e) {
      debugPrint("Area Meals Error: $e");
      emit(AreaMealError("Meals cannot found"));
    }
  }
}
