import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:task_one/app/questions_cycle/styles/fonts.dart';
import 'package:task_one/helpers/application_dimentions.dart';

import '../styles/colors.dart';

class AppBarCustom extends StatelessWidget {
  const AppBarCustom({super.key});

  @override
  Widget build(BuildContext context) {
    AppDimentions().appDimentionsInit(context);
    return Container(
      height: AppDimentions().availableheightWithAppBar * .20,
      width: AppDimentions().availableWidth,
      alignment: AlignmentDirectional.center,
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.only(
            bottomLeft: Radius.circular(50), bottomRight: Radius.circular(50)),
        gradient: const LinearGradient(
          colors: [purpleLight, purple],
          stops: [0.01, 0.8],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        boxShadow: [
          BoxShadow(
            offset: const Offset(0, 0),
            blurRadius: 7,
            blurStyle: BlurStyle.solid,
            color: black.withOpacity(.5),
          ),
        ],
      ),
      child: Text(
        'Stack Exchange Questions',
        style: mainTextStyle.copyWith(color: white, fontSize: 25.sp, fontWeight: FontWeight.bold),
      ),
    );
  }
}
