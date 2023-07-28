import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meal_app_bloc/widgets/custom_meal_card.dart';

import '../../details/view/details_page_view.dart';
import '../cubit/saved_meals_cubit.dart';

class SavedMealsView extends StatefulWidget {
  const SavedMealsView({super.key});

  @override
  State<SavedMealsView> createState() => _SavedMealsViewState();
}

class _SavedMealsViewState extends State<SavedMealsView> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SavedMealsCubit()..getSavedMeals(),
      child: Scaffold(
          appBar: AppBar(),
          body: BlocBuilder<SavedMealsCubit, SavedMealsState>(
            builder: (context, state) {
              if (state is SavedMealsError) {
                return Center(child: Text(state.error));
              } else if (state is SavedMealsFetch) {
                return ListView.builder(
                  itemCount: state.meals.length,
                  itemBuilder: (BuildContext context, int index) {
                    return CustomMealCard(
                      title: state.meals[index]?.strMeal ?? "",
                      subtitle: state.meals[index]?.strArea ?? "",
                      id: state.meals[index]?.idMeal ?? "",
                      image: state.meals[index]?.strMealThumb ?? "",
                      onTap: () {
                         if (state.meals[index]?.idMeal != null) {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => DetailsPageView(
                                  id: "${state.meals[index]?.idMeal}",
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
