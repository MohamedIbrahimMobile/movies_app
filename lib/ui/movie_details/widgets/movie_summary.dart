import 'package:flutter/material.dart';
import 'package:movies_app/utils/app_styles.dart';
import 'package:movies_app/utils/size_utils.dart';

class MovieSummary extends StatelessWidget {
  final String? summary ;

   const MovieSummary ({super.key, required this.summary});

  @override
  Widget build(BuildContext context) {
    if (summary == null || summary!.isEmpty) return const SizedBox.shrink();

    return Directionality(
      textDirection: TextDirection.ltr,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Summary',
            style: AppStyles.bold24WhiteRoboto,
          ),
          SizedBox(
            height: context.height*0.013,
          ),
          Text(
            summary!,
            style: AppStyles.reg16WhiteRoboto,
          )
        ],
      ),
    ) ;
  }
}
