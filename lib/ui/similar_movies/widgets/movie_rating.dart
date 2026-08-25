import 'package:flutter/material.dart';
import 'package:movies_app/utils/app_colors.dart';
import 'package:movies_app/utils/app_styles.dart';
import 'package:movies_app/utils/size_utils.dart';

class MovieRating extends StatefulWidget {
  final double movieRating;
  final String ratingImage;

  const MovieRating({
    super.key,
    required this.movieRating,
    required this.ratingImage,
  });

  @override
  State<MovieRating> createState() => _MovieRatingState();
}

class _MovieRatingState extends State<MovieRating> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(
          horizontal: context.width*0.02,
          vertical: context.height*0.01
      ),
      padding: EdgeInsets.symmetric(
        horizontal: context.width*0.01,
        vertical: context.height*0.004
      ),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: AppColors.transparentBlackColor
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        spacing: context.width*0.02,
        children: [
          Text("${widget.movieRating}",
              style: AppStyles.reg16WhiteRoboto),
          Image.asset(widget.ratingImage,
          height: 15,
          width: 15,),
        ],
      ),
    );
  }
}
