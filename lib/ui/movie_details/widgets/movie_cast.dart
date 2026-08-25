import 'package:flutter/material.dart';
import 'package:movies_app/utils/app_colors.dart';
import 'package:movies_app/utils/app_styles.dart';
import 'package:movies_app/utils/size_utils.dart';

import '../../../api/model/movie_details/Cast.dart';

class MovieCast extends StatelessWidget {
  final List<Cast>? castList;

  const MovieCast({super.key, this.castList});

  @override
  Widget build(BuildContext context) {
    if (castList == null || castList!.isEmpty) return const SizedBox.shrink();
    return Directionality(
      textDirection: TextDirection.ltr,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Cast', style: AppStyles.bold24WhiteRoboto),
          SizedBox(height: context.height * 0.015),
          ListView.separated(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemCount: castList!.length,
            separatorBuilder: (context, index) =>
                SizedBox(height: context.height * 0.012),
            itemBuilder: (context, index) {
              final cast = castList![index];
              return Container(
                padding: EdgeInsetsGeometry.symmetric(
                  horizontal: context.width * 0.025,
                  vertical: context.height * 0.01,
                ),
                decoration: BoxDecoration(
                  color: AppColors.darkGrayColor,
                  borderRadius: BorderRadius.circular(context.width * 0.03),
                ),
                child: Row(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(context.width * 0.02),
                      child: cast.urlSmallImage != null
                          ? Image.network(
                              cast.urlSmallImage!,
                              width: context.width * 0.2,
                              height: context.height * 0.09,
                              fit: BoxFit.cover,
                              errorBuilder: (context, error, stackTrace) => Icon(
                                Icons.person,
                                color: AppColors.whiteColor,
                                size: context.width * 0.1,
                              ),
                            )
                          : Icon(
                              Icons.person,
                              color: AppColors.whiteColor,
                              size: context.width * 0.1,
                            ),
                    ),
                    SizedBox(width: context.width * 0.03),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Name : ${cast.name ?? ""}',
                            style: AppStyles.reg20WhiteRoboto,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          SizedBox(height: context.height * 0.006),
                          Text(
                            'Character : ${cast.characterName ?? ""}',
                            style: AppStyles.reg20WhiteRoboto,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
