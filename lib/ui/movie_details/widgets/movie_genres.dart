import 'package:flutter/material.dart';
import 'package:movies_app/utils/app_colors.dart';
import 'package:movies_app/utils/app_styles.dart';
import 'package:movies_app/utils/size_utils.dart';

class MovieGenres extends StatelessWidget {
  final List<dynamic>? genres;

  const MovieGenres({super.key, required this.genres});

  @override
  Widget build(BuildContext context) {
    if (genres == null || genres!.isEmpty) return const SizedBox.shrink();
    final double itemWidth = (context.width - 32 - (context.width * 0.05)) / 3;
    return Directionality(
      textDirection: TextDirection.ltr,
      child: SizedBox(
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Genres', style: AppStyles.bold24WhiteRoboto),
            SizedBox(height: context.height * 0.012),
            Wrap(
              spacing: context.width * 0.025,
              runSpacing: context.height * 0.012,
              children: genres!.map((genre) {
                return Container(
                  width: itemWidth,
                  padding: EdgeInsets.symmetric(
                    vertical: context.height * 0.01,
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.darkGrayColor,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Center(child: Text(genre.toString(), style: AppStyles.reg16WhiteRoboto)),
                );
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }
}
