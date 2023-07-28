import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../widgets/custom_meal_card.dart';
import '../../details/view/details_page_view.dart';
import '../cubit/categorymeals_cubit.dart';

class CategoryMealsView extends StatelessWidget {
  const CategoryMealsView({super.key, required this.category});

  final String category;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CategorymealsCubit()..areaMeals(category),
      child: Scaffold(
          appBar: AppBar(
            centerTitle: false,
            title: Text(category),
          ),
          body: BlocBuilder<CategorymealsCubit, CategorymealsState>(
            builder: (context, state) {
              if (state is CategorymealsError) {
                return Center(child: Text(state.error));
              } else if (state is CategorymealsFetch) {
                return ListView.builder(
                  physics: const ClampingScrollPhysics(),
                  itemCount: state.mealList?.length,
                  itemBuilder: (BuildContext context, int index) {
                    return CustomMealCard(
                      title: state.mealList?[index].strMeal ?? "",
                      subtitle: state.mealList?[index].strArea ?? "",
                      id: state.mealList?[index].idMeal ?? "",
                      image: state.mealList?[index].strMealThumb ?? "",
                      onTap: () {
                        if (state.mealList?[index].idMeal != null) {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => DetailsPageView(
                                id: "${state.mealList?[index].idMeal}",
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
                    );
                  },
                );
              } else {
                return const Center(
                    child: CircularProgressIndicator.adaptive());
              }
            },
          )),
    );
  }
}
