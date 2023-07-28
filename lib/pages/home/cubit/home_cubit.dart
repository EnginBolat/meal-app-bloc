import 'package:bloc/bloc.dart';
import 'package:meal_app_bloc/core/service/dio_service.dart';
import 'package:meal_app_bloc/model/category_model.dart';
import 'package:meal_app_bloc/model/meal_details_model.dart';
import 'package:meta/meta.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeInitial());
  final IDioService _dioService = DioService();

  Future fetchHomePage() async {
    try {
      CategoryModel? categories = await _dioService.categories();
      List<Meals>? mealList = await _dioService.randomMeal();
      List<Meals>? areaList = await _dioService.areaList();
      emit(HomeFetch(categories, mealList,areaList));
    } catch (e) {
      emit(HomeError("Kategori Bilgisi Bulunamadı"));
    }
  }
}
