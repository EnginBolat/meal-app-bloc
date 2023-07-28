import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:meal_app_bloc/pages/area_meals/view/area_meal_view.dart';
import 'package:meal_app_bloc/pages/category_meals/view/category_meals_view.dart';
import 'package:meal_app_bloc/pages/details/view/details_page_view.dart';
import 'package:meal_app_bloc/pages/home/cubit/home_cubit.dart';
import 'package:meal_app_bloc/pages/saved_meals/view/saved_meals.dart';

import '../../../constants/app_image.dart';
import '../../../model/category_model.dart';
import '../../../widgets/custom_meal_card.dart';
import '../../../widgets/search_delegate.dart';

class HomePageView extends StatelessWidget {
  const HomePageView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomeCubit()..fetchHomePage(),
      child: Scaffold(
        appBar: AppBar(
          actions: [
            IconButton(
              icon: const Icon(Icons.search_outlined),
              onPressed: () {
                showSearch(
                  context: context,
                  delegate: AppBarSearchDelegate(),
                );
              },
            ),
          ],
        ),
        body: _buildBody(),
        drawer: _buildDrawer(context),
      ),
    );
  }

  Drawer _buildDrawer(BuildContext context) {
    return Drawer(
      child: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              ListTile(
                onTap: (){
                  Navigator.of(context).push(MaterialPageRoute(builder: (context) => const SavedMealsView(),));
                },
                leading: const Icon(Icons.bookmark_outlined),
                title: const Text("Saved"),
              )
            ],
          ),
        ),
      ),
    );
  }

  BlocBuilder<HomeCubit, HomeState> _buildBody() {
    return BlocBuilder<HomeCubit, HomeState>(
      builder: (context, state) {
        if (state is HomeError) {
          return Center(child: Text(state.error));
        } else if (state is HomeFetch) {
          return SingleChildScrollView(
            physics: const ClampingScrollPhysics(),
            child: Column(
              children: [
                _buildCategories(state),
                const _BuildTitle(title: "Ülkeler"),
                SizedBox(
                  height: 80.h,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: state.areaList?.length,
                    itemBuilder: (BuildContext context, int index) {
                      return GestureDetector(
                        onTap: () {
                          if (state.areaList?[index].strArea != null) {
                            Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => AreaMealView(
                                  area: state.areaList?[index].strArea ?? ""),
                            ));
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('Area Meals Cannot Found'),
                                duration: Duration(seconds: 1),
                              ),
                            );
                          }
                        },
                        child: Image.asset(
                            "assets/flags/${state.areaList?[index].strArea}.png"),
                      );
                    },
                  ),
                ),
                const _BuildTitle(title: "Tavsiyeler"),
                Container(
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.primary,
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: ListView.builder(
                    padding:
                        EdgeInsets.symmetric(horizontal: 4.h, vertical: 12.h),
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: state.randomMeal?.length ?? 0,
                    itemBuilder: (BuildContext context, int index) {
                      return CustomMealCard(
                        title: state.randomMeal?[index].strMeal ?? "",
                        subtitle: state.randomMeal?[index].strArea ?? "",
                        id: state.randomMeal?[index].idMeal ?? "",
                        image: state.randomMeal?[index].strMealThumb ?? "",
                        onTap: () {
                          if (state.randomMeal?[index].idMeal != null) {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => DetailsPageView(
                                  id: "${state.randomMeal?[index].idMeal}",
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
                  ),
                ),
              ],
            ),
          );
        } else {
          return const Center(child: CircularProgressIndicator.adaptive());
        }
      },
    );
  }

  Padding _buildCategories(HomeFetch state) {
    return Padding(
      padding: EdgeInsets.all(4.h),
      child: Column(
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              "Kategoriler",
              style: TextStyle(
                fontSize: 24.h,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          SizedBox(
            height: 120.h,
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: state.categories?.categories?.length ?? 0,
              scrollDirection: Axis.horizontal,
              itemBuilder: (BuildContext context, int index) {
                Categories? item = state.categories?.categories?[index];
                return Padding(
                  padding: EdgeInsets.only(right: 8.w),
                  child: GestureDetector(
                    onTap: () {
                      if (item?.strCategory != null) {
                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => CategoryMealsView(
                              category: item?.strCategory ?? ""),
                        ));
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Category Meals Cannot Found'),
                            duration: Duration(seconds: 1),
                          ),
                        );
                      }
                    },
                    child: Container(
                      height: 128.h,
                      width: 128.w,
                      decoration: const BoxDecoration(
                        color: Colors.transparent,
                        shape: BoxShape.circle,
                      ),
                      child: FadeInImage(
                        placeholder: AssetImage(AppImage.questionMark),
                        image: NetworkImage(item?.strCategoryThumb ?? ""),
                        imageErrorBuilder: (context, error, stackTrace) =>
                            Image.asset(AppImage.questionMark),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class _BuildTitle extends StatelessWidget {
  const _BuildTitle({required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(4.h),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Text(
          title,
          style: TextStyle(
            fontSize: 24.h,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}
