import 'package:flutter/material.dart';
import 'package:movies_app/utils/app_styles.dart';
import '../utils/size_utils.dart';

class MainErrorWidget extends StatelessWidget {
  final String errorMessage ;
  final VoidCallback onPressed ;
  const MainErrorWidget({super.key , required this.errorMessage , required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        spacing: context.height*0.04,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(errorMessage ,
            style: AppStyles.reg20White60Inter,
          ),
          ElevatedButton(onPressed: onPressed,
              child: Text('Try Again',
                style: AppStyles.reg20BlackRoboto,
              ),
          )
        ],
      ),
    );
  }
}
