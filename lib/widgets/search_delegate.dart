import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:meal_app_bloc/core/service/dio_service.dart';
import 'package:meal_app_bloc/model/meal_details_model.dart';

import '../pages/details/view/details_page_view.dart';

class AppBarSearchDelegate extends SearchDelegate {
  final IDioService dioService = DioService();
  final ScrollController scrollController = ScrollController();
  List<Meals>? mealsList = [];
  bool isLoading = false;

  @override
  String get searchFieldLabel => "Arama";

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        onPressed: () {
          if (query == "") {
            close(context, null);
          } else {
            query = "";
          }
        },
        icon: const Icon(Icons.clear),
      ),
    ];
  }

  @override
  void showResults(BuildContext context) {}

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      onPressed: () => close(context, null),
      icon: const Icon(Icons.chevron_left_outlined),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return FutureBuilder<List<Meals>?>(
      future: _search(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          return ListView.builder(
            itemCount: mealsList?.length,
            itemBuilder: (BuildContext context, int index) {
              return Card(
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 8.h),
                  child: ListTile(
                    onTap: () {
                      if (mealsList?[index].idMeal != null) {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => DetailsPageView(
                              id: "${mealsList?[index].idMeal}",
                            ),
                          ),
                        );
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Meal Details Cannot Found'),
                            duration: Duration(seconds: 1),
                          ),
                        );
                      }
                    },
                    leading: ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Image.network(
                        mealsList?[index].strMealThumb ?? "",
                      ),
                    ),
                    title: Text(
                      mealsList?[index].strMeal ?? "",
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 16.h,
                      ),
                    ),
                    subtitle: Text(
                      mealsList?[index].strArea ?? "",
                    ),
                  ),
                ),
              );
            },
          );
        } else {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return FutureBuilder<List<Meals>?>(
      future: _search(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          return ListView.builder(
            itemCount: mealsList?.length,
            itemBuilder: (BuildContext context, int index) {
              return Card(
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 8.h),
                  child: ListTile(
                    onTap: () {
                      if (mealsList?[index].idMeal != null) {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => DetailsPageView(
                              id: "${mealsList?[index].idMeal}",
                            ),
                          ),
                        );
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Meal Details Cannot Found'),
                            duration: Duration(seconds: 1),
                          ),
                        );
                      }
                    },
                    leading: ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Image.network(
                        mealsList?[index].strMealThumb ?? "",
                      ),
                    ),
                    title: Text(
                      mealsList?[index].strMeal ?? "",
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 16.h,
                      ),
                    ),
                    subtitle: Text(
                      mealsList?[index].strArea ?? "",
                    ),
                  ),
                ),
              );
            },
          );
        } else {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }

  Future<List<Meals>?> _search() async {
    List<Meals>? data = await (dioService.mealsByWord(query));
    mealsList = data;
    return mealsList;
  }
}
