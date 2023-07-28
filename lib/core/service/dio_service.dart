import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:meal_app_bloc/constants/app_endpoints.dart';

import '../../model/category_model.dart';
import '../../model/meal_details_model.dart';

abstract class IDioService {
  Future<CategoryModel?> categories();
  Future<List<Meals>?> fetch10RandomMeal();
  Future<List<Meals>?> randomMeal();
  Future<Meals?> mealDetailsById(String id);
  Future<List<Meals>?> mealsByWord(String word);
  Future<List<Meals>?> areaList();
  Future<List<Meals>?> areaFoodByAreaName(String area);
  Future<List<Meals>?> mealsByCategory(String category);
}

class DioService extends IDioService {
  late final Dio dio;
  DioService() {
    BaseOptions baseOptions = BaseOptions(baseUrl: AppEndpoints.BASE_URL);
    dio = Dio(baseOptions);
  }

  @override
  Future<CategoryModel?> categories() async {
    try {
      Response response = await dio.get(AppEndpoints.categories);
      if (response.statusCode == HttpStatus.ok) {
        return compute(
            (message) => CategoryModel.fromJson(response.data), null);
      }
    } catch (e) {
      debugPrint("Categories Error : $e");
      return null;
    }
    return null;
  }

  @override
  Future<List<Meals>?> fetch10RandomMeal() async {
    List<Meals>? randomMealList = [];
    int i = 0;
    for (i = 0; i < 10;) {
      Response response = await dio.get(AppEndpoints.randomMeal);
      if (response.statusCode == HttpStatus.ok) {
        final data = response.data['meals'][0];
        final meal = Meals.fromJson(data);
        randomMealList.add(meal);
      }
      i++;
    }
    return randomMealList;
  }

  @override
  Future<List<Meals>?> randomMeal() async {
    try {
      List<Meals>? meal = await fetch10RandomMeal();
      return meal;
    } catch (e) {
      debugPrint("Random Meal Error : $e");
      return null;
    }
  }

  @override
  Future<Meals?> mealDetailsById(String id) async {
    try {
      Response response = await dio.get(AppEndpoints.detailsById + id);
      if (response.statusCode == HttpStatus.ok) {
        final data = response.data['meals'][0];
        return compute((message) => Meals.fromJson(data), null);
      }
    } catch (e) {
      debugPrint("Categories Error : $e");
      return null;
    }
    return null;
  }

  @override
  Future<List<Meals>?> mealsByWord(String word) async {
    try {
      Response response = await dio.get(AppEndpoints.searchByWord + word);
      if (response.statusCode == HttpStatus.ok) {
        final data = response.data['meals'];
        if (data is List) {
          return compute(
              (message) => data.map((e) => Meals.fromJson(e)).toList(), null);
        }
      }
    } catch (e) {
      debugPrint("Search By Word Error : $e");
      return null;
    }
    return null;
  }

  @override
  Future<List<Meals>?> areaList() async {
    try {
      Response response = await dio.get(AppEndpoints.allAreas);
      if (response.statusCode == HttpStatus.ok) {
        final data = response.data['meals'];
        if (data is List) {
          return compute(
              (message) => data.map((e) => Meals.fromJson(e)).toList(), null);
        }
      }
    } catch (e) {
      debugPrint("Search By Word Error : $e");
      return null;
    }
    return null;
  }

  @override
  Future<List<Meals>?> areaFoodByAreaName(String area) async {
    try {
      Response response = await dio.get(AppEndpoints.mealByArea + area);
      if (response.statusCode == HttpStatus.ok) {
        final data = response.data['meals'];
        if (data is List) {
          return compute(
              (message) => data.map((e) => Meals.fromJson(e)).toList(), null);
        }
      }
    } catch (e) {
      debugPrint("Area Food By Area Name : $e");
      return null;
    }
    return null;
  }

  @override
  Future<List<Meals>?> mealsByCategory(String category) async {
    try {
      Response response = await dio.get(AppEndpoints.mealByCategory + category);
      if (response.statusCode == HttpStatus.ok) {
        final data = response.data['meals'];
        if (data is List) {
          return compute(
              (message) => data.map((e) => Meals.fromJson(e)).toList(), null);
        }
      }
    } catch (e) {
      debugPrint("Meal By Category: $e");
      return null;
    }
    return null;
  }
}
