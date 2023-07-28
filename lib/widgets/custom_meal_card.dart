import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomMealCard extends StatelessWidget {
  const CustomMealCard({
    super.key,
    this.onTap,
    required this.title,
    required this.subtitle,
    required this.id,
    required this.image,
  });

  final void Function()? onTap;
  final String title;
  final String subtitle;
  final String image;
  final String id;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 8.h),
        child: ListTile(
          onTap: onTap,
          leading: ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Image.network(image),
          ),
          title: Text(
            title,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 16.h,
            ),
          ),
          subtitle: Text(subtitle),
        ),
      ),
    );
  }
}
