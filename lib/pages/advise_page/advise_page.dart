import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hcmus_alumni_mobile/pages/advise_page/widgets/advise_page_widget.dart';

import '../../common/values/colors.dart';

class AdvisePage extends StatefulWidget {
  const AdvisePage({super.key});

  @override
  State<AdvisePage> createState() => _AdvisePageState();
}

class _AdvisePageState extends State<AdvisePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(context),
      backgroundColor: AppColors.primaryBackground,
      body: Container(
        child: ListView(
            scrollDirection: Axis.vertical,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  buildCreatePostButton(),
                  Container(
                    height: 5.h,
                    color: AppColors.primarySecondaryElement,
                  ),
                  listPost(context),
                ],
              ),
            ]
        ),
      ),
    );
  }
}
