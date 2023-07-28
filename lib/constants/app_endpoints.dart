// ignore_for_file: non_constant_identifier_names

import 'package:flutter/foundation.dart';

@immutable
class AppEndpoints {
  // Base Url
  static String BASE_URL = "https://www.themealdb.com/api/json/v1/1";
  // Search meal by word
  static String searchByWord = "/search.php?s=";
  // Lookup full meal details by id
  static String detailsById = "/lookup.php?i=";
  // List all meal categories
  static String categories = "/categories.php";
  // Filter by category
  static String mealByCategory ="/filter.php?c=";
  // Filter by area
  static String mealByArea = "/filter.php?a=";
  // Random meal
  static String randomMeal = "/random.php";
  // List all areas
  static String allAreas = "/list.php?a=list";
}
