import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:meal_app_bloc/core/service/dio_service.dart';
import 'package:meta/meta.dart';

import '../../../core/service/database_service.dart';
import '../../../model/database_model.dart';
import '../../../model/meal_details_model.dart';

part 'details_state.dart';

class DetailsCubit extends Cubit<DetailsState> {
  DetailsCubit() : super(DetailsInitial());

  final IDioService dioService = DioService();

  Future getDetailsById(String id) async {
    late List<SavedMealModel>? savedMeals = [];
    late IconData icon = Icons.bookmark;
    emit(DetailsLoading());
    try {
      Meals? details = await dioService.mealDetailsById(id);
      savedMeals = await DatabaseService.instance.allSavedMeals();
      SavedMealModel model = SavedMealModel(id: int.parse(id));
      for (var i = 0; i < (savedMeals?.length ?? 0); i++) {
        log((savedMeals?[i].id == model.id).toString());
        if ((savedMeals?[i].id == model.id) == true) {
          icon = Icons.bookmark;
          emit(DetailsFetch(details, icon));
        } else {
          icon = Icons.bookmark_outline;
          emit(DetailsFetch(details, icon));
        }
      }
      emit(DetailsFetch(details, icon));
    } catch (e) {
      emit(DetailsError("Detay Bilgisi Bulunamadı"));
    }
  }
}
