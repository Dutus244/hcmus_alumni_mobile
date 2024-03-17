import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hcmus_alumni_mobile/common/values/colors.dart';
import 'package:hcmus_alumni_mobile/pages/home_page/widgets/home_page_widget.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(),
      backgroundColor: AppColors.primaryBackground,
      body: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            buildCreatePostButton(),
            Container(
              height: 5.h,
              color: AppColors.primarySecondaryElement,
            ),
            listEvent(),
            Container(
              height: 5.h,
              color: AppColors.primarySecondaryElement,
            ),
          ],
        ),
      ),
    );
  }
}
