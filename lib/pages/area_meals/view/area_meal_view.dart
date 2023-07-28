import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../widgets/custom_meal_card.dart';
import '../../details/view/details_page_view.dart';
import '../cubit/areameal_cubit.dart';

class AreaMealView extends StatelessWidget {
  const AreaMealView({super.key, required this.area});

  final String area;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AreamealCubit()..areaMeals(area),
      child: Scaffold(
          appBar: AppBar(
            centerTitle: false,
            title: Text(area),
          ),
          body: BlocBuilder<AreamealCubit, AreamealState>(
            builder: (context, state) {
              if (state is AreaMealError) {
                return Center(child: Text(state.error));
              } else if (state is AreaMealFetch) {
                return ListView.builder(
                  physics: const ClampingScrollPhysics(),
                  itemCount: state.areaMealList?.length,
                  itemBuilder: (BuildContext context, int index) {
                    return CustomMealCard(
                      title: state.areaMealList?[index].strMeal ?? "",
                      subtitle: state.areaMealList?[index].strArea ?? "",
                      id: state.areaMealList?[index].idMeal ?? "",
                      image: state.areaMealList?[index].strMealThumb ?? "",
                      onTap: () {
                        if (state.areaMealList?[index].idMeal != null) {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => DetailsPageView(
                                id: "${state.areaMealList?[index].idMeal}",
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
