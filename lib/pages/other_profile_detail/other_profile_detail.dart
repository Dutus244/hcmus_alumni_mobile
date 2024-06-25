import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../common/values/colors.dart';
import 'widgets/other_profile_detail_widget.dart';

class OtherProfileDetail extends StatefulWidget {
  const OtherProfileDetail({super.key});

  @override
  State<OtherProfileDetail> createState() => _OtherProfileDetailState();
}

class _OtherProfileDetailState extends State<OtherProfileDetail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(context),
      backgroundColor: AppColors.background,
      body:  otherProfileDetail(context),
    );
  }
}
