import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:meal_app_bloc/core/service/database_service.dart';
import 'package:meal_app_bloc/pages/details/cubit/details_cubit.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

import '../../../model/database_model.dart';

class DetailsPageView extends StatefulWidget {
  const DetailsPageView({super.key, required this.id});

  final String id;

  @override
  State<DetailsPageView> createState() => _DetailsPageViewState();
}

class _DetailsPageViewState extends State<DetailsPageView> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => DetailsCubit()..getDetailsById(widget.id),
      child: Scaffold(
        appBar: AppBar(),
        body: BlocBuilder<DetailsCubit, DetailsState>(
          builder: (context, state) {
            if (state is DetailsError) {
              return Center(child: Text(state.error));
            } else if (state is DetailsFetch) {
              final String youtubeVideoId = state.mealDetails?.strYoutube
                      ?.substring(
                          32, (state.mealDetails?.strYoutube?.length ?? 0)) ??
                  "";
              return SingleChildScrollView(
                physics: const ClampingScrollPhysics(),
                child: Column(
                  children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width,
                      child:
                          Image.network(state.mealDetails?.strMealThumb ?? ""),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 8.w),
                      child: Column(
                        children: [
                          SizedBox(height: 12.h),
                          _shortInfo(state),
                          SizedBox(height: 12.h),
                          const _BuildTitle(title: "Instructions"),
                          SizedBox(height: 12.h),
                          Text(state.mealDetails?.strInstructions ?? ""),
                          SizedBox(height: 12.h),
                          const _BuildTitle(title: "Ingredients And Measures"),
                          SizedBox(height: 12.h),
                          _buildIngredientsAndMeasures(state),
                          youtubeVideoId != "" && youtubeVideoId != " "
                              ? Column(
                                  children: [
                                    SizedBox(height: 12.h),
                                    const _BuildTitle(title: "Tutorial"),
                                    SizedBox(height: 12.h),
                                    CustomYoutubePlayer(
                                        videoId: youtubeVideoId),
                                  ],
                                )
                              : const SizedBox.shrink(),
                          SizedBox(height: 48.h),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            } else {
              return const Center(child: CircularProgressIndicator.adaptive());
            }
          },
        ),
      ),
    );
  }

  Container _buildIngredientsAndMeasures(DetailsFetch state) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.primary,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: EdgeInsets.all(8.h),
        child: Column(
          children: [
            IngredientAndMeasure(
              strIngredient: state.mealDetails?.strIngredient1 ?? "null",
              strMeasure: state.mealDetails?.strMeasure1 ?? "null",
            ),
            // 2
            IngredientAndMeasure(
              strIngredient: state.mealDetails?.strIngredient2 ?? "null",
              strMeasure: state.mealDetails?.strMeasure2 ?? "null",
            ),
            // 3
            IngredientAndMeasure(
              strIngredient: state.mealDetails?.strIngredient3 ?? "null",
              strMeasure: state.mealDetails?.strMeasure13 ?? "null",
            ),
            // 4
            IngredientAndMeasure(
              strIngredient: state.mealDetails?.strIngredient4 ?? "null",
              strMeasure: state.mealDetails?.strMeasure4 ?? "null",
            ),
            // 5
            IngredientAndMeasure(
              strIngredient: state.mealDetails?.strIngredient5 ?? "null",
              strMeasure: state.mealDetails?.strMeasure5 ?? "null",
            ),
            // 6
            IngredientAndMeasure(
              strIngredient: state.mealDetails?.strIngredient6 ?? "null",
              strMeasure: state.mealDetails?.strMeasure6 ?? "null",
            ),
            // 7
            IngredientAndMeasure(
              strIngredient: state.mealDetails?.strIngredient7 ?? "null",
              strMeasure: state.mealDetails?.strMeasure7 ?? "null",
            ),
            // 8
            IngredientAndMeasure(
              strIngredient: state.mealDetails?.strIngredient8 ?? "null",
              strMeasure: state.mealDetails?.strMeasure8 ?? "null",
            ),
            // 9
            IngredientAndMeasure(
              strIngredient: state.mealDetails?.strIngredient9 ?? "null",
              strMeasure: state.mealDetails?.strMeasure9 ?? "null",
            ),
            // 10
            IngredientAndMeasure(
              strIngredient: state.mealDetails?.strIngredient10 ?? "null",
              strMeasure: state.mealDetails?.strMeasure10 ?? "null",
            ),
            IngredientAndMeasure(
              strIngredient: state.mealDetails?.strIngredient11 ?? "null",
              strMeasure: state.mealDetails?.strMeasure11 ?? "null",
            ),
            IngredientAndMeasure(
              strIngredient: state.mealDetails?.strIngredient12 ?? "null",
              strMeasure: state.mealDetails?.strMeasure12 ?? "null",
            ),
            IngredientAndMeasure(
              strIngredient: state.mealDetails?.strIngredient13 ?? "null",
              strMeasure: state.mealDetails?.strMeasure13 ?? "null",
            ),
            IngredientAndMeasure(
              strIngredient: state.mealDetails?.strIngredient14 ?? "null",
              strMeasure: state.mealDetails?.strMeasure14 ?? "null",
            ),
            IngredientAndMeasure(
              strIngredient: state.mealDetails?.strIngredient15 ?? "null",
              strMeasure: state.mealDetails?.strMeasure15 ?? "null",
            ),
            IngredientAndMeasure(
              strIngredient: state.mealDetails?.strIngredient16 ?? "null",
              strMeasure: state.mealDetails?.strMeasure16 ?? "null",
            ),
            IngredientAndMeasure(
              strIngredient: state.mealDetails?.strIngredient17 ?? "null",
              strMeasure: state.mealDetails?.strMeasure17 ?? "null",
            ),
            IngredientAndMeasure(
              strIngredient: state.mealDetails?.strIngredient18 ?? "null",
              strMeasure: state.mealDetails?.strMeasure18 ?? "null",
            ),
            IngredientAndMeasure(
              strIngredient: state.mealDetails?.strIngredient19 ?? "null",
              strMeasure: state.mealDetails?.strMeasure19 ?? "null",
            ),
            IngredientAndMeasure(
              strIngredient: state.mealDetails?.strIngredient20 ?? "null",
              strMeasure: state.mealDetails?.strMeasure20 ?? "null",
            ),
          ],
        ),
      ),
    );
  }

  Column _shortInfo(DetailsFetch state) {
    return Column(
      children: [
        // Title
        Align(
          alignment: Alignment.centerLeft,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    state.mealDetails?.strMeal ?? "NULL",
                    style: TextStyle(
                      fontSize: 24.h,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      SavedMealModel model =
                          SavedMealModel(id: int.parse(widget.id));

                      DatabaseService.instance.create(model);
                    },
                    icon: Icon(state.saveIcon),
                  ),
                ],
              ),
              // Category
              SizedBox(height: 4.h),
              RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: "Category: ",
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 12.h,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    TextSpan(
                      text: "${state.mealDetails?.strCategory}",
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 12.h,
                      ),
                    ),
                  ],
                ),
              ),
              // Area
              SizedBox(height: 4.h),
              RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: "Area: ",
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 12.h,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    TextSpan(
                      text: "${state.mealDetails?.strArea}",
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 12.h,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _BuildTitle extends StatelessWidget {
  const _BuildTitle({
    required this.title,
  });

  final String title;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Text(
        title,
        style: TextStyle(
          fontSize: 18.h,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}

class IngredientAndMeasure extends StatelessWidget {
  const IngredientAndMeasure({
    super.key,
    required this.strIngredient,
    required this.strMeasure,
  });

  final String strIngredient;
  final String strMeasure;

  @override
  Widget build(BuildContext context) {
    final TextStyle customTextStyle = TextStyle(
      fontSize: 14.h,
      fontWeight: FontWeight.w500,
      color: Colors.white,
    );
    if (strIngredient != "null" && strIngredient != "") {
      return Padding(
        padding: EdgeInsets.symmetric(horizontal: 8.w),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              strIngredient,
              style: customTextStyle,
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
            ),
            Text(
              strMeasure,
              style: customTextStyle,
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
            ),
          ],
        ),
      );
    } else {
      return const SizedBox.shrink();
    }
  }
}

class CustomYoutubePlayer extends StatefulWidget {
  const CustomYoutubePlayer({super.key, required this.videoId});

  final String videoId;

  @override
  State<CustomYoutubePlayer> createState() => _CustomYoutubePlayerState();
}

class _CustomYoutubePlayerState extends State<CustomYoutubePlayer> {
  late YoutubePlayerController _controller;

  @override
  void initState() {
    super.initState();
    _controller = YoutubePlayerController(
      initialVideoId: widget.videoId,
      flags: const YoutubePlayerFlags(autoPlay: false, forceHD: false),
    );
  }

  @override
  Widget build(BuildContext context) {
    return YoutubePlayerBuilder(
      player: YoutubePlayer(
        controller: _controller,
      ),
      builder: (p0, p1) => ClipRRect(
        borderRadius: BorderRadius.circular(4.h),
        child: p1,
      ),
    );
  }
}
